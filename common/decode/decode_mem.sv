import instructions_pkg::opcode_t;
import instructions_pkg::funct3_t;
import mem_pkg::mem_params_t;

module decode_mem
(
    input logic reset,
    input opcode_t opcode,
    input funct3_t funct3,
    output mem_params_t mem_params
);

logic is_write_instr;
always_comb begin
    is_write_instr = opcode == OPCODE_STORE;
end

always_comb begin
    // Memory operation (R/W).
    // Memory is R/!W (R = 1, W = 0).
    mem_params.op = reset | !is_write_instr;
    // Access and whether to read unsigned.
    // Always pass through, if not a load/store instr we'll just ignore the result.
    mem_params.access_size = funct3[1:0];
    mem_params.read_unsigned = funct3[2];
end

endmodule
