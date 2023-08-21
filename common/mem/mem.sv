import instructions_pkg::arch_reg;

`define MEM_SIZE (64*1024*1024)
`define TEMP_SIZE (4096)

package mem_pkg

typedef enum logic {
    MEM_OP_WRITE = 1'b0,
    MEM_OP_READ = 1'b1
} mem_op_t;

typedef enum logic[1:0] {
    MEM_ACCESS_BYTE = 2'b00,
    MEM_ACCESS_HALF = 2'b01,
    MEM_ACCESS_WORD = 2'b10,
    MEM_ACCESS_RSVD = 2'b11
} mem_access_size_t;

typedef struct packed {
    /** Affects sign extension on the value read from memory. */
    logic read_unsigned;
    mem_access_size_t access_size;
    mem_op_t op;
} mem_params_t;

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
    if (! read_write) begin
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
assign byte_sign = data[address][7] & ~unsigned_access;
assign half_word_sign = data[address + 1][7] & ~unsigned_access;

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

endpackage
