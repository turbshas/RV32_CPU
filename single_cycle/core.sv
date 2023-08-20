`include "constants.sv"
`include "instructions.sv"

`include "branch_compare_inc.sv"
`include "csr_inc.sv"
`include "exec_unit_inc.sv"
`include "imm_gen_inc.sv"
`include "mem_inc.sv"

module core
(
    input logic clock,
    input logic reset,
    output arch_reg pc_out,
    output instr_packet instr_out,
    output arch_reg registers[32],

    input logic setup_write,
    input arch_reg setup_address,
    input arch_reg setup_data_in
);

arch_reg PC_out;
arch_reg imem_out;
mem_params_t imem_params;
always_comb begin
    imem_params.load_unsigned = 1;
    imem_params.access_size = MEM_ACCESS_WORD;
    imem_params.op = MEM_OP_READ;
end
mem imem(
    .clock(clock),
    .reset(reset),
    .address(PC_out),
    .data_in(),
    .data_out(imem_out),
    .params(imem_params)

    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

logic pc_input_sel;
arch_reg new_PC_in;
arch_reg instr;
fetch fetch_inst(
    .clock(clock),
    .reset(reset),
    .data_in(imem_out),
    .set_PC(pc_input_sel),
    .new_PC(new_PC_in),
    .stall_PC(),
    .PC_out(PC_out),
    .instr(instr)
);

reg_file_read_params_t reg_file_read_params;
reg_file_write_params_t reg_file_write_params;
arch_reg rd_in, rs1_out, rs2_out;
reg_file reg_file_inst(
    .clock(clock),
    .read_params(reg_file_read_params),
    .write_params(reg_file_write_params),
    .data_rd(rd_in),
    .data_rs1(rs1_out),
    .data_rs2(rs2_out),
    .registers_out(registers)
);

logic branch_result;
branch_compare_params_t branch_compare_params;
branch_compare branch_compare_inst(
    .rs1(rs1_out),
    .rs2(rs2_out),
    .params(branch_compare_params),
    .branch_result(branch_result)
);

imm_type_t imm_type;
arch_reg imm_out;
imm_gen imm_gen_inst(
    .instr(instr.params),
    .imm_type(imm_type),
    .immediate_out(imm_out)
);

exec_unit_params exec_params;
arch_reg exec_unit_out;
assign new_PC_in = exec_unit_out;
// TODO in PD5: chnage to support bypassing
exec_unit exec_unit_inst(
    // inputs
    .pc(PC_out),
    .rs1(rs1_out),
    .rs2(rs2_out),
    .imm_val(imm_out),
    .params(exec_params)

    // outputs
    .exec_out(exec_unit_out)
);

arch_reg dmem_in;
assign dmem_in = rs2_out;
arch_reg dmem_out;
mem_params_t mem_params;
mem dmem(
    .clock(clock),
    .reset(reset),
    .address(exec_unit_out),
    .data_in(dmem_in),
    .data_out(dmem_out),
    .params(mem_params),

    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

csr_params csr_params;
arch_reg csr_out;
logic csr_illegal_instr;
csr csr(
    .clock(clock),
    .reset(reset),
    .instr_retired(0), // TODO: idk? should this happen elsewhere?
    .priv_mode(2'b00), // TODO: used to check if CSR address is allowed - NOTE: User CSRs always allowed

    .reg_in(exec_unit_out),
    .params(csr_params),
    .read_value(csr_out),
    /** Can be either: requested CSR doesn't exist OR not allowed given current privilege level */
    .illegal_instr_exception(csr_illegal_instr)
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

    .reg_file_read_params(reg_file_read_params),
    .reg_file_write_params(reg_file_write_params),

    .imm_type(imm_type),
    .exec_params(exec_params)

    .branch_result(branch_result),
    .branch_compare_params(branch_compare_params),

    .reg_store_sel(write_back_sel),
    .pc_input_sel(pc_input_sel),

    .mem_params(mem_params),
    .csr_params(csr_params)
);

assign pc_out = PC_out;
assign instr_out = instr;
endmodule

