typedef enum logic[2:0] {
    IMM_I = 3'b000,
    IMM_S = 3'b001,
    IMM_B = 3'b010,
    IMM_U = 3'b011,
    IMM_J = 3'b100,
    IMM_RSV0 = 3'b101,
    IMM_RSV1 = 3'b110,
    IMM_NONE = 3'b111,
} imm_type_t;
