`include "instructions.sv"

module reg_file
parameter REG_ADDR_WIDTH = 5;
(
    input wire clock,
    input wire[REG_ADDR_WIDTH - 1:0] addr_rs1,
    input wire[REG_ADDR_WIDTH - 1:0] addr_rs2,
    input wire[REG_ADDR_WIDTH - 1:0] addr_rd,
    input arch_reg data_rd,
    output arch_reg data_rs1,
    output arch_reg data_rs2,
    input wire write_enable,
    output arch_reg registers_out[2**REG_ADDR_WIDTH]
);

logic dest_is_not_x0;
logic valid_write;
arch_reg registers[2**REG_ADDR_WIDTH];
assign registers_out = registers;

`ifndef BUILDING_RTL
`define INITIAL_SP (64*1024*1024 - 4)
initial begin
    /* Set initial stack pointer to high value in memory. */
    registers[0] = 32'h00000000;
    registers[2] = `INITIAL_SP;
end
`endif

always_comb begin
    data_rs1 = registers[addr_rs1];
    data_rs2 = registers[addr_rs2];
    dest_is_not_x0 = addr_rd != REG_ADDR_WIDTH'b0;
end

always_comb begin
    valid_write = write_enable & dest_is_not_x0;
end

always_ff @(posedge clock) begin
    if (valid_write) begin
        registers[addr_rd] <= data_rd;
    end
end

endmodule

