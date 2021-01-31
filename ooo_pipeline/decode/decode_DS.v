module decode_DS
parameter REG_FILE_ADDR_WIDTH = 7;
(
    output wire stall_PC,

    input wire reg_free_list_empty,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] free_reg_num,
    output wire take_free_reg,

    input wire rob_full,
    output wire write_rob,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] rob_dest_reg,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] rob_old_dest_reg,

    input wire registration_station_used,
    output wire[:0] reg_stat_selection,
    output wire write_reg_stat,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rd,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rs1,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rs2,
    output wire reg_stat_rs1_ready,
    output wire reg_stat_rs2_ready,
);

assign stall_PC = reg_free_list_empty || rob_full || registration_station_used;

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
