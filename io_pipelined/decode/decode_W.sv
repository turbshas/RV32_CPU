import instructions_pkg::instr_packet_t;
import instructions_pkg::arch_reg_id;
import instructions_pkg::opcode_t;

module decode_W
(
    input logic reset,
    input instr_packet_t instr,
    output reg_file_write_params_t reg_file_write_params,
    output write_back_select_t reg_store_sel
);

// TODO: why is reg store sel assigned in the memory stage??
decode_write_back decode_write_back(
    .reset(reset),
    .instr(instr),
    .reg_file_write_params(reg_file_write_params),
    .reg_store_sel(reg_store_sel)
);

endmodule

