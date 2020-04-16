module write_back 
(
  input wire [31:0] mem_in,
  input wire [31:0] alu_in,
  input wire [31:0] pc_in,
  input wire [1:0] write_back_sel,

  output reg [31:0] write_back_out
);


always @(*) begin
  case (write_back_sel)
      2'b00: write_back_out = mem_in;
      2'b01: write_back_out = alu_in;
      2'b10: write_back_out = pc_in + 4;
      default: write_back_out = alu_in;
  endcase
end


endmodule

