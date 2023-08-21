`include "instructions.sv"

`include "csr_inc.sv"
`include "reg_file_inc.sv"

module decode_reg_file
(
    input instr_packet instr,
    output reg_file_read_params_t params
);

csr_funct3_t csr_funct3;
always_comb begin
    csr_funct3 = instr.params.system.funct3;
end

logic is_lui_instr;
logic is_system_instr;
logic is_csr_imm_input;
always_comb begin
    is_lui_instr = instr.opcode == OPCODE_LUI;
    is_system_instr = instr.opcode == OPCODE_SYSTEM;
    is_csr_imm_input = csr_funct3.input_select == CSR_SEL_IMM;
end

logic is_csri_instr;
always_comb begin
    is_csri_instr = is_system_instr & is_csr_imm_input;
end

always_comb begin
    rd     = instr.params.r_instr.rd;
    rs2    = instr.params.r_instr.rs2;

    // LUI and CSRxxI instructions need rs1 need to be set to x0.
    // Both have their immediates added to 0.
    if (is_lui_instr | is_csri_instr)
        rs1 = `REGISTER_X0;
    else
        rs1 = instr.params.r_instr.rs1;
end

endmodule
