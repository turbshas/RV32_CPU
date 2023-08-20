`include "constants.sv"
`include "instructions.sv"

module decode_pc_input_select
(
    input logic reset,
    input opcode_t opcode,
    input funct3_t funct3,
    input logic branch_cmp_eq,
    input logic branch_cmp_lt,
    output pc_input_sel_t pc_input_sel
);

branch_cond_t branch_cond;
always_comb begin
    branch_cond = { funct3[2], funct3[0] };
end

// pc_input_sel
always_comb begin
    // either takes PC+4 or ALU when branch false or true respectively, on
    // a B instruction
    // always take jump on a jump instruction
    if (reset)
        pc_input_sel = 0;
    else begin
        case (opcode)
            // B-Type
            OPCODE_BRANCH:
              begin
                // Check each branch inst.
                case (branch_cond)
                    BRANCH_COND_EQ: pc_input_sel = branch_cmp_eq; // BEQ
                    BRANCH_COND_NE: pc_input_sel = !(branch_cmp_eq); // BNE
                    BRANCH_COND_LT: pc_input_sel = branch_cmp_lt; // BLT
                    BRANCH_COND_GE: pc_input_sel = !(branch_cmp_lt); // BGE
                endcase // funct3
              end
            
            // Jump is unconditional
            OPCODE_JAL, OPCODE_JALR: pc_input_sel = PC_INPUT_ALU;

            // rest take PC+4 every time
            default: pc_input_sel = PC_INPUT_PC_PLUS_4;

        endcase // opcode
    end
end

endmodule
