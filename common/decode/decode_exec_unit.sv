import instructions_pkg::opcode_t;
import instructions_pkg::OPCODE_OP;
import instructions_pkg::OPCODE_OP_IMM;
import instructions_pkg::OPCODE_BRANCH;
import instructions_pkg::OPCODE_JAL;
import instructions_pkg::OPCODE_AUIPC;
import instructions_pkg::funct3_t;
import instructions_pkg::funct7_t;
import exec_unit_pkg::exec_unit_params;
import exec_unit_pkg::OP1_SEL_REG;
import exec_unit_pkg::OP1_SEL_PC;
import exec_unit_pkg::OP2_SEL_REG;
import exec_unit_pkg::OP2_SEL_IMM;
import exec_unit_pkg::EXEC_OP_ADD;

module decode_exec_unit
(
    input opcode_t opcode,
    input funct3_t funct3,
    input funct7_t funct7,
    output exec_unit_params params
);

// exec_op
reg I_type_funct7;
always_comb begin
    // SRAI/SRLI are the only I-type that uses funct7
    I_type_funct7 = (funct3 == 3'b101) & funct7[5];
end

always_comb begin
    // changes based on r type or not used
    case (opcode)
        // R-Type
        OPCODE_OP: params.exec_op = {funct7[5], funct3};
        // I-Type
        OPCODE_OP_IMM: params.exec_op = {I_type_funct7, funct3};
        // All others, use add
        default: params.exec_op = EXEC_OP_ADD;
    endcase
end

// ALU operand1_sel / operand2_sel
always_comb begin
    case (opcode)
        // R-Type
        OPCODE_OP:
        begin
            params.operand1_sel = OP1_SEL_REG;
            params.operand2_sel = OP2_SEL_REG;
        end

        // B-Type, J-Type, AUIPC
        OPCODE_BRANCH, OPCODE_JAL, OPCODE_AUIPC:
        begin
            params.operand1_sel = OP1_SEL_PC;
            params.operand2_sel = OP2_SEL_IMM;
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        // Also, CSR instructions - they either use rs1 or an
        // immediate so it needs to be sent through exec unit.
        default:
        begin
            params.operand1_sel = OP1_SEL_REG;
            params.operand2_sel = OP2_SEL_IMM;
        end
    endcase
end

endmodule
