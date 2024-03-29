import instructions_pkg::instr_packet;
import instructions_pkg::OPCODE_LUI;
import instructions_pkg::OPCODE_SYSTEM;
import csr_pkg::csr_funct3_t;
import csr_pkg::CSR_SEL_IMM;
import reg_file_pkg::reg_file_read_params_t;

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
    // LUI and CSRxxI instructions need rs1 need to be set to x0.
    // Both have their immediates added to 0.
    if (is_lui_instr | is_csri_instr)
        params.addr_rs1 = `REGISTER_X0;
    else
        params.addr_rs1 = instr.params.r_instr.rs1;

    params.addr_rs2 = instr.params.r_instr.rs2;
end

endmodule
