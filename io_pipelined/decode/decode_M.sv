import instructions_pkg::arch_reg_id;
import instructions_pkg::opcode_t;
import instructions_pkg::funct3_t;
import instructions_pkg::instr_packet_t;
import mem_pkg::mem_params_t;
import mem_pkg::mem_access_size_t;
import mem_pkg::MEM_ACCESS_BYTE;
import mem_pkg::MEM_OP_READ;
import mem_pkg::MEM_OP_WRITE;

module decode_M
(
    input logic reset,
    input instr_packet_t instr,
    input instr_packet_t W_stage_instr,
    output mem_params_t dmem_params,
    output logic mem_write_sel
);

opcode_t opcode;
funct3_t funct3;
arch_reg_id instr_rs2;

assign opcode = instr.opcode;
assign funct3 = instr.params.r_instr.funct3;
assign instr_rs2 = instr.params.r_instr.rs2;

decode_mem decode_mem(
    .reset(reset),
    .opcode(opcode),
    .funct3(funct3),
    .mem_params(dmem_params)
);

// Bypassing dmem_in (mem_write_sel)
opcode_t W_opcode;
arch_reg_id W_rd;
logic W_no_rd;
always_comb begin
    // pick off useful parts for figuring out Instr is
    // in W stage
    W_opcode = W_stage_instr.opcode;
    W_rd = W_stage_instr.params.r_instr.rd;

    // check if instruction has a valid rd or not
    W_no_rd = (W_opcode == OPCODE_STORE) || (W_opcode == OPCODE_BRANCH) || (W_rd == `REGISTER_X0);

    if ((!W_no_rd) && (instr_rs2 == W_rd))
        mem_write_sel = 1'b1; // use bypass
    else
        mem_write_sel = 1'b0; // use stage's register
end

endmodule

