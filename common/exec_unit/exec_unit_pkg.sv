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
