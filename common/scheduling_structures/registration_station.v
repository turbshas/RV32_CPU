module registration_station
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire clock,
    input wire reset,
    input wire clear,
    output wire used,
    input wire cdb_valid,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] cdb_in,

    input wire write_en,
    input wire[31:0] instr_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rd_in,
    input wire rs1_ready_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs1_in,
    input wire rs2_ready_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] rs2_in
);

reg valid;
reg[31:0] instr;
reg[REG_FILE_ADDR_WIDTH - 1:0] rd;
reg rs1_ready;
reg[REG_FILE_ADDR_WIDTH - 1:0] rs1;
reg rs2_ready;
reg[REG_FILE_ADDR_WIDTH - 1:0] rs2;

assign used = valid;

always @(posedge clock) begin
    if (reset) begin
        valid = 0;
    end else begin
        if (write_en) begin
            instr = instr_in;
            rd = rd_in;
            rs1 = rs1_in;
            rs2 = rs2_in;
            rs1_ready = rs1_ready_in;
            rs2_ready = rs2_ready_in;
            valid = 1;
        end else if (clear) begin
            valid = 0;
        end else if (cdb_valid) begin
            // If we see a cdb signal, check if those were the regs we were waiting for
            if (cdb_in == rs1) begin
                rs1_ready = 1;
            end
            if (cdb_in == rs2) begin
                rs2_ready = 1;
            end
        end
    end
end
