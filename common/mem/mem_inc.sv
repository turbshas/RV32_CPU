typedef enum logic {
    MEM_OP_WRITE = 1'b0,
    MEM_OP_READ = 1'b1,
} mem_op_t;

typedef enum logic[1:0] {
    MEM_ACCESS_BYTE = 2'b00,
    MEM_ACCESS_HALF = 2'b01,
    MEM_ACCESS_WORD = 2'b10,
    MEM_ACCESS_RSVD = 2'b11,
} mem_access_size_t;

typedef struct packed {
    /** Affects sign extension on the value read from memory. */
    logic read_unsigned;
    mem_access_size_t access_size;
    mem_op_t op;
} mem_params_t;
