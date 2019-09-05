module branch_compare
(
    input wire[31:0] rs1,
    input wire[31:0] rs2,
    input wire unsigned_cmp,
    output reg less_than, /* 1 if rs1 < rs2 */
    output reg equal /* 1 if rs1 == rs2 */
);

always @(*) begin
    if (unsigned_cmp)
        less_than = rs1 < rs2;
    else
        less_than = $signed(rs1) < $signed(rs2);

    equal = rs1 == rs2;
end

endmodule

