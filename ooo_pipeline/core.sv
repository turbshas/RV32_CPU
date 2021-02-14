`define NOP_INSTR 32'h00000013
`define REG_FILE_ADDR_WIDTH 7

module core
(
    input wire clock,
    input wire reset,
    output wire[31:0] instr_out,
    output reg[31:0] registers[32],

    input wire setup_write,
    input wire[31:0] setup_address,
    input wire[31:0] setup_data_in
);

/* Pipeline registers */
reg[31:0] F_D_PC_out;
reg[31:0] F_D_instr;

reg[31:0] D_X_PC_out;
reg[31:0] D_X_instr;
reg[31:0] D_X_rs1;
reg[31:0] D_X_rs2;
reg[31:0] D_X_imm;

reg[31:0] X_M_PC_out;
reg[31:0] X_M_instr;
reg[31:0] X_M_exec_unit_out;
reg[31:0] X_M_dmem_in;

reg[31:0] M_W_instr;
reg[31:0] M_W_writeback_out;

// Component connecting wires
reg[31:0] PC_out;
reg[31:0] imem_out;
reg stall_F_D;
reg pc_input_sel;
reg[31:0] new_PC_in;
reg[31:0] instr;
reg flush_F_D;

reg take_from_free_list;
reg[REG_FILE_ADDR_WIDTH - 1:0] free_reg_num;
reg reg_freed;
reg[REG_FILE_ADDR_WIDTH - 1:0] freed_reg_num;
reg reg_free_list_empty;
reg reg_free_list_full;

reg[4:0] reg_map_rd_in;
reg[4:0] reg_map_rs1_in;
reg[4:0] reg_map_rs2_in;
reg reg_map_rd_ready_out;
reg reg_map_rs1_ready_out;
reg reg_map_rs2_ready_out;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_map_rd_out;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_map_rs1_out;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_map_rs2_out;
reg reg_map_write_en;
reg reg_map_ready_in;
reg[4:0] reg_map_new_mapping_arch_in;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_map_new_mapping_value_in;

reg rob_write_en;
reg rob_empty;
reg rob_full;

reg[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rd;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rs1;
reg[REG_FILE_ADDR_WIDTH - 1:0] reg_stat_rs2;
reg reg_stat_rs1_ready;
reg reg_stat_rs2_ready;

// Fetch stage components
mem imem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(PC_out),
    .data_in(),
    .read_write(1),
    .access_size(`ACCESS_SIZE_WORD),
    .unsigned_access(1),
    /* Outputs */
    .data_out(imem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

fetch fetch_inst(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .data_in(imem_out),
    .set_PC(pc_input_sel),
    .new_PC(new_PC_in),
    .stall_PC(stall_F_D),
    /* Outputs */
    .PC_out(PC_out),
    .instr(instr)
);

reg_free_list reg_free_list_inst(
    // Inputs
    .clock(clock),
    .reset(reset),
    .take_next_free(take_from_free_list),
    .reg_freed(reg_freed),
    .freed_reg_num(freed_reg_num),

    // Outputs
    .free_reg_num(free_reg_num),
    .empty(reg_free_list_empty),
    .output wire full(reg_free_list_full)
);

reg_map_table reg_map_table_inst(
    // Inputs
    .clock(clock),
    .reset(reset),
    .arch_reg_rd(reg_map_rd_in),
    .arch_reg_rs1(reg_map_rs1_in),
    .arch_reg_rs2(reg_map_rs2_in),
    .update_map(reg_map_write_en),
    .ready_in(reg_map_ready_in),
    .update_map_addr(reg_map_new_mapping_arch_in),
    .new_map_value(reg_map_new_mapping_value_in)

    // Outputs
    .ready_out_rd(reg_map_rd_ready_out),
    .ready_out_rs1(reg_map_rs1_ready_out),
    .ready_out_rs2(reg_map_rs2_ready_out),
    .physical_reg_rd(reg_map_rd_out),
    .physical_reg_rs1(reg_map_rs1_out),
    .physical_reg_rs2,(reg_map_rs2_out)
);

reorder_buffer reorder_buffer_inst(
    // Input
    .clock(clock),
    .reset(reset),
    .write_en(rob_write_en),
    .rob_entry_in({ F_D_instr, 0, 0, free_reg_num, reg_map_rd_out }),
    input wire complete_instr,
    input wire[ROB_ADDR_WIDTH - 1:0] completed_addr,
    input wire interrupt_triggered,

    // Output
    output rob_entry rob_entry_out,
    output wire retiring_instr,
    .empty(rob_empty),
    .full(rob_full),
    output wire rolling_back,
    output wire[31:0] rolling_back_instr,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] phys_reg_mapping
);

// Dispatch stage components
decode_DS decode_DS_inst(
    // Inputs
    .clock(clock),
    .reset(reset),
    .instr(F_D_instr),
    .reg_free_list_empty(reg_free_list_empty),
    .rob_full(rob_full),
    .registration_station_used,

    // Outputs
    .rd(reg_map_rd_in),
    .rs1(reg_map_rs1_in),
    .rs2(reg_map_rs2_in),
    .stall_PC(stall_F_D),
    .take_free_reg(take_from_free_list),
    .write_reg_map(reg_map_write_en),
    .write_rob(rob_write_en),
    output wire[:0] reg_stat_selection,
    output wire write_reg_stat
);

always @(*) begin
    reg_stat_rd = free_reg_num;
    reg_stat_rs1 = reg_map_rs1_out;
    reg_stat_rs2 = reg_map_rs2_out;
    reg_stat_rs1_ready = reg_map_rs1_ready_out;
    reg_stat_rs2_ready = reg_map_rs2_ready_out;
end

always @(posedge clock) begin
    if (reset || flush_F_D) begin
        F_D_instr <= `NOP_INSTR;
    end else begin
        F_D_instr <= instr;
        F_D_PC_out <= PC_out;
    end
end
