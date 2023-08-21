import instructions_pkg::arch_reg_id;
import instructions_pkg::arch_reg;

package reg_file_pkg;

typedef struct packed {
    arch_reg_id addr_rs1;
    arch_reg_id addr_rs2;
} reg_file_read_params_t;

typedef struct packed {
    arch_reg_id addr_rd;
    logic write_enable;
} reg_file_write_params_t;


module reg_file
(
    input wire clock,
    input reg_file_read_params_t read_params,
    input reg_file_write_params_t write_params,
    input arch_reg data_rd,
    output arch_reg data_rs1,
    output arch_reg data_rs2,
    output arch_reg registers_out[2**`REG_ADDR_WIDTH]
);

logic dest_is_not_x0;
logic valid_write;
arch_reg registers[2**`REG_ADDR_WIDTH];
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
    registers[`REGISTER_X0] = `REG_ADDR_WIDTH'b0;
    data_rs1 = registers[read_params.addr_rs1];
    data_rs2 = registers[read_params.addr_rs2];
    dest_is_not_x0 = write_params.addr_rd != `REG_ADDR_WIDTH'b0;
end

always_comb begin
    valid_write = write_params.write_enable & dest_is_not_x0;
end

always_ff @(posedge clock) begin
    if (valid_write) begin
        registers[write_params.addr_rd] <= data_rd;
    end
end

endmodule

endpackage
