module core
(
    input wire clock,
    input wire reset,
    output wire[31:0] pc_out,
    output wire[31:0] instr_out,
    output reg[31:0] registers[32]
);

reg[31:0] PC_out;
reg[31:0] imem_out;
mem mem_inst(
    .clock(clock),
    .address(PC_out),
    .data_in(),
    .data_out(imem_out),
    .read_write(1),
    .enable(1)
);

reg pc_input_sel;
reg[31:0] new_PC_in;
reg[31:0] instr;
fetch fetch_inst(
    .clock(clock),
    .reset(reset),
    .data_in(imem_out),
    .set_PC(pc_input_sel),
    .new_PC(new_PC_in),
    .PC_out(PC_out),
    .instr(instr)
);

reg[4:0] rd_addr, rs1_addr, rs2_addr;
reg[31:0] rd_in, rs1_out, rs2_out;
reg reg_file_WE;
reg_file reg_file_inst(
    .clock(clock),
    .addr_rs1(rs1_addr),
    .addr_rs2(rs2_addr),
    .addr_rd(rd_addr),
    .data_rd(rd_in),
    .data_rs1(rs1_out),
    .data_rs2(rs2_out),
    .write_enable(reg_file_WE),
    .registers_out(registers)
);

reg branch_cmp_unsigned_in;
reg branch_cmp_eq_out, branch_cmp_lt_out;
branch_compare branch_compare_inst(
    .rs1(rs1_out),
    .rs2(rs2_out),
    .unsigned_cmp(branch_cmp_unsigned_in),
    .less_than(branch_cmp_lt_out),
    .equal(branch_cmp_eq_out)
);

reg[2:0] imm_type;
reg[31:0] imm_out;
imm_gen imm_gen_inst(
    .instr(instr[31:7]),
    .imm_type(imm_type),
    .immediate_out(imm_out)
);

reg[3:0] exec_op;
reg[31:0] exec_unit_out;
assign new_PC_in = exec_unit_out;
reg operand1_sel;
reg operand2_sel;
// TODO in PD5: chnage to support bypassing
exec_unit exec_unit_inst(
    // inputs
    .pc(PC_out),
    .rs1(rs1_out),
    .rs2(rs2_out),
    .operand1_sel(operand1_sel),
    .operand2_sel(operand2_sel),
    .imm_val(imm_out),
    .exec_op(exec_op),

    // outputs
    .exec_out(exec_unit_out)
);

wire[31:0] dmem_in;
assign dmem_in = rs2_out;
reg[31:0] dmem_out;
reg dmem_RW;
reg[1:0] dmem_access_size;
reg dmem_load_unsigned;
dmem dmem_inst(
    .clock(clock),
    .address(exec_unit_out),
    .data_in(dmem_in),
    .data_out(dmem_out),
    .read_write(dmem_RW),
    .access_size(dmem_access_size),
    .unsigned_access(dmem_load_unsigned)
);

reg[1:0] write_back_sel;
reg[31:0] write_back_out; // could change to rd_in directly
assign rd_in = write_back_out;
write_back write_back_inst(
    //inputs
    .mem_in(dmem_out),
    .alu_in(exec_unit_out),
    .pc_in(PC_out),
    .write_back_sel(write_back_sel),
    
    // outputs
    .write_back_out(write_back_out)
);
// The WB stage consists more of just connecting to reg file, so most
// of it can be done from this higher level, and the module exsits to 
// implement a mux to determine which value to write back

decode decode_inst(
    .clock(clock),
    .reset(reset),
    .instr(instr),
    .branch_cmp_eq(branch_cmp_eq_out),
    .branch_cmp_lt(branch_cmp_lt_out),
    .exec_op(exec_op),
    .reg_write_en(reg_file_WE),
    .reg_store_sel(write_back_sel),
    .rd(rd_addr),
    .rs1(rs1_addr),
    .rs2(rs2_addr),
    .imm_type(imm_type),
    .operand1_sel(operand1_sel),
    .operand2_sel(operand2_sel),
    .pc_input_sel(pc_input_sel),
    .mem_r_w(dmem_RW),
    .mem_access_size(dmem_access_size),
    .mem_load_unsigned(dmem_load_unsigned),
    .branch_cmp_unsigned(branch_cmp_unsigned_in)
);

assign pc_out = PC_out;
assign instr_out = instr;
endmodule

