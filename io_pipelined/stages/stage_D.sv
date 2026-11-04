module stage_D
(
    input logic clock,
    input instr_packet_t F_D_instr,
    input instr_packet_t D_X_instr,
    input instr_packet_t X_M_instr,
    input instr_packet_t M_W_instr,
    input arch_reg rd_in,
    input reg_file_write_params_t reg_file_write,
    output arch_reg rs1_out,
    output arch_reg rs2_out,
    output arch_reg imm_out,
    output logic stall_F_D,

    output arch_reg registers[32]
);

imm_type_t imm_type;
reg_file_read_params_t reg_file_read;

decode_D decode_D_inst(
    /* Inputs */
    .instr(F_D_instr),
    .X_stage_instr(D_X_instr),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .reg_file_read_params(reg_file_read),
    .imm_type(imm_type),
    .stall_F_D(stall_F_D)
);

reg_file reg_file_inst(
    /* Inputs */
    .clock(clock),
    .read_params(reg_file_read),
    .write_params(reg_file_write),
    .data_rd(rd_in), //decode, from writeback stage?
    /* Outputs */
    .data_rs1(rs1_out),
    .data_rs2(rs2_out),
    .registers_out(registers)
);

imm_gen imm_gen_inst(
    /* Inputs */
    .instr(F_D_instr.params),
    .imm_type(imm_type),
    /* Outputs */
    .immediate_out(imm_out)
);

endmodule
