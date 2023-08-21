`include "instructions.sv"

`include "branch_compare_inc.sv"

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
