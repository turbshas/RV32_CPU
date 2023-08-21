import instructions_pkg::opcode_t;
import instructions_pkg::OPCODE_JALR;
import instructions_pkg::OPCODE_LOAD;
import instructions_pkg::OPCODE_OP_IMM;
import instructions_pkg::OPCODE_STORE;
import instructions_pkg::OPCODE_BRANCH;
import instructions_pkg::OPCODE_LUI;
import instructions_pkg::OPCODE_AUIPC;
import instructions_pkg::OPCODE_JAL;
import instructions_pkg::OPCODE_SYSTEM;
import instructions_pkg::funct3_t;
import csr_pkg::csr_funct3_t;
import csr_pkg::CSR_SEL_IMM;
import imm_gen_pkg::imm_type_t;
import imm_gen_pkg::IMM_I;
import imm_gen_pkg::IMM_S;
import imm_gen_pkg::IMM_B;
import imm_gen_pkg::IMM_U;
import imm_gen_pkg::IMM_J;
import imm_gen_pkg::IMM_C;
import imm_gen_pkg::IMM_NONE;

module decode_imm_gen
(
    input opcode_t opcode,
    input funct3_t funct3,
    output imm_type_t imm_type
);

csr_funct3_t csr_funct3;
always_comb begin
    csr_funct3 = funct3;
end

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
        OPCODE_SYSTEM:
        begin
            if (csr_funct3.input_select == CSR_SEL_IMM)
                imm_type = IMM_C;
            else
                imm_type = IMM_NONE;
        end
        default:       imm_type = IMM_NONE;
    endcase
end

endmodule
