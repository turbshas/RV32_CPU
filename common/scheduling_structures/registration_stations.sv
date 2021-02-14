`define REG_STATIONS_WIDTH 2

module registration_station
parameter REG_FILE_ADDR_WIDTH = 7;

    typedef struct {
        reg valid;
        reg[31:0] instr;
        reg[REG_FILE_ADDR_WIDTH - 1:0] rd;
        reg[REG_FILE_ADDR_WIDTH - 1:0] rs1;
        reg[REG_FILE_ADDR_WIDTH - 1:0] rs2;
        reg rs1_ready;
        reg rs2_ready;
    } reg_stat;
(
    input wire clock,
    input wire reset,
    output wire used,
    output reg_stat[2**REG_STATIONS_WIDTH],
    input wire cdb_valid,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] cdb_in,

    input wire[REG_STATIONS_WIDTH - 1:0] reg_stat_selection,
    input wire clear,
    input wire write_en,
    input reg_stat reg_stat_in,
    input wire[31:0] instr_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rd_in,
    input wire rs1_ready_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs1_in,
    input wire rs2_ready_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs2_in
);

reg_stat stations[2**`REG_STATIONS_WIDTH];
wire[2**REG_STATIONS_WIDTH - 1:0] write_vector;

always @(*) begin
    used = valid;
    write_vector = write_en << reg_stat_selection;
end

integer i;
always @(posedge clock) begin
    if (reset) begin
        for (i = 0; i < 2**REG_STATIONS_WIDTH; i = i + 1) begin
            stations[i].valid = 0;
        end
    end else begin
        if (write_en) begin
            instr <= instr_in;
            rd <= rd_in;
            rs1 <= rs1_in;
            rs2 <= rs2_in;
            rs1_ready <= rs1_ready_in;
            rs2_ready <= rs2_ready_in;
            valid <= 1;
        end else if (clear) begin
            valid <= 0;
        end else if (cdb_valid) begin
            // If we see a cdb signal, check if those were the regs we were waiting for
            if (cdb_in == rs1) begin
                rs1_ready <= 1;
            end
            if (cdb_in == rs2) begin
                rs2_ready <= 1;
            end
        end
    end
end
