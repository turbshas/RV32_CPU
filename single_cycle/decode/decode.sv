`include "constants.sv"
`include "instructions.sv"

`include "branch_compare_inc.sv"
`include "csr_inc.sv"
`include "exec_unit_inc.sv"
`include "imm_gen_inc.sv"
`include "mem_inc.sv"

module decode
(
    input logic clock,
    input logic reset,
    input instr_packet instr,

    output arch_reg_id rd,
    output arch_reg_id rs1,
    output arch_reg_id rs2,
    output imm_type_t imm_type,
    output exec_unit_params exec_params,

    input logic branch_result,
    output branch_compare_params_t branch_compare_params,

    output logic reg_write_en,
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
    rd     = instr.params.r_instr.rd;
    funct3 = instr.params.r_instr.funct3;
    rs2    = instr.params.r_instr.rs2;
    funct7 = instr.params.r_instr.funct7;

    case (opcode)
        // LUI makes rs1 need to be set to reg 0 - immediate gets added to 0.
        OPCODE_LUI: rs1 = REGISTER_X0;
        default: rs1 = instr.params.r_instr.rs1;
    endcase

    // Fence-specific values
    fence_fm = instr.params.fence.fm;
    fence_predecessor = instr.params.fence.predecessor;
    fence_successor = instr.params.fence.successor;
end

/* Reg/Immediate stage  */
decode_imm_gen decode_imm_gen(
    .opcode(opcode),
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
    .opcode(opcode),
    .reg_write_en(reg_write_en),
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
