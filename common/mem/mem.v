`define MEM_SIZE (64*1024*1024)
`define TEMP_SIZE (4096)

`define ACCESS_SIZE_BYTE 2'b00
`define ACCESS_SIZE_HALF 2'b01
`define ACCESS_SIZE_WORD 2'b10
`define ACCESS_SIZE_RSVD 2'b11

module mem
(
    input wire clock,
    input wire[31:0] address,
    input wire[31:0] data_in,
    output reg[31:0] data_out,
    input wire read_write,
    input wire[1:0] access_size,
    input wire unsigned_access
);

reg[7:0] data[0:`MEM_SIZE - 1];

`ifndef BUILDING_RTL
integer i=0;
reg[31:0] temp[0:`TEMP_SIZE - 1];
initial begin
    $readmemh(`TEST_FILE, temp);

    for (i = 0; i < `TEMP_SIZE; i = i + 1) begin
        data[(i * 4) + 0 + 32'h01000000] = temp[i][7:0];
        data[(i * 4) + 1 + 32'h01000000] = temp[i][15:8];
        data[(i * 4) + 2 + 32'h01000000] = temp[i][23:16];
        data[(i * 4) + 3 + 32'h01000000] = temp[i][31:24];
    end
end
`endif

always @(posedge clock) begin
    if (! read_write) begin
        data[address]     <= data_in[7:0];

        if (access_size != `ACCESS_SIZE_BYTE) begin
            data[address + 1] <= data_in[15:8];
        end

        if (access_size == `ACCESS_SIZE_WORD) begin
            data[address + 2] <= data_in[23:16];
            data[address + 3] <= data_in[31:24];
        end
    end
end

wire byte_sign, half_word_sign;
assign byte_sign = data[address][7] & ~unsigned_access;
assign half_word_sign = data[address + 1][7] & ~unsigned_access;

always @(*) begin
    data_out[7:0] = data[address];

    if (access_size == `ACCESS_SIZE_BYTE) begin
        data_out[31:8] = {24{byte_sign}};
    end else if (access_size == `ACCESS_SIZE_HALF) begin
        data_out[15:8] = data[address + 1];
        data_out[31:16] = {16{half_word_sign}};
    end else begin /* ACCESS_SIZE_WORD */
        data_out[15:8] = data[address + 1];
        data_out[23:16] = data[address + 2];
        data_out[31:24] = data[address + 3];
    end
end

endmodule

