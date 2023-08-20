`include "fence_inc.sv"

/*
Main instruction types:
        31                25 24       20 19            15 14                            12 11              7 6         0
R-type:  [     funct7       |    rs2    |      rs1       |           funct3               |      rd         |  opcode  ]
I-type:  [   imm[11:0]                  |      rs1       |           funct3               |      rd         |  opcode  ]
S-type:  [   imm[11:5]      |    rs2    |      rs1       |           funct3               |   imm[4:0]      |  opcode  ]
B-type:  [   imm[12|10:5]   |    rs2    |      rs1       |           funct3               |   imm[4:1|11]   |  opcode  ]
U-type:  [   imm[31:12]                                                                   |      rd         |  opcode  ]
J-type:  [   imm[20|10:1|11|19:12]                                                        |      rd         |  opcode  ]

Other:
       31           28 27    24 23    20 19            15 14                            12 11                 7 6         0
FENCE:   [     fm     |  pred  |  succ  |      rs1       |            000                 |      rd         |  opcode  ]
ECALL:   [   0000 0000 0000             |     00000      |            000                 |    00000        |  opcode  ]
EBREAK:  [   0000 0000 0001             |     00000      |            000                 |    00000        |  opcode  ]
CSR:     [   CSR address                |  rs1/uimm[4:0] |  [RS1/UIMM select|write func]  |      rd         |  opcode  ]
*/

// Opcodes
// See RISCV Spec - RV32/64G Instruction Set Listings (Chapter 24).
// 2 lsb are always 11 for 32-bit instructions
typedef enum logic[6:0] {
    OPCODE_LOAD =           {2'b00, 3'b000, 2'b11},
    OPCODE_LOAD_FP =        {2'b00, 3'b001, 2'b11},
    OPCODE_CUSTOM0 =        {2'b00, 3'b010, 2'b11},
    OPCODE_MISC_MEM =       {2'b00, 3'b011, 2'b11},
    OPCODE_OP_IMM =         {2'b00, 3'b100, 2'b11},
    OPCODE_AUIPC =          {2'b00, 3'b101, 2'b11},
    OPCODE_OP_IMM32 =       {2'b00, 3'b110, 2'b11},

    OPCODE_48b_INST1 =      {2'b00, 3'b111, 2'b11},

    OPCODE_STORE =          {2'b01, 3'b000, 2'b11},
    OPCODE_STORE_FP =       {2'b01, 3'b001, 2'b11},
    OPCODE_CUSTOM1 =        {2'b01, 3'b010, 2'b11},
    OPCODE_AMO =            {2'b01, 3'b011, 2'b11},
    OPCODE_OP =             {2'b01, 3'b100, 2'b11},
    OPCODE_LUI =            {2'b01, 3'b101, 2'b11},
    OPCODE_OP32 =           {2'b01, 3'b110, 2'b11},

    OPCODE_64b_INST =       {2'b01, 3'b111, 2'b11},

    OPCODE_MADD =           {2'b10, 3'b000, 2'b11},
    OPCODE_MSUB =           {2'b10, 3'b001, 2'b11},
    OPCODE_NMSUB =          {2'b10, 3'b010, 2'b11},
    OPCODE_NMADD =          {2'b10, 3'b011, 2'b11},
    OPCODE_OP_FP =          {2'b10, 3'b100, 2'b11},
    OPCODE_RSVD0 =          {2'b10, 3'b101, 2'b11},
    OPCODE_CUSTOM2_RV128 =  {2'b10, 3'b110, 2'b11},

    OPCODE_48b_INST2 =      {2'b10, 3'b111, 2'b11},

    OPCODE_BRANCH =         {2'b11, 3'b000, 2'b11},
    OPCODE_JALR =           {2'b11, 3'b001, 2'b11},
    OPCODE_RSVD1 =          {2'b11, 3'b010, 2'b11},
    OPCODE_JAL =            {2'b11, 3'b011, 2'b11},
    OPCODE_SYSTEM =         {2'b11, 3'b100, 2'b11},
    OPCODE_RSVD2 =          {2'b11, 3'b101, 2'b11},
    OPCODE_CUSTOM3_RV128 =  {2'b11, 3'b110, 2'b11},

    OPCODE_80b_INST =       {2'b11, 3'b111, 2'b11},
} opcode_t;

`define REGISTER_X0 5'b00000

typedef logic[4:0] arch_reg_id;
typedef logic[2:0] funct3_t;
typedef logic[6:0] funct7_t;
typedef logic[31:0] arch_reg;

// TODO: better place for this?
typedef enum logic {
    PC_INPUT_PC_PLUS_4 = 1'b0,
    PC_INPUT_ALU = 1'b1,
} pc_input_sel_t;

typedef struct packed {
    fence_fm_t fm;
    fence_access_ordering predecessor;
    fence_access_ordering successor;
    arch_reg_id rs1;
    funct3_t funct3;
    arch_reg_id rd;
} fence_instr_params;

typedef struct packed {
    funct7_t funct7;
    arch_reg_id rs2;
    arch_reg_id rs1;
    funct3_t funct3;
    arch_reg_id rd;
} r_instr_params;

typedef struct packed {
    logic[11:0] imm;
    arch_reg_id rs1;
    funct3_t funct3;
    arch_reg_id rd;
} i_instr_params;

typedef struct packed {
    logic[11:5] imm_b11to5;
    arch_reg_id rs2;
    arch_reg_id rs1;
    funct3_t funct3;
    // Concatenated onto imm_11to5 -> imm[11:0]
    logic[4:0] imm_b4to0;
} s_instr_params;

typedef struct packed {
    logic imm_b12;
    logic[5:0] imm_b10to5;
    arch_reg_id rs2;
    arch_reg_id rs1;
    funct3_t funct3;
    logic[3:0] imm_b4to1;
    // Concatenate { imm_b12, imm_b11, imm_b10to5, imm_b4to1, } to form final immediate.
    // (bit 0 must be zero as the branch must be 2-aligned).
    logic imm_b11;
} b_instr_params;

typedef struct packed {
    // Comprises only the upper 20 bits of the immediate.
    // The value of PC is added to this to form the resulting address.
    logic[19:0] imm;
    arch_reg_id rd;
} u_instr_params;

typedef struct packed {
    // Rearrange { imm_b20, imm_b19to12, imm_b11, imm_b10to1, } to form final immediate.
    // (bit 0 must be zero as the branch must be 2-aligned).
    logic imm_b20;
    logic[9:0] imm_b10to1;
    logic imm_b11;
    logic[7:0] imm_b19to12;
    arch_reg_id rd;
} j_instr_params;

typedef struct packed {
    /** [11:10] = access (R/W or R/O), [9:8] = privilege (U/S/H/M). */
    logic[11:0] csr_addr;
    /** Unsigned immediate - always zero sign extended. */
    arch_reg_id rs1_or_uimm;
    /** CSR write function - 000 for other system operations (e.g. ECALL/EBREAK). */
    csr_funct3_t csr_funct3;
    arch_reg_id rd;
} system_instr_params;

typedef union packed {
    r_instr_params r_instr;
    i_instr_params i_instr;
    s_instr_params s_instr;
    b_instr_params b_instr;
    u_instr_params u_instr;
    j_instr_params j_instr;
    fence_instr_params fence;
    system_instr_params system;
} instr_params;

typedef struct packed {
    instr_params params;
    opcode_t opcode;
} instr_packet;
