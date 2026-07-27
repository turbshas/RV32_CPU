import instructions_pkg::opcode_t;
import instructions_pkg::OPCODE_STORE;
import instructions_pkg::funct3_t;
import mem_pkg::mem_params_t;
import mem_pkg::MEM_OP_WRITE;
import mem_pkg::MEM_OP_READ;
import mem_pkg::mem_access_size_t;

module decode_mem
(
    input logic reset,
    input opcode_t opcode,
    input funct3_t funct3,
    output mem_params_t mem_params
);

logic is_write_instr;
logic op_internal;
logic[1:0] access_size_internal;

assign is_write_instr = opcode == OPCODE_STORE;

// Memory operation (R/W).
// Memory is R/!W (R = 1, W = 0).
assign op_internal = reset | !is_write_instr;
assign mem_params.op = op_internal ? MEM_OP_READ : MEM_OP_WRITE;

// Access and whether to read unsigned.
// Always pass through, if not a load/store instr we'll just ignore the result.
assign mem_params.access_size = mem_access_size_t'(funct3[1:0]);
assign mem_params.read_unsigned = funct3[2];

endmodule
