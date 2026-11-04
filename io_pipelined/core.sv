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

mem_params_t imem_params;
assign imem_params.op = MEM_OP_READ;
assign imem_params.access_size = MEM_ACCESS_WORD;
assign imem_params.read_unsigned = 1;

logic stall_F_D;
logic pc_input_sel;

reg_file_read_params_t reg_file_read;
reg_file_write_params_t reg_file_write;

branch_compare_params_t branch_compare_params;

/* Fetch stage */
arch_reg PC_out;
arch_reg imem_out;
arch_reg new_PC_in;
arch_reg instr;
mem imem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(PC_out),
    .data_in(),
    .params(imem_params),
    /* Outputs */
    .data_out(imem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

fetch fetch_inst(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .data_in(imem_out),
    .set_PC(pc_input_sel),
    .new_PC(new_PC_in),
    .stall_PC(stall_F_D),
    /* Outputs */
    .PC_out(PC_out),
    .instr(instr)
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
imm_type_t imm_type;
decode_D decode_D_inst(
    /* Inputs */
    .instr(F_D_instr),
    .X_stage_instr(D_X_instr),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .reg_file_read_params(reg_file_read),
    .imm_type(imm_type),
    .stall_F_D(stall_F_D)
);

arch_reg rd_in;
arch_reg rs1_out, rs2_out;
reg_file reg_file_inst(
    /* Inputs */
    .clock(clock),
    .read_params(reg_file_read),
    .write_params(reg_file_write),
    .data_rd(rd_in), //decode, from writeback stage?
    /* Outputs */
    .data_rs1(rs1_out),
    .data_rs2(rs2_out),
    .registers_out(registers)
);

arch_reg imm_out;
imm_gen imm_gen_inst(
    /* Inputs */
    .instr(F_D_instr[31:7]),
    .imm_type(imm_type),
    /* Outputs */
    .immediate_out(imm_out)
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

/* Forwarding logic for rs1 and rs2 */
exec_reg_forward_t rs1_source, rs2_source;
arch_reg rs1_forwarded, rs2_forwarded;
always_comb begin
    case (rs1_source)
        /* Forward from the memory stage */
        FROM_MEM_STAGE: rs1_forwarded = X_M_exec_unit_out;
        /* Forward from the writeback stage */
        FROM_WB_STAGE: rs1_forwarded = write_back_out;
        default: rs1_forwarded = D_X_rs1;
    endcase

    case (rs2_source)
        /* Forward from the memory stage */
        FROM_MEM_STAGE: rs2_forwarded = X_M_exec_unit_out;
        /* Forward from the writeback stage */
        FROM_WB_STAGE: rs2_forwarded = write_back_out;
        default: rs2_forwarded = D_X_rs2;
    endcase
end

/* Execute stage */
pc_input_sel_t branch_result;
exec_unit_params_t exec_unit_params;
logic dmem_in_sel;
decode_X decode_X_instr(
    /* Inputs */
    .reset(reset),
    .instr(D_X_instr),
    .branch_result(branch_result),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .rs1_source(rs1_source),
    .rs2_source(rs2_source),
    .exec_unit_params(exec_unit_params),
    .dmem_in_sel(dmem_in_sel),
    .pc_input_sel(pc_input_sel),
    .flush_F_D(flush_F_D),
    .branch_cmp_params(branch_compare_params)
);

branch_compare branch_compare_inst(
    /* Inputs */
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .params(branch_compare_params),
    /* Outputs */
    .branch_result(branch_result)
);

arch_reg exec_unit_out;
assign new_PC_in = exec_unit_out;
exec_unit exec_unit_inst(
    // inputs
    .pc(D_X_PC_out),
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .imm_val(D_X_imm),
    .params(exec_unit_params),

    // outputs
    .exec_out(exec_unit_out)
);

// logic for bypassing W to X for data in,
// useful in case of ALU-Store-Store case
arch_reg dmem_in;
always_comb begin
    unique case(dmem_in_sel)
        1'b0: dmem_in = D_X_rs2;
        1'b1: dmem_in = write_back_out;
    endcase
end

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
mem_params_t dmem_params;
logic dmem_write_sel;
decode_M decode_M_inst(
    /* Inputs */
    .reset(reset),
    .instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .dmem_params(dmem_params),
    .mem_write_sel(dmem_write_sel)
);

// data in selection from bypass or reg
arch_reg dmem_data_in;
always_comb begin
    unique case (dmem_write_sel)
        1'b0: dmem_data_in = X_M_dmem_in;
        1'b1: dmem_data_in = write_back_out;
    endcase
end

arch_reg dmem_out;
mem dmem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(X_M_exec_unit_out),
    .data_in(dmem_data_in),
    .params(dmem_params),
    /* Outputs */
    .data_out(dmem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

// The WB stage consists more of just connecting to reg file, so most
// of it can be done from this higher level, and the module exists to
// implement a mux to determine which value to write back

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
write_back_select_t write_back_sel;
decode_W decode_W_inst(
    /* Inputs */
    .reset(reset),
    .instr(M_W_instr),
    /* Outputs */
    .reg_file_write_params(reg_file_write),
    .reg_store_sel(write_back_sel)
);

arch_reg write_back_out; // could change to rd_in directly
write_back write_back_inst(
    //inputs
    .mem_in(M_W_dmem_out),
    .alu_in(M_W_exec_unit_out),
    .pc_in(M_W_PC_out),
    .write_back_sel(write_back_sel),

    // outputs
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

