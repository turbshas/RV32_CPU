// Opcodes
// See RISCV Spec - RV32/64G Instruction Set Listings (Chapter 24).
// 2 lsb are always 11 for 32-bit instructions
`define          OPCODE_LOAD {2'b00, 3'b000, 2'b11}
`define       OPCODE_LOAD_FP {2'b00, 3'b001, 2'b11}
`define       OPCODE_CUSTOM0 {2'b00, 3'b010, 2'b11}
`define      OPCODE_MISC_MEM {2'b00, 3'b011, 2'b11}
`define        OPCODE_OP_IMM {2'b00, 3'b100, 2'b11}
`define         OPCODE_AUIPC {2'b00, 3'b101, 2'b11}
`define      OPCODE_OP_IMM32 {2'b00, 3'b110, 2'b11}

`define     OPCODE_48b_INST1 {2'b00, 3'b111, 2'b11}

`define         OPCODE_STORE {2'b01, 3'b000, 2'b11}
`define      OPCODE_STORE_FP {2'b01, 3'b001, 2'b11}
`define       OPCODE_CUSTOM1 {2'b01, 3'b010, 2'b11}
`define           OPCODE_AMO {2'b01, 3'b011, 2'b11}
`define            OPCODE_OP {2'b01, 3'b100, 2'b11}
`define           OPCODE_LUI {2'b01, 3'b101, 2'b11}
`define          OPCODE_OP32 {2'b01, 3'b110, 2'b11}

`define      OPCODE_64b_INST {2'b01, 3'b111, 2'b11}

`define          OPCODE_MADD {2'b10, 3'b000, 2'b11}
`define          OPCODE_MSUB {2'b10, 3'b001, 2'b11}
`define         OPCODE_NMSUB {2'b10, 3'b010, 2'b11}
`define         OPCODE_NMADD {2'b10, 3'b011, 2'b11}
`define         OPCODE_OP_FP {2'b10, 3'b100, 2'b11}
`define         OPCODE_RSVD0 {2'b10, 3'b101, 2'b11}
`define OPCODE_CUSTOM2_RV128 {2'b10, 3'b110, 2'b11}

`define     OPCODE_48b_INST2 {2'b10, 3'b111, 2'b11}

`define        OPCODE_BRANCH {2'b11, 3'b000, 2'b11}
`define          OPCODE_JALR {2'b11, 3'b001, 2'b11}
`define         OPCODE_RSVD1 {2'b11, 3'b010, 2'b11}
`define           OPCODE_JAL {2'b11, 3'b011, 2'b11}
`define        OPCODE_SYSTEM {2'b11, 3'b100, 2'b11}
`define         OPCODE_RSVD2 {2'b11, 3'b101, 2'b11}
`define OPCODE_CUSTOM3_RV128 {2'b11, 3'b110, 2'b11}

`define      OPCODE_80b_INST {2'b11, 3'b111, 2'b11}

// Immediate format types
`define    I_IMM_T 3'b000
`define    S_IMM_T 3'b001
`define    B_IMM_T 3'b010
`define    U_IMM_T 3'b011
`define    J_IMM_T 3'b100
`define RSV0_IMM_T 3'b101
`define RSV1_IMM_T 3'b110
`define NONE_IMM_T 3'b111

// Values for FENCE fm field - all other values reserved.
`define FENCE_FM_NONE 4'b0000
`define FENCE_FM_TSO  4'b1000

typedef logic[6:0] opcode32_t;
typedef logic[4:0] arch_reg_id;
typedef logic[2:0] funct3_t;
typedef logic[6:0] funct7_t;

typedef struct packed {
    logic writes;
    logic reads;
    logic device_output;
    logic device_input;
} fence_access_ordering;

typedef struct packed {
    arch_reg_id rd;
    funct3_t funct3;
} fence_instr_params;

typedef struct packed {
    arch_reg_id rd;
    funct3_t funct3;
    arch_reg_id rs1;
    arch_reg_id rs2;
    funct7_t funct7;
} r_instr_params;

typedef struct packed {
    arch_reg_id rd;
    funct3_t funct3;
    arch_reg_id rs1;
    logic[11:0] imm;
} i_instr_params;

typedef struct packed {
    // Concatenated onto imm_11to5 -> imm[11:0]
    logic[4:0] imm_b4to0;
    funct3_t funct3;
    arch_reg_id rs1;
    arch_reg_id rs2;
    logic[11:5] imm_b11to5;
} s_instr_params;

typedef struct packed {
    // Concatenate { imm_b12, imm_b11, imm_b10to5, imm_b4to1, } to form final immediate.
    // (bit 0 must be zero as the branch must be 2-aligned).
    logic imm_b11;
    logic[3:0] imm_b4to1;
    funct3_t funct3;
    arch_reg_id rs1;
    arch_reg_id rs2;
    // Bit 12, followed by bits 10:5.
    logic[5:0] imm_b10to5;
    logic imm_b12;
} b_instr_params;

typedef struct packed {
    arch_reg_id rd;
    // Comprises only the upper 20 bits of the immediate.
    // The value of PC is added to this to form the resulting address.
    logic[19:0] imm_31to12;
} u_instr_params;

typedef struct packed {
    arch_reg_id rd;
    // Rearrange { imm_b20, imm_b19to12, imm_b11, imm_b10to1, } to form final immediate.
    // (bit 0 must be zero as the branch must be 2-aligned).
    logic[7:0] imm_b19to12;
    logic imm_b11;
    logic[9:0] imm_b10to1;
    logic imm_b20;
} j_instr_params;

typedef union packed {
    r_instr_params r_instr;
    i_instr_params i_instr;
    s_instr_params s_instr;
    b_instr_params b_instr;
    u_instr_params u_instr;
    j_instr_params j_instr;
    fence_instr_params fence;
} instr_params;

typedef struct packed {
    opcode32_t opcode;
    instr_params params;
} instr_packet;
