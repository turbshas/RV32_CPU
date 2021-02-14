module decode_DS
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire clock,
    input wire reset,
    input wire[31:0] instr,
    output wire[4:0] rd,
    output wire[4:0] rs1,
    output wire[4:0] rs2,

    output wire stall_PC,

    input wire reg_free_list_empty,
    output wire take_free_reg,

    output wire write_reg_map,

    input wire rob_full,
    output wire write_rob,

    input wire registration_station_used,
    output wire[:0] reg_stat_selection,
    output wire write_reg_stat
);

// Notes:
// Need to move these signals (can probably hardwire them)
// rs1/rs2 -> map table -> ps1/ps2 in registration station
//    - need to output rs1/rs2 from instr
//    - need to output write_en for registration station
// free list reg -> pd in registration station and ROB
//    - does any work need to be done in decode for this?
//    - need to output "take next free" signal
// rd -> map table -> old pd in ROB
//    - need to output rd from instr
//    - need to overwrite old value in map table on success (i.e. not stalling)
//
// No need to check for reg vs immediate use here - can do that in execute stage
// Registration stations:
//  - multiple ALUs?
//  - Load
//  - Store
reg[4:0] rd_internal;
reg[4:0] opcode;
reg op_has_dest;

always @(*) begin
    rd_internal = instr[11:7];
    opcode = instr[6:2];
    /* B-type and S-type have no destination. Also, ignore writes to x0 */
    op_has_dest = (opcode != 5'b11000) && (opcode != 5'b01000) && (rd_internal != 5'b00000);

    rd = rd_internal;
    rs1 = instr[19:15];
    rs2 = instr[24:20];
    stall_PC = reg_free_list_empty || rob_full || registration_station_used;
    take_free_reg = !stall_PC;
    write_rob = !stall_PC;
    write_reg_stat = !stall_PC;
    write_reg_map = !stall_PC && op_has_dest;
end
