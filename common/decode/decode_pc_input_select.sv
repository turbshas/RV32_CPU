`include "instructions.sv"

module decode_pc_input_select
(
    input logic reset,
    input opcode_t opcode,
    input logic branch_result,
    output pc_input_sel_t pc_input_sel
);

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
            OPCODE_BRANCH: pc_input_sel = branch_result;
            
            // Jump is unconditional
            OPCODE_JAL, OPCODE_JALR: pc_input_sel = PC_INPUT_ALU;

            // rest take PC+4 every time
            default: pc_input_sel = PC_INPUT_PC_PLUS_4;

        endcase // opcode
    end
end

endmodule
