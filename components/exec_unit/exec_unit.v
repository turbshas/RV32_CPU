// here is the higher level module for instancing the alu and branch compare
// modules and fascilitating their connections
module exec_unit
(
    input wire [31:0] pc,
    input wire [31:0] rs1,
    input wire [31:0] rs2,
    input wire [31:0] imm_val,
    input wire operand1_sel,
    input wire operand2_sel,
    input wire [3:0] exec_op,
    output reg [31:0] exec_out
);

reg [31:0] operand1;
reg [31:0] operand2;

// Assign operand 1
always @(*) begin
  case (operand1_sel)
      1'b0: // register
          operand1 = rs1;
      1'b1: // pc
          operand1 = pc;
  endcase
end

// assign operand 2
always @(*) begin
  case(operand2_sel)
      1'b0: // reg
          operand2 = rs2;
      1'b1: // immediate
          operand2 = imm_val;
  endcase
end

always @(*) begin
  casez (exec_op)
      4'b0000: // ADD
          exec_out = operand1 + operand2;
      4'b1000: // SUB
          exec_out = operand1 - operand2;
      4'b?001: // SLL / SLLI
          exec_out = operand1 << operand2[4:0];
      4'b?010: // SLT / SLTI
          begin
            if ($signed(operand1) < $signed(operand2))
                exec_out = 32'b1;
            else
                exec_out = 32'b0;
          end
      4'b?011: // SLTU / SLTIU
          begin
            if (operand1 < operand2)
                exec_out = 32'b1;
            else
                exec_out = 32'b0;
          end
      4'b?100: // XOR
          exec_out = operand1 ^ operand2;
      4'b0101: // SRL / SRLI (Do not extend sign down)
          exec_out = operand1 >> operand2[4:0];
      4'b1101: // SRA / SRAI
          exec_out = $signed(operand1) >>> operand2[4:0];
      4'b?110: // OR
          exec_out = operand1 | operand2;
      4'b?111: // AND
          exec_out = operand1 & operand2;
      default: // perform add as default, for lack of a better op
          exec_out = operand1 + operand2;
  endcase
end

endmodule
