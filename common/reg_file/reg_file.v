module reg_file
(
    input wire clock,
    input wire[4:0] addr_rs1,
    input wire[4:0] addr_rs2,
    input wire[4:0] addr_rd,
    input wire[31:0] data_rd,
    output reg[31:0] data_rs1,
    output reg[31:0] data_rs2,
    input wire write_enable,
    output wire[31:0] registers_out[32]
);

reg[31:0] registers[32];
assign registers_out = registers;

`ifndef BUILDING_RTL
`define INITIAL_SP (64*1024*1024 - 4)
initial begin
    /* Set initial stack pointer to high value in memory. */
    registers[0] = 32'h00000000;
    registers[2] = `INITIAL_SP;
end
`endif

always @(*) begin
    data_rs1 = registers[addr_rs1];
    data_rs2 = registers[addr_rs2];
end

always @(posedge clock) begin
    if (write_enable) begin
        if (addr_rd != 5'b0) begin
            registers[addr_rd] <= data_rd;
        end
    end
end

endmodule

