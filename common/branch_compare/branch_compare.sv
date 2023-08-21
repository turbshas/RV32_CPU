import instructions_pkg::arch_reg;

package branch_compare_pkg

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

module branch_compare
(
    input arch_reg rs1,
    input arch_reg rs2,
    input branch_compare_params_t params,
    output logic branch_result
);

logic unsigned_lt;
logic signed_lt;
logic equal; /* 1 if rs1 == rs2 */
always_comb begin
    unsigned_lt = rs1 < rs2;
    signed_lt = $signed(rs1) < $signed(rs2);
    equal = rs1 == rs2;
end

logic less_than; /* 1 if rs1 < rs2 */
always_comb begin
    if (params.unsigned_cmp)
        less_than = unsigned_lt;
    else
        less_than = signed_lt;
end

always_comb begin
    case (params.branch_cond)
        BRANCH_COND_EQ: branch_result = equal;
        BRANCH_COND_NE: branch_result = !equal;
        BRANCH_COND_LT: branch_result = less_than;
        BRANCH_COND_GE: branch_result = !less_than;
        default: branch_result = 1'b0;
    endcase
end

endmodule

endpackage
