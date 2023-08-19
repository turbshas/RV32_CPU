`define OP1_SEL_REG 1'b0
`define OP1_SEL_PC 1'b1

`define OP2_SEL_REG 1'b0
`define OP2_SEL_IMM 1'b1

`define EXEC_OP_ADD        4'b0000
`define EXEC_OP_SUB        4'b1000
`define EXEC_OP_SLL_SLLI   4'b?001 // Shift left logical
`define EXEC_OP_SLT_SLTI   4'b?010 // Set if less than
`define EXEC_OP_SLTU_SLTIU 4'b?011 // Set if less than (unsigned)
`define EXEC_OP_XOR        4'b?100
`define EXEC_OP_SRL_SRLI   4'b0101 // Shift right logical (Do not extend sign down)
`define EXEC_OP_SRA_SRAI   4'b1101 // Shift right arithmetic
`define EXEC_OP_OR         4'b?110
`define EXEC_OP_AND        4'b?111

typedef logic[3:0] exec_op_t;

typedef struct packed {
    logic operand1_sel;
    logic operand2_sel;
    exec_op_t exec_op;
} exec_unit_params;
