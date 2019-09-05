`include "imm_gen_inc.v"

module imm_gen
(
    input wire[24:0] instr,
    input wire[2:0] imm_type,
    output reg[31:0] immediate_out
);

// Immediates for each of the different types
reg[31:0] I_immediate;
reg[31:0] S_immediate;
reg[31:0] B_immediate;
reg[31:0] U_immediate;
reg[31:0] J_immediate;

always @(*) begin
    I_immediate = { instr[24], {11{instr[24]}}, {8{instr[24]}}, instr[24], instr[23:18], instr[17:14], instr[13] };
    S_immediate = { instr[24], {11{instr[24]}}, {8{instr[24]}}, instr[24], instr[23:18],   instr[4:1],  instr[0] };
    B_immediate = { instr[24], {11{instr[24]}}, {8{instr[24]}},  instr[0], instr[23:18],   instr[4:1],      1'b0 };
    U_immediate = { instr[24],    instr[23:13],    instr[12:5],      1'b0,         6'b0,         4'b0,      1'b0 };
    J_immediate = { instr[24], {11{instr[24]}},    instr[12:5], instr[13], instr[23:18], instr[17:14],      1'b0 };
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

