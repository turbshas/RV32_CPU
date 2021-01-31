module cdb
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire valid,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] value,
    output wire cdb_valid,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] cdb_value
);

// For now, just passthrough
assign cdb_valid = valid;
assign cdb_value = value;
