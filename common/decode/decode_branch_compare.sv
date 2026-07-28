import instructions_pkg::funct3_t;
import branch_compare_pkg::branch_cond_t;

module decode_branch_compare
(
    input funct3_t funct3,
    branch_compare_io bc_if
);

assign bc_if.unsigned_cmp = funct3[1];
assign bc_if.branch_cond = branch_cond_t'({ funct3[2], funct3[0] });

endmodule
