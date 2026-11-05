import instructions_pkg::arch_reg;
import mem_pkg::mem_params_t;
import mem_pkg::MEM_ACCESS_WORD;
import mem_pkg::MEM_OP_READ;
import io_pipelined_pkg::exec_reg_forward_t;
import io_pipelined_pkg::FROM_MEM_STAGE;
import io_pipelined_pkg::FROM_WB_STAGE;
import imm_gen_pkg::imm_type_t;
import write_back_pkg::write_back_select_t;

`define NOP_INSTR 32'h00000013

module core
(
    input wire clock,
    input wire reset,
    output arch_reg instr_out_F,
    output arch_reg instr_out_D,
    output arch_reg instr_out_X,
    output arch_reg instr_out_M,
    output arch_reg instr_out_W,
    output arch_reg pc,
    output arch_reg registers[32],
    output arch_reg rd,
    output arch_reg_id rd_addr,
    output logic rd_write,

    input wire setup_write,
    input arch_reg setup_address,
    input arch_reg setup_data_in
);
/* Pipeline registers */
arch_reg F_D_PC_out;
arch_reg F_D_instr;

arch_reg D_X_PC_out;
arch_reg D_X_instr;
arch_reg D_X_rs1;
arch_reg D_X_rs2;
arch_reg D_X_imm;

arch_reg X_M_PC_out;
arch_reg X_M_instr;
arch_reg X_M_exec_unit_out;
arch_reg X_M_dmem_in;

arch_reg M_W_instr;
arch_reg M_W_dmem_out;
arch_reg M_W_exec_unit_out;
arch_reg M_W_PC_out;

logic stall_F_D;
logic pc_input_sel;

reg_file_write_params_t reg_file_write;

/* Fetch stage */
arch_reg PC_out;
arch_reg imem_out;
arch_reg new_PC_in;
arch_reg instr;
stage_F stage_F_inst(
    .clock(clock),
    .reset(reset),
    .pc_input_sel(pc_input_sel),
    .new_PC_in(new_PC_in),
    .stall_F_D(stall_F_D),
    .PC_out(PC_out),
    .imem_out(imem_out),
    .instr(instr),

    .setup_address(setup_address),
    .setup_data_in(setup_data_in),
    .setup_write(setup_write)
);

logic flush_F_D;
always_ff @(posedge clock) begin
    if (reset || flush_F_D)
        F_D_instr <= `NOP_INSTR;
    else begin
        if (! stall_F_D) begin
            F_D_PC_out <= PC_out;
            F_D_instr <= instr;
        end
    end
end

/* Decode stage */
arch_reg rd_in;
arch_reg rs1_out;
arch_reg rs2_out;
arch_reg imm_out;

stage_D stage_D_inst(
    .clock(clock),
    .F_D_instr(F_D_instr),
    .D_X_instr(D_X_instr),
    .X_M_instr(X_M_instr),
    .M_W_instr(M_W_instr),
    .rd_in(rd_in),
    .reg_file_write(reg_file_write),
    .rs1_out(rs1_out),
    .rs2_out(rs2_out),
    .imm_out(imm_out),
    .stall_F_D(stall_F_D),

    .registers(registers)
);

always_ff @(posedge clock) begin
    if (reset || stall_F_D || flush_F_D)
        D_X_instr <= `NOP_INSTR;
    else begin
        D_X_PC_out <= F_D_PC_out;
        D_X_instr <= F_D_instr;
        D_X_rs1 <= rs1_out;
        D_X_rs2 <= rs2_out;
        D_X_imm <= imm_out;
    end
end

/* Execute stage */
arch_reg dmem_in;
arch_reg exec_unit_out;
assign new_PC_in = exec_unit_out;

stage_X stage_X_inst(
    .reset(reset),
    .D_X_PC_out(D_X_PC_out),
    .D_X_instr(D_X_instr),
    .X_M_instr(X_M_instr),
    .M_W_instr(M_W_instr),
    .X_M_exec_unit_out(X_M_exec_unit_out),
    .write_back_out(write_back_out),
    .D_X_rs1(D_X_rs1),
    .D_X_rs2(D_X_rs2),
    .D_X_imm(D_X_imm),

    .pc_input_sel(pc_input_sel),
    .flush_F_D(flush_F_D),
    .exec_unit_out(exec_unit_out),
    .dmem_in(dmem_in)
);

always_ff @(posedge clock) begin
    if (reset)
        X_M_instr <= `NOP_INSTR;
    else begin
        X_M_PC_out <= D_X_PC_out;
        X_M_instr <= D_X_instr;
        X_M_exec_unit_out <= exec_unit_out;
        X_M_dmem_in <= dmem_in;
    end
end

/* Memory stage */
arch_reg dmem_out;
stage_M stage_M_inst(
    .clock(clock),
    .reset(reset),
    .X_M_instr(X_M_instr),
    .M_W_instr(M_W_instr),
    .X_M_exec_unit_out(X_M_exec_unit_out),
    .X_M_dmem_in(X_M_dmem_in),
    .write_back_out(write_back_out),

    .dmem_out(dmem_out),

    // Test stuff
    .setup_address(setup_address),
    .setup_data_in(setup_data_in),
    .setup_write(setup_write)
);

always_ff @(posedge clock) begin
    if (reset)
        M_W_instr <= `NOP_INSTR;
    else begin
        M_W_instr <= X_M_instr;
        M_W_dmem_out <= dmem_out;
        M_W_exec_unit_out <= X_M_exec_unit_out;
        M_W_PC_out <= X_M_PC_out;
    end
end

/* Writeback stage */
arch_reg write_back_out; // could change to rd_in directly
stage_W stage_W_inst(
    .reset(reset),
    .M_W_instr(M_W_instr),
    .M_W_dmem_out(M_W_dmem_out),
    .M_W_exec_unit_out(M_W_exec_unit_out),
    .M_W_PC_out(M_W_PC_out),
    .reg_file_write(reg_file_write),
    .write_back_out(write_back_out)
);

assign rd_in = write_back_out;

assign instr_out_F = instr;
assign instr_out_D = F_D_instr;
assign instr_out_X = D_X_instr;
assign instr_out_M = X_M_instr;
assign instr_out_W = M_W_instr;
assign pc = M_W_PC_out;
assign rd = write_back_out;
assign rd_addr = reg_file_write.addr_rd;
assign rd_write = reg_file_write.write_enable;
endmodule

