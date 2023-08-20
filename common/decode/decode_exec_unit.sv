`include "constants.sv"
`include "instructions.sv"

`include "exec_unit_inc.sv"

module decode_exec_unit
(
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
        OPCODE_OP: exec_params.exec_op = {funct7[5], funct3};
        // I-Type
        OPCODE_OP_IMM: exec_params.exec_op = {I_type_funct7, funct3};
        // All others, use add
        default: exec_params.exec_op = EXEC_OP_ADD;
    endcase
end

// ALU operand1_sel / operand2_sel
always_comb begin
    case (opcode)
        // R-Type
        OPCODE_OP:
        begin
            exec_params.operand1_sel = OP1_SEL_REG;
            exec_params.operand2_sel = OP2_SEL_REG;
        end

        // B-Type, J-Type, AUIPC
        OPCODE_BRANCH, OPCODE_JAL, OPCODE_AUIPC:
        begin
            exec_params.operand1_sel = OP1_SEL_PC;
            exec_params.operand2_sel = OP2_SEL_IMM;
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        //5'b00100, 5'b01000, 5'11001, 5'b01101:
        default:
        begin
            exec_params.operand1_sel = OP1_SEL_REG;
            exec_params.operand2_sel = OP2_SEL_IMM;
        end
    endcase
end

endmodule
