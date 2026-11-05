module stage_W(
    input logic reset,
    input instr_packet_t M_W_instr,
    input arch_reg M_W_dmem_out,
    input arch_reg M_W_exec_unit_out,
    input arch_reg M_W_PC_out,
    output reg_file_write_params_t reg_file_write,
    output arch_reg write_back_out
);

write_back_select_t write_back_sel;
decode_W decode_W_inst(
    /* Inputs */
    .reset(reset),
    .instr(M_W_instr),
    /* Outputs */
    .reg_file_write_params(reg_file_write),
    .reg_store_sel(write_back_sel)
);

write_back write_back_inst(
    //inputs
    .mem_in(M_W_dmem_out),
    .alu_in(M_W_exec_unit_out),
    .pc_in(M_W_PC_out),
    .write_back_sel(write_back_sel),

    // outputs
    .write_back_out(write_back_out)
);

endmodule

