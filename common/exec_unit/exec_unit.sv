`include "constants.sv"
`include "exec_unt_interfaces.sv"

// here is the higher level module for instancing the alu and branch compare
// modules and fascilitating their connections
module exec_unit
(
    input arch_reg pc,
    input arch_reg rs1,
    input arch_reg rs2,
    input arch_reg imm_val,
    input exec_unit_params params,
    output arch_reg exec_out
);

arch_reg operand1;
arch_reg operand2;
logic[4:0] shift_amount;
logic signed_1_less_than_2;
logic unsigned_1_less_than_2;

// Assign operand 1
always @(*) begin
    case (params.operand1_sel)
        `OP1_SEL_REG: operand1 = rs1;
        `OP1_SEL_PC:  operand1 = pc;
    endcase
end

// assign operand 2
always @(*) begin
    case(params.operand2_sel)
        `OP2_SEL_REG: operand2 = rs2;
        `OP2_SEL_IMM: operand2 = imm_val;
    endcase
end

always @(*) begin
    shift_amount = operand2[4:0];
    signed_1_less_than_2 = $signed(operand1) < $signed(operand2);
    unsigned_1_less_than_2 = operand1 < operand2;
end

always @(*) begin
    casez (params.exec_op)
        `EXEC_OP_ADD: exec_out = operand1 + operand2;
        `EXEC_OP_SUB: exec_out = operand1 - operand2;
        `EXEC_OP_SLL_SLLI: exec_out = operand1 << shift_amount;
        `EXEC_OP_SLT_SLTI: exec_out = {31'b0, signed_1_less_than_2};
        `EXEC_OP_SLTU_SLTIU: exec_out = {31'b0, unsigned_1_less_than_2};
        `EXEC_OP_XOR: exec_out = operand1 ^ operand2;
        `EXEC_OP_SRL_SRLI: exec_out = operand1 >> shift_amount;
        `EXEC_OP_SRA_SRAI: exec_out = $signed(operand1) >>> shift_amount;
        `EXEC_OP_OR: exec_out = operand1 | operand2;
        `EXEC_OP_AND: exec_out = operand1 & operand2;
        default: // perform add as default, for lack of a better op
            exec_out = operand1 + operand2;
    endcase
end

endmodule
