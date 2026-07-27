import instructions_pkg::funct3_t;
import branch_compare_pkg::branch_compare_params_t;
import branch_compare_pkg::branch_cond_t;

module decode_branch_compare
(
    input funct3_t funct3,
    output branch_compare_params_t params
);

assign params.unsigned_cmp = funct3[1];
assign params.branch_cond = branch_cond_t'({ funct3[2], funct3[0] });

endmodule
