import instructions_pkg::instr_packet;
import instructions_pkg::system_instr_params;
import csr_pkg::csr_params_t;
import csr_pkg::csr_funct3_t;
import csr_pkg::csr_write_func;
import csr_pkg::csr_input_sel;

// This is expected to be placed somewhere in writeback,
// so should have a register value already.
module decode_csr
(
    input instr_packet instr,
    output csr_params_t csr_params
);

logic is_system_instr;
system_instr_params system_params;
csr_funct3_t csr_funct3;
always_comb begin
    is_system_instr = instr.opcode == OPCODE_SYSTEM;
    system_params = instr.params.system;
    csr_funct3 = instr.params.system.funct3;
end

csr_write_func write_func;
csr_input_sel write_select;
always_comb begin
    write_func = csr_funct3.write_func;
    write_select = csr_funct3.input_select;
end

logic read_dest_is_zero;
logic write_source_is_zero;
logic is_csr_instr;
always_comb begin
    read_dest_is_zero = system_params.rd == `REGISTER_X0;
    write_source_is_zero = system_params.rs1_or_uimm == `REGISTER_X0;
    is_csr_instr = is_system_instr & write_func != CSR_WRITE_NONE;
end

always_comb begin
    // If CSR write is RW and read destination is zero -> no read occurs.
    csr_params.read_enable = is_csr_instr & (write_func != CSR_WRITE_RW | !read_dest_is_zero);
    // CSR write is RS/RC and write source is zero -> no write occurs.
    csr_params.write_enable = is_csr_instr & (write_func == CSR_WRITE_RW | !write_source_is_zero);

    csr_params.input_select = write_select;
    csr_params.write_func = csr_funct3.write_func;
end

endmodule
