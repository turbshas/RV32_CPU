package io_pipelined_pkg;

typedef enum logic[1:0] {
    NO_BYPASS = 2'b00,
    NO_BYPASS_RSVD = 2'b01,
    FROM_MEM_STAGE = 2'b10,
    FROM_WB_STAGE = 2'b11
} exec_reg_forward_t;

endpackage

