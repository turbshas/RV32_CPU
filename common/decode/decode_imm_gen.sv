`include "constants.sv"
`include "instructions.sv"

`include "imm_gen_inc.sv"

module decode_imm_gen
(
    input opcode_t opcode,
    output imm_type_t imm_type
);

always_comb begin
    case (opcode)
        OPCODE_JALR:   imm_type = IMM_I;
        OPCODE_LOAD:   imm_type = IMM_I;
        OPCODE_OP_IMM: imm_type = IMM_I;
        OPCODE_STORE:  imm_type = IMM_S;
        OPCODE_BRANCH: imm_type = IMM_B;
        OPCODE_LUI:    imm_type = IMM_U;
        OPCODE_AUIPC:  imm_type = IMM_U;
        OPCODE_JAL:    imm_type = IMM_J;
        OPCODE_SYSTEM: imm_type = IMM_C;
        default:       imm_type = IMM_NONE;
    endcase
end

endmodule
