`include "constants.sv"
`include "instructions.sv"

`include "csr_inc.sv"

// This is expected to be placed somewhere in writeback,
// so should have a register value already.
module decode
(
    input instr_packet instr,
    input arch_reg rs1,
    output csr_params csr_params
);

logic is_system_instr;
assign is_system_instr = instr.opcode == OPCODE_SYSTEM;
system_instr_params system_params;
assign system_params = instr.params.system;

csr_write_func write_func;
assign write_func = system_params.csr_funct3.write_func;
csr_input_sel write_select;
assign write_select = system_params.csr_funct3.input_select;

logic read_dest_is_zero;
assign read_dest_is_zero = system_params.rd == REGISTER_X0;
logic write_source_is_zero;
assign write_source_is_zero = system_params.rs1_or_uimm == REGISTER_X0;
logic is_csr_instr;
assign is_csr_instr = is_system_instr & write_func != CSR_WRITE_NONE;

always_comb begin
    // If CSR write is RW and read destination is zero -> no read occurs.
    csr_params.read_enable = is_csr_instr & (write_func != CSR_WRITE_RW | !read_dest_is_zero);
    // CSR write is RS/RC and write source is zero -> no write occurs.
    csr_params.write_enable = is_csr_instr & (write_func == CSR_WRITE_RW | !write_source_is_zero);

    csr_params.input_select = write_select;
    csr_params.write_func = system_params.csr_funct3.write_func;
    
    case (write_select)
        CSR_SEL_RS1: csr_params.write_value = rs1;
        CSR_SEL_IMM: csr_params.write_value = {27'b0, system_params.rs1_or_uimm};
        default: csr_params.write_value = rs1;
    endcase
end

endmodule