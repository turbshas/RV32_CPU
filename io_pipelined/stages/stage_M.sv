module stage_M(
    input logic clock,
    input logic reset,
    input arch_reg X_M_instr,
    input arch_reg M_W_instr,
    input arch_reg X_M_exec_unit_out,
    input arch_reg X_M_dmem_in,
    input arch_reg write_back_out,

    output arch_reg dmem_out,

    // Test stuff
    input arch_reg setup_address,
    input arch_reg setup_data_in,
    input logic setup_write
);

mem_params_t dmem_params;
logic dmem_write_sel;
decode_M decode_M_inst(
    /* Inputs */
    .reset(reset),
    .instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .dmem_params(dmem_params),
    .mem_write_sel(dmem_write_sel)
);

// data in selection from bypass or reg
arch_reg dmem_data_in;
always_comb begin
    unique case (dmem_write_sel)
        1'b0: dmem_data_in = X_M_dmem_in;
        1'b1: dmem_data_in = write_back_out;
    endcase
end

mem dmem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(X_M_exec_unit_out),
    .data_in(dmem_data_in),
    .params(dmem_params),
    /* Outputs */
    .data_out(dmem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

endmodule

