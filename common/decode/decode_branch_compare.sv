`include "constants.sv"
`include "instructions.sv"

module decode_branch_compare
(
    input funct3_t funct3,
    output reg branch_cmp_unsigned
);

always_comb begin
    branch_cmp_unsigned = funct3[1];
end

endmodule
