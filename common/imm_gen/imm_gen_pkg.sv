package imm_gen_pkg;

typedef enum logic[2:0] {
    /** I-type instructions. */
    IMM_I = 3'b000,
    /** S-type instructions. */
    IMM_S = 3'b001,
    /** B-type instructions. */
    IMM_B = 3'b010,
    /** U-type instructions. */
    IMM_U = 3'b011,
    /** J-type instructions. */
    IMM_J = 3'b100,
    /** CSR instructions. */
    IMM_C = 3'b101,
    IMM_RSV = 3'b110,
    IMM_NONE = 3'b111
} imm_type_t;

endpackage
