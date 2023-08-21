typedef enum logic[1:0] {
    BRANCH_COND_EQ = 2'b00,
    BRANCH_COND_NE = 2'b01,
    BRANCH_COND_LT = 2'b10,
    BRANCH_COND_GE = 2'b11
} branch_cond_t;

typedef struct packed {
    logic unsigned_cmp;
    branch_cond_t branch_cond;
} branch_compare_params_t;
