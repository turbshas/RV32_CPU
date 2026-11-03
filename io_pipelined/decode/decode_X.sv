import branch_compare_pkg::branch_cond_t;
import instructions_pkg::arch_reg_id;
import instructions_pkg::opcode_t;
import instructions_pkg::funct3_t;
import instructions_pkg::funct7_t;
import instructions_pkg::instr_packet_t;
import instructions_pkg::pc_input_sel_t;
import instructions_pkg::OPCODE_STORE;
import instructions_pkg::OPCODE_BRANCH;
import instructions_pkg::OPCODE_LUI;
import exec_unit_pkg::exec_unit_params_t;
import io_pipelined_pkg::exec_reg_forward_t;
import io_pipelined_pkg::NO_BYPASS;
import io_pipelined_pkg::FROM_MEM_STAGE;
import io_pipelined_pkg::FROM_WB_STAGE;

module decode_X
(
    input wire reset,
    input instr_packet_t instr,
    input pc_input_sel_t branch_result,
    input instr_packet_t M_stage_instr,
    input instr_packet_t W_stage_instr,
    output exec_unit_params_t exec_unit_params,
    output exec_reg_forward_t rs1_source,
    output exec_reg_forward_t rs2_source,
    output reg dmem_in_sel,
    output pc_input_sel_t pc_input_sel,
    output reg flush_F_D,
    output branch_compare_params_t branch_cmp_params
);

opcode_t opcode;
funct3_t funct3;
funct7_t funct7;
arch_reg_id instr_rs1, instr_rs2;

assign opcode = instr.opcode;
assign funct3 = instr.params.r_instr.funct3;
assign funct7 = instr.params.r_instr.funct7;
assign instr_rs1 = opcode == OPCODE_LUI ? `REGISTER_X0 : instr.params.r_instr.rs1;
assign instr_rs2 = instr.params.r_instr.rs2;

decode_branch_compare decode_branch_compare(
    .funct3(funct3),
    .params(branch_cmp_params)
);

decode_pc_input_select decode_pc_input_select(
    .reset(reset),
    .opcode(opcode),
    .branch_result(branch_result),
    .pc_input_sel(pc_input_sel)
);

decode_exec_unit decode_exec_unit(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .params(exec_unit_params)
);

/* If we're setting the PC, need to flush F and D stages */
assign flush_F_D = pc_input_sel;
// does not have forwarding from M stage, and rs2_source[0] only changes
// to a 1 when it detects it needs to forward from W stage
assign dmem_in_sel = rs2_source[0];

// logic for determining where rs1 or rs2 come from,
// bypass or reg file
// if rs1 or rs2 is not used, that is handled by other parts
//reg [1:0] rs1_source;
//reg [1:0] rs2_source;
opcode_t M_opcode, W_opcode;
arch_reg_id M_rd, W_rd;
reg M_no_rd, W_no_rd;
always_comb begin
    // have to look at instructions from X,M,W stages,
    // source priority: M then W then regfile
    // signals to set:
    //   2'b00 : reg file, 2'b10 : M, 2'b11 : W

    // pick off useful parts for figuring out Instr is
    // in each stage
    M_opcode = M_stage_instr.opcode;
    W_opcode = W_stage_instr.opcode;
    M_rd = M_stage_instr.params.r_instr.rd;
    W_rd = W_stage_instr.params.r_instr.rd;

    // determine if M and W stage has valid rd to forward, i.e. not S or B type
    M_no_rd = (M_opcode == OPCODE_STORE) || (M_opcode == OPCODE_BRANCH);
    W_no_rd = (W_opcode == OPCODE_STORE) || (W_opcode == OPCODE_BRANCH);

    // rs1_source bypass gives priority to youngest instruction
    if (instr_rs1 == `REGISTER_X0)
        rs1_source = NO_BYPASS; /* Whenever x0 is used, do not bypass */
    else begin
        if ((!M_no_rd) && (instr_rs1 == M_rd))
            rs1_source = FROM_MEM_STAGE;
        else if ((!W_no_rd) && (instr_rs1 == W_rd))
            rs1_source = FROM_WB_STAGE;
        else
            rs1_source = NO_BYPASS;
    end

    // rs2_source bypass gives priority to youngest instruction
    if (instr_rs2 == `REGISTER_X0)
        rs2_source = NO_BYPASS; /* Whenever x0 is used, do not bypass */
    else begin
        if ((!M_no_rd) && (instr_rs2 == M_rd))
            rs2_source = FROM_MEM_STAGE;
        else if ((!W_no_rd) && (instr_rs2 == W_rd))
            rs2_source = FROM_WB_STAGE;
        else
            rs2_source = NO_BYPASS;
    end
end

endmodule

