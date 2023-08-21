import instructions_pkg::funct3_t;
import branch_compare_pkg::branch_compare_params_t;

package decode_branch_compare_pkg

module decode_branch_compare
(
    input funct3_t funct3,
    output branch_compare_params_t params
);

always_comb begin
    params.unsigned_cmp = funct3[1];
    params.branch_cond = { funct3[2], funct3[0] };
end

endmodule

endpackage
