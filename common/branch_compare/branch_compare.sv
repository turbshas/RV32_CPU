`include "constants.sv"

module branch_compare
(
    input arch_reg rs1,
    input arch_reg rs2,
    input logic unsigned_cmp,
    output logic less_than, /* 1 if rs1 < rs2 */
    output logic equal /* 1 if rs1 == rs2 */
);

always @(*) begin
    if (unsigned_cmp)
        less_than = rs1 < rs2;
    else
        less_than = $signed(rs1) < $signed(rs2);

    equal = rs1 == rs2;
end

endmodule

