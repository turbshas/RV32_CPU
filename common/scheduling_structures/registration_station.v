module registration_station
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire clock,
    input wire reset,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] cdb_in,

    input wire write_en,
    input wire[31:0] instr_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rd_in,
    input wire rs1_ready,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs1_in,
    input wire rs2_ready,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs2_in,
);
