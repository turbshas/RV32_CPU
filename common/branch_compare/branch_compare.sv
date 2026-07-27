import instructions_pkg::arch_reg;
import instructions_pkg::pc_input_sel_t;
import instructions_pkg::PC_INPUT_ALU;
import instructions_pkg::PC_INPUT_PC_PLUS_4;
import branch_compare_pkg::branch_compare_params_t;
import branch_compare_pkg::BRANCH_COND_EQ;
import branch_compare_pkg::BRANCH_COND_NE;
import branch_compare_pkg::BRANCH_COND_LT;
import branch_compare_pkg::BRANCH_COND_GE;

module branch_compare
(
    input arch_reg rs1,
    input arch_reg rs2,
    input branch_compare_params_t params,
    output pc_input_sel_t branch_result
);

logic unsigned_lt;
logic signed_lt;
logic equal; /* 1 if rs1 == rs2 */
logic less_than; /* 1 if rs1 < rs2 */
logic result_internal;

assign unsigned_lt = rs1 < rs2;
assign signed_lt = $signed(rs1) < $signed(rs2);
assign equal = rs1 == rs2;
assign less_than = params.unsigned_cmp ? unsigned_lt : signed_lt;

always_comb begin
    case (params.branch_cond)
        BRANCH_COND_EQ: result_internal = equal;
        BRANCH_COND_NE: result_internal = !equal;
        BRANCH_COND_LT: result_internal = less_than;
        BRANCH_COND_GE: result_internal = !less_than;
        default: result_internal = 1'b0;
    endcase
end

assign branch_result = result_internal ? PC_INPUT_ALU : PC_INPUT_PC_PLUS_4;

endmodule
