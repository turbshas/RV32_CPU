`define NOP_INSTR 32'h00000013
module core
(
    input wire clock,
    input wire reset,
    output wire[31:0] instr_out,
    output reg[31:0] registers[32],

    input wire setup_write,
    input wire[31:0] setup_address,
    input wire[31:0] setup_data_in
);
/* Pipeline registers */
reg[31:0] F_D_PC_out;
reg[31:0] F_D_instr;

reg[31:0] D_X_PC_out;
reg[31:0] D_X_instr;
reg[31:0] D_X_rs1;
reg[31:0] D_X_rs2;
reg[31:0] D_X_imm;

reg[31:0] X_M_PC_out;
reg[31:0] X_M_instr;
reg[31:0] X_M_exec_unit_out;
reg[31:0] X_M_dmem_in;

reg[31:0] M_W_instr;
reg[31:0] M_W_writeback_out;

/* Fetch stage */
reg[31:0] PC_out;
reg[31:0] imem_out;
mem imem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(PC_out),
    .data_in(),
    .read_write(1),
    .access_size(`ACCESS_SIZE_WORD),
    .unsigned_access(1),
    /* Outputs */
    .data_out(imem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

reg stall_F_D;
reg pc_input_sel;
reg[31:0] new_PC_in;
reg[31:0] instr;
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

reg flush_F_D;
always @(posedge clock) begin
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
reg[4:0] rs1_addr, rs2_addr;
reg[2:0] imm_type;
decode_D decode_D_inst(
    /* Inputs */
    .instr(F_D_instr),
    .X_stage_instr(D_X_instr),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .rs1(rs1_addr),
    .rs2(rs2_addr),
    .imm_type(imm_type),
    .stall_F_D(stall_F_D)
);

reg reg_file_WE;
reg[4:0] rd_addr;
reg[31:0] rd_in;
reg[31:0] rs1_out, rs2_out;
reg_file reg_file_inst(
    /* Inputs */
    .clock(clock),
    .addr_rs1(rs1_addr),
    .addr_rs2(rs2_addr),
    .addr_rd(rd_addr), //decode, from writeback stage?
    .data_rd(rd_in), //decode, from writeback stage?
    .write_enable(reg_file_WE), //decode, from writeback stage?
    /* Outputs */
    .data_rs1(rs1_out),
    .data_rs2(rs2_out),
    .registers_out(registers)
);

reg[31:0] imm_out;
imm_gen imm_gen_inst(
    /* Inputs */
    .instr(F_D_instr[31:7]),
    .imm_type(imm_type),
    /* Outputs */
    .immediate_out(imm_out)
);

always @(posedge clock) begin
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
reg[1:0] rs1_source, rs2_source;
reg[31:0] rs1_forwarded, rs2_forwarded;
always @(*) begin
    if (rs1_source == 2'b10) begin
        rs1_forwarded = X_M_exec_unit_out; /* Forward from the memory stage */
    end else if (rs1_source == 2'b11) begin
        rs1_forwarded = M_W_writeback_out; /* Forward from the writeback stage */
    end else begin
        rs1_forwarded = D_X_rs1;
    end

    if (rs2_source == 2'b10) begin
        rs2_forwarded = X_M_exec_unit_out; /* Forward from the memory stage */
    end else if (rs2_source == 2'b11) begin
        rs2_forwarded = M_W_writeback_out; /* Forward from the writeback stage */
    end else begin
        rs2_forwarded = D_X_rs2;
    end
end

/* Execute stage */
reg branch_cmp_eq, branch_cmp_lt, branch_cmp_unsigned;
reg[3:0] exec_op;
reg operand1_sel, operand2_sel;
reg dmem_in_sel;
decode_X decode_X_instr(
    /* Inputs */
    .instr(D_X_instr),
    .branch_cmp_eq(branch_cmp_eq),
    .branch_cmp_lt(branch_cmp_lt),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .exec_op(exec_op),
    .rs1_source(rs1_source),
    .rs2_source(rs2_source),
    .operand1_sel(operand1_sel),
    .operand2_sel(operand2_sel),
    .dmem_in_sel(dmem_in_sel),
    .pc_input_sel(pc_input_sel),
    .flush_F_D(flush_F_D),
    .branch_cmp_unsigned(branch_cmp_unsigned)
);

branch_compare branch_compare_inst(
    /* Inputs */
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .unsigned_cmp(branch_cmp_unsigned),
    /* Outputs */
    .less_than(branch_cmp_lt),
    .equal(branch_cmp_eq)
);

reg[31:0] exec_unit_out;
assign new_PC_in = exec_unit_out;
exec_unit exec_unit_inst(
    // inputs
    .pc(D_X_PC_out),
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .imm_val(D_X_imm),
    .operand1_sel(operand1_sel), //decode
    .operand2_sel(operand2_sel), //decode
    .exec_op(exec_op), //decode

    // outputs
    .exec_out(exec_unit_out)
);

// logic for bypassing W to X for data in,
// useful in case of ALU-Store-Store case
reg [31:0] dmem_in;
always @(*) begin
    case(dmem_in_sel)
        1'b0: dmem_in = D_X_rs2;
        1'b1: dmem_in = M_W_writeback_out;
    endcase
end

always @(posedge clock) begin
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
reg dmem_RW;
reg dmem_write_sel;
reg[1:0] dmem_access_size;
reg dmem_load_unsigned;
reg[1:0] write_back_sel;
decode_M decode_M_inst(
    /* Inputs */
    .instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .mem_r_w(dmem_RW),
    .mem_access_size(dmem_access_size),
    .mem_load_unsigned(dmem_load_unsigned),
    .mem_write_sel(dmem_write_sel),
    .reg_store_sel(write_back_sel)
);

// data in selection from bypass or reg
reg [31:0] dmem_data_in;
always @(*) begin
    case (dmem_write_sel)
        1'b0: dmem_data_in = X_M_dmem_in;
        1'b1: dmem_data_in = M_W_writeback_out;
    endcase
end

reg[31:0] dmem_out;
mem dmem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(X_M_exec_unit_out),
    .data_in(dmem_data_in),
    .read_write(dmem_RW),
    .access_size(dmem_access_size),
    .unsigned_access(dmem_load_unsigned),
    /* Outputs */
    .data_out(dmem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

reg[31:0] write_back_out; // could change to rd_in directly
write_back write_back_inst(
    //inputs
    .mem_in(dmem_out),
    .alu_in(X_M_exec_unit_out),
    .pc_in(X_M_PC_out),
    .write_back_sel(write_back_sel),

    // outputs
    .write_back_out(write_back_out)
);
// The WB stage consists more of just connecting to reg file, so most
// of it can be done from this higher level, and the module exsits to 
// implement a mux to determine which value to write back

always @(posedge clock) begin
    if (reset)
        M_W_instr <= `NOP_INSTR;
    else begin
        M_W_instr <= X_M_instr;
        M_W_writeback_out <= write_back_out;
    end
end

/* Writeback stage */
decode_W decode_W_inst(
    /* Inputs */
    .instr(M_W_instr),
    /* Outputs */
    .reg_write_en(reg_file_WE), /* Declared in Decode stage */
    .rd(rd_addr) /* Declared in Decode stage */
);

assign rd_in = M_W_writeback_out;

assign instr_out = M_W_instr;
endmodule

