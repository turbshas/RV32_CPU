module reg_map_table
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire clock,
    input wire reset,

    input wire[4:0] arch_reg_rs1,
    input wire[4:0] arch_reg_rs2,
    output wire ready_out_rs1,
    output wire ready_out_rs2,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] physical_reg_rs1,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] physical_reg_rs2,

    input wire update_map,
    input wire ready_in,
    input wire update_map_addr[4:0],
    input wire new_map_value[REG_FILE_ADDR_WIDTH - 1:0]
);

reg ready[32];
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_map[32];

// TODO: should this be clocked?
assign ready_out_rs1 = ready[arch_reg_rs1];
assign ready_out_rs2 = ready[arch_reg_rs2];
assign physical_reg_rs1 = reg_map[arch_reg_rs1];
assign physical_reg_rs2 = reg_map[arch_reg_rs2];

always @(posedge clock) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1) begin
            reg_map[i] = i;
        end
    end else begin
        if (update_map && update_map_addr != 5'b0) begin
            ready[update_map_addr] = ready_in;
            reg_map[update_map_addr] = new_map_value;
        end
    end
end
