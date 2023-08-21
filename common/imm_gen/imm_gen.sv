`include "instructions.sv"
`include "imm_gen_inc.sv"

module imm_gen
(
    input instr_params instr,
    input imm_type_t imm_type,
    output arch_reg immediate_out
);

// Immediates for each of the different types
arch_reg I_immediate;
arch_reg S_immediate;
arch_reg B_immediate;
arch_reg U_immediate;
arch_reg J_immediate;
arch_reg CSR_immediate;

logic i_sign;
logic s_sign;
logic b_sign;
logic j_sign;

always_comb begin
    i_sign = instr.i_instr.imm[11];
    s_sign = instr.s_instr.imm_b11to5[11];
    b_sign = instr.b_instr.imm_b12;
    j_sign = instr.j_instr.imm_b20;
end

always_comb begin
    I_immediate = { {20{i_sign}}, instr.i_instr.imm };
    S_immediate = { {20{s_sign}}, instr.s_instr.imm_b11to5, instr.s_instr.imm_b4to0 };
    B_immediate = { {20{b_sign}}, instr.b_instr.imm_b11, instr.b_instr.imm_b10to5, instr.b_instr.imm_b4to1, 1'b0 };
    U_immediate = { instr.u_instr.imm, 12'b0 };
    J_immediate = { {12{j_sign}}, instr.j_instr.imm_b19to12, instr.j_instr.imm_b11, instr.j_instr.imm_b10to1, 1'b0 };
    CSR_immediate = { 27'b0, instr.system.rs1_or_uimm };
end

// always block for picking which immediate to use
always_comb begin
    case (imm_type)
        IMM_I: immediate_out = I_immediate;
        IMM_S: immediate_out = S_immediate;
        IMM_B: immediate_out = B_immediate;
        IMM_U: immediate_out = U_immediate;
        IMM_J: immediate_out = J_immediate;
        IMM_C: immediate_out = CSR_immediate;
        default:  immediate_out = `REG_WIDTH'b0;
    endcase
end

endmodule

