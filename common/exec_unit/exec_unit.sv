import instructions_pkg::arch_reg;

package exec_unit_pkg;

typedef enum logic {
    OP1_SEL_REG = 1'b0,
    OP1_SEL_PC = 1'b1
} op1_select_t;

typedef enum logic {
    OP2_SEL_REG = 1'b0,
    OP2_SEL_IMM = 1'b1
} op2_select_t;

typedef enum logic[3:0] {
    EXEC_OP_ADD         = 4'b0000,
    EXEC_OP_SUB         = 4'b1000,

    // Shift left logical
    EXEC_OP_SLL_SLLI1   = 4'b0001,
    EXEC_OP_SLL_SLLI2   = 4'b1001,

    // Set if less than
    EXEC_OP_SLT_SLTI1   = 4'b0010,
    EXEC_OP_SLT_SLTI2   = 4'b1010,

    // Set if less than (unsigned)
    EXEC_OP_SLTU_SLTIU1 = 4'b0011,
    EXEC_OP_SLTU_SLTIU2 = 4'b1011,

    EXEC_OP_XOR1        = 4'b0100,
    EXEC_OP_XOR2        = 4'b1100,

    EXEC_OP_SRL_SRLI    = 4'b0101, // Shift right logical (Do not extend sign down)
    EXEC_OP_SRA_SRAI    = 4'b1101, // Shift right arithmetic

    EXEC_OP_OR1         = 4'b0110,
    EXEC_OP_OR2         = 4'b1110,

    EXEC_OP_AND1        = 4'b0111,
    EXEC_OP_AND2        = 4'b1111
} exec_op_t;

typedef struct packed {
    op1_select_t operand1_sel;
    op2_select_t operand2_sel;
    exec_op_t exec_op;
} exec_unit_params;

endpackage

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
always_comb begin
    case (params.operand1_sel)
        OP1_SEL_REG: operand1 = rs1;
        OP1_SEL_PC:  operand1 = pc;
    endcase
end

// assign operand 2
always_comb begin
    case(params.operand2_sel)
        OP2_SEL_REG: operand2 = rs2;
        OP2_SEL_IMM: operand2 = imm_val;
    endcase
end

always_comb begin
    shift_amount = operand2[4:0];
    signed_1_less_than_2 = $signed(operand1) < $signed(operand2);
    unsigned_1_less_than_2 = operand1 < operand2;
end

always_comb begin
    case (params.exec_op)
        EXEC_OP_ADD: exec_out = operand1 + operand2;
        EXEC_OP_SUB: exec_out = operand1 - operand2;
        EXEC_OP_SLL_SLLI1, EXEC_OP_SLL_SLLI2: exec_out = operand1 << shift_amount;
        EXEC_OP_SLT_SLTI1, EXEC_OP_SLT_SLTI2: exec_out = {31'b0, signed_1_less_than_2};
        EXEC_OP_SLTU_SLTIU1, EXEC_OP_SLTU_SLTIU2: exec_out = {31'b0, unsigned_1_less_than_2};
        EXEC_OP_XOR1, EXEC_OP_XOR2: exec_out = operand1 ^ operand2;
        EXEC_OP_SRL_SRLI: exec_out = operand1 >> shift_amount;
        EXEC_OP_SRA_SRAI: exec_out = $signed(operand1) >>> shift_amount;
        EXEC_OP_OR1, EXEC_OP_OR2: exec_out = operand1 | operand2;
        EXEC_OP_AND1, EXEC_OP_AND2: exec_out = operand1 & operand2;
        default: // perform add as default, for lack of a better op
            exec_out = operand1 + operand2;
    endcase
end

endmodule
