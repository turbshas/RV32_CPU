`include "instructions.sv"

typedef enum logic[1:0] {
    WRITE_BACK_SEL_MEM  = 2'b00,
    WRITE_BACK_SEL_ALU  = 2'b01,
    WRITE_BACK_SEL_PC   = 2'b10,
    WRITE_BACK_SEL_RSVD = 2'b11,
} write_back_select_t;
