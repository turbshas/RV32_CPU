module stage_X(
    input logic reset,
    input arch_reg D_X_PC_out,
    input arch_reg D_X_instr,
    input arch_reg X_M_instr,
    input arch_reg M_W_instr,
    input arch_reg X_M_exec_unit_out,
    input arch_reg write_back_out,
    input arch_reg D_X_rs1,
    input arch_reg D_X_rs2,
    input arch_reg D_X_imm,

    output logic pc_input_sel,
    output logic flush_F_D,
    output arch_reg exec_unit_out,
    output arch_reg dmem_in
);

/* Forwarding logic for rs1 and rs2 */
exec_reg_forward_t rs1_source, rs2_source;
arch_reg rs1_forwarded, rs2_forwarded;
always_comb begin
    case (rs1_source)
        /* Forward from the memory stage */
        FROM_MEM_STAGE: rs1_forwarded = X_M_exec_unit_out;
        /* Forward from the writeback stage */
        FROM_WB_STAGE: rs1_forwarded = write_back_out;
        default: rs1_forwarded = D_X_rs1;
    endcase

    case (rs2_source)
        /* Forward from the memory stage */
        FROM_MEM_STAGE: rs2_forwarded = X_M_exec_unit_out;
        /* Forward from the writeback stage */
        FROM_WB_STAGE: rs2_forwarded = write_back_out;
        default: rs2_forwarded = D_X_rs2;
    endcase
end

/* Execute stage */
branch_compare_params_t branch_compare_params;

pc_input_sel_t branch_result;
exec_unit_params_t exec_unit_params;
logic dmem_in_sel;
decode_X decode_X_instr(
    /* Inputs */
    .reset(reset),
    .instr(D_X_instr),
    .branch_result(branch_result),
    .M_stage_instr(X_M_instr),
    .W_stage_instr(M_W_instr),
    /* Outputs */
    .rs1_source(rs1_source),
    .rs2_source(rs2_source),
    .exec_unit_params(exec_unit_params),
    .dmem_in_sel(dmem_in_sel),
    .pc_input_sel(pc_input_sel),
    .flush_F_D(flush_F_D),
    .branch_cmp_params(branch_compare_params)
);

branch_compare branch_compare_inst(
    /* Inputs */
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .params(branch_compare_params),
    /* Outputs */
    .branch_result(branch_result)
);

exec_unit exec_unit_inst(
    // inputs
    .pc(D_X_PC_out),
    .rs1(rs1_forwarded),
    .rs2(rs2_forwarded),
    .imm_val(D_X_imm),
    .params(exec_unit_params),

    // outputs
    .exec_out(exec_unit_out)
);

// logic for bypassing W to X for data in,
// useful in case of ALU-Store-Store case
always_comb begin
    unique case(dmem_in_sel)
        1'b0: dmem_in = D_X_rs2;
        1'b1: dmem_in = write_back_out;
    endcase
end

endmodule

