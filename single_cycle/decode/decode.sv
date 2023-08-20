`include "constants.sv"
`include "instructions.sv"

`include "branch_compare_inc.sv"
`include "csr_inc.sv"
`include "exec_unit_inc.sv"
`include "imm_gen_inc.sv"
`include "mem_inc.sv"
`include "reg_file_inc.sv"

module decode
(
    input logic clock,
    input logic reset,
    input instr_packet instr,

    output reg_file_read_params_t reg_file_read_params,
    output reg_file_write_params_t reg_file_write_params,

    output imm_type_t imm_type,
    output exec_unit_params exec_params,

    input logic branch_result,
    output branch_compare_params_t branch_compare_params,

    output write_back_select_t reg_store_sel,
    output logic pc_input_sel,

    output mem_params_t mem_params,
    output csr_params csr_params
);

// R-type values
opcode_t opcode; 
funct3_t funct3;
funct7_t funct7;

// Memory Fence values
reg[3:0] fence_fm;
fence_instr_params fence_predecessor;
fence_instr_params fence_successor;

// always block for picking out pieces of the instruction
always_comb begin
    opcode = instr.opcode;
    funct3 = instr.params.r_instr.funct3;
    funct7 = instr.params.r_instr.funct7;

    // Fence-specific values
    fence_fm = instr.params.fence.fm;
    fence_predecessor = instr.params.fence.predecessor;
    fence_successor = instr.params.fence.successor;
end

/* Reg/Immediate stage  */
decode_reg_file decode_reg_file(
    .instr(instr),
    .params(reg_file_read_params)
);

decode_imm_gen decode_imm_gen(
    .opcode(opcode),
    .funct3(funct3),
    .imm_type(imm_type)
);

/* Execute Stage  */
decode_exec_unit decode_exec_unit(
    .funct3(funct3),
    .funct7(funct7),
    .params(exec_params)
);

/* Write-Back Stage  */
decode_write_back decode_write_back(
    .reset(reset),
    .instr(instr),
    .reg_file_write_params(reg_file_write_params),
    .reg_store_sel(reg_store_sel)
);

decode_branch_compare decode_branch_compare(
    .funct3(funct3),
    .params(branch_compare_params)
);

decode_pc_input_select decode_pc_input_select(
    .reset(reset),
    .opcode(opcode),
    .branch_result(branch_result),
    .pc_input_sel(pc_input_sel)
);

// TODO: not sure exactly where CSR should go - want reads/writes to be atomic so preferably not
//       in separate stages? don't want to have a physical reg file for thousands of CSRs
decode_csr decode_csr(
    .instr(instr),
    .csr_params(csr_params)
);

/* Memory stage */
decode_mem decode_mem(
    .reset(reset),
    .opcode(opcode),
    .funct3(funct3),
    .mem_params(mem_params)
);

endmodule
