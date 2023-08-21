package fence_pkg;

// Values for FENCE fm field - all other values reserved.
typedef enum logic[3:0] {
    FENCE_FM_NONE = 4'b0000,
    FENCE_FM_TSO = 4'b1000
} fence_fm_t;

typedef struct packed {
    logic device_input;
    logic device_output;
    logic reads;
    logic writes;
} fence_access_ordering;

endpackage
