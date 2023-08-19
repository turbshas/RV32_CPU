`include "constants.sv"
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

logic i_sign;
logic s_sign;
logic b_sign;
logic j_sign;

always @(*) begin
    i_sign = instr.i_instr.imm[11];
    s_sign = instr.s_instr.imm_b11to5[11];
    b_sign = instr.b_instr.imm_b12;
    j_sign = instr.j_instr.imm_b20;

    I_immediate = { {20{i_sign}}, instr.i_instr.imm };
    S_immediate = { {20{s_sign}}, instr.s_instr.imm_b11to5, instr.s_instr.imm_b4to0 };
    B_immediate = { {20{b_sign}}, instr.b_instr.imm_b11, instr.b_instr.imm_b10to5, instr.b_instr.imm_b4to1, 1'b0 };
    U_immediate = { instr.u_instr.imm, 12'b0 };
    J_immediate = { {12{j_sign}}, instr.j_instr.imm_b19to12, instr.j_instr.imm_b11, instr.j_instr.imm_b10to1, 1'b0 };
end

// always block for picking which immediate to use
always @(*) begin
    case (imm_type)
        `I_IMM_T: immediate_out = I_immediate;
        `S_IMM_T: immediate_out = S_immediate;
        `B_IMM_T: immediate_out = B_immediate;
        `U_IMM_T: immediate_out = U_immediate;
        default:  immediate_out = J_immediate;
    endcase
end

endmodule

