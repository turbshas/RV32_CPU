import instructions_pkg::arch_reg;
import mem_pkg::mem_params_t;
import mem_pkg::MEM_ACCESS_BYTE;
import mem_pkg::MEM_ACCESS_HALF;
import mem_pkg::MEM_ACCESS_WORD;
import mem_pkg::MEM_OP_READ;
import mem_pkg::MEM_OP_WRITE;

`define MEM_SIZE (64*1024*1024)
`define TEMP_SIZE (4096)

module mem
(
    input logic clock,
    input logic reset,
    input arch_reg address,
    input arch_reg data_in,
    output arch_reg data_out,
    input mem_params_t params,

    input arch_reg setup_address,
    input arch_reg setup_data_in,
    input logic setup_write
);

reg[7:0] data[0:`MEM_SIZE - 1];

/* Preparing data at runtime */
always @(posedge clock) begin
    if (reset && setup_write) begin
        data[setup_address] <= setup_data_in[7:0];
        data[setup_address + 1] <= setup_data_in[15:8];
        data[setup_address + 2] <= setup_data_in[23:16];
        data[setup_address + 3] <= setup_data_in[31:24];
    end
end

always @(posedge clock) begin
    if (params.op == MEM_OP_WRITE) begin
        data[address]     <= data_in[7:0];

        if (params.access_size != MEM_ACCESS_BYTE) begin
            data[address + 1] <= data_in[15:8];
        end

        if (params.access_size == MEM_ACCESS_WORD) begin
            data[address + 2] <= data_in[23:16];
            data[address + 3] <= data_in[31:24];
        end
    end
end

wire byte_sign, half_word_sign;
assign byte_sign = data[address][7] & ~params.read_unsigned;
assign half_word_sign = data[address + 1][7] & ~params.read_unsigned;

always @(*) begin
    data_out[7:0] = data[address];

    if (params.access_size == MEM_ACCESS_BYTE) begin
        data_out[31:8] = {24{byte_sign}};
    end else if (params.access_size == MEM_ACCESS_HALF) begin
        data_out[15:8] = data[address + 1];
        data_out[31:16] = {16{half_word_sign}};
    end else begin /* MEM_ACCESS_WORD */
        data_out[15:8] = data[address + 1];
        data_out[23:16] = data[address + 2];
        data_out[31:24] = data[address + 3];
    end
end

endmodule
