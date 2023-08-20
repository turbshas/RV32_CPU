`include "write_back_inc.sv"

module write_back 
(
  input arch_reg mem_in,
  input arch_reg alu_in,
  input arch_reg pc_in,
  input write_back_select_t write_back_sel,

  output reg [31:0] write_back_out
);

always_comb begin
  case (write_back_sel)
      WRITE_BACK_SEL_MEM: write_back_out = mem_in;
      WRITE_BACK_SEL_ALU: write_back_out = alu_in;
      WRITE_BACK_SEL_PC: write_back_out = pc_in + 4;
      default: write_back_out = alu_in;
  endcase
end

endmodule

