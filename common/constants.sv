`define REG_ADDR_WIDTH 5
`define REGISTER_X0 `REG_ADDR_WIDTH'b0
`define REG_WIDTH 32

typedef enum logic[1:0] {
    PRIV_USER = 2'b00,
    PRIV_SUPERVISOR = 2'b01,
    PRIV_RSVD = 2'b10,
    PRIV_MACHINE = 2'b11,
} priv_mode_t;
