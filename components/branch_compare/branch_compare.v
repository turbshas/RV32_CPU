module branch_compare
(
    input wire[31:0] rs1,
    input wire[31:0] rs2,
    input wire[31:0] X_M_forward,
    input wire[31:0] M_W_forward,
    input wire[1:0] b_operand1_sel,
    input wire[1:0] b_operand2_sel,
    input wire unsigned_cmp,
    output reg less_than, /* 1 if rs1 < rs2 */
    output reg equal /* 1 if rs1 == rs2 */
);

// operands to use for muxing
reg [31:0] b_operand1;
reg [31:0] b_operand2;

always @(*) begin
    // select which operand to use for Branching
    // useful to get a "fully bypassed pipeline"
    case (b_operand1_sel)
        // X_M forward
        2'b10: b_operand1 = X_M_forward;
        // M_W forward
        2'b11: b_operand1 = M_W_forward;
        // usual rs1
        default: b_operand1 = rs1;
    endcase

    case (b_operand2_sel)
        2'b10: b_operand2 = X_M_forward;
        2'b11: b_operand2 = M_W_forward;
        default: b_operand2 = rs2;
    endcase
end

always @(*) begin
    if (unsigned_cmp)
        less_than = b_operand1 < b_operand2;
    else
        less_than = $signed(b_operand1) < $signed(b_operand2);
    equal = b_operand1 == b_operand2;
end

endmodule

