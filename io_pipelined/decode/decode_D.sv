`include "constants.sv"
import instructions_pkg::arch_reg_id;
import instructions_pkg::arch_reg;
import instructions_pkg::instr_packet_t;
import instructions_pkg::opcode_t;
import instructions_pkg::OPCODE_LUI;
import instructions_pkg::OPCODE_BRANCH;
import instructions_pkg::OPCODE_STORE;
import instructions_pkg::OPCODE_LOAD;
import instructions_pkg::OPCODE_OP;
import imm_gen_pkg::imm_type_t;

module decode_D
(
    input instr_packet_t instr,
    input instr_packet_t X_stage_instr,
    input instr_packet_t M_stage_instr,
    input instr_packet_t W_stage_instr,
    output reg_file_read_params_t reg_file_read_params,
    output imm_type_t imm_type,
    output logic stall_F_D
);

opcode_t opcode;
funct3_t funct3;
assign opcode = instr.opcode;
assign funct3 = instr.params.r_instr.funct3;

decode_reg_file decode_reg_file(
    .instr(instr),
    .params(reg_file_read_params)
);

decode_imm_gen imm_gen_inst(
    .opcode(opcode),
    .funct3(funct3),
    .imm_type(imm_type)
);

opcode_t X_opcode, M_opcode, W_opcode;
arch_reg_id X_rd, M_rd, W_rd;
logic X_op_has_dest, M_op_has_dest, W_op_has_dest;
logic has_rs2;
logic X_dest_required_rs1, X_dest_required_rs2;
logic W_dest_required_rs1, W_dest_required_rs2;
logic M_bypass_available_rs1, M_bypass_available_rs2;
logic W_bypass_available_rs1, W_bypass_available_rs2;
logic load_use;
// always block for determining whether to stall or not
always_comb begin
    X_opcode = X_stage_instr.opcode;
    M_opcode = M_stage_instr.opcode;
    W_opcode = W_stage_instr.opcode;

    X_rd = X_stage_instr.params.r_instr.rd;
    M_rd = M_stage_instr.params.r_instr.rd;
    W_rd = W_stage_instr.params.r_instr.rd;

    /* B-type and S-type have no destination. Also, ignore writes to x0 */
    X_op_has_dest = (X_opcode != OPCODE_BRANCH) && (X_opcode != OPCODE_STORE) && (X_rd != `REGISTER_X0);
    M_op_has_dest = (M_opcode != OPCODE_BRANCH) && (M_opcode != OPCODE_STORE) && (M_rd != `REGISTER_X0);
    W_op_has_dest = (W_opcode != OPCODE_BRANCH) && (W_opcode != OPCODE_STORE) && (W_rd != `REGISTER_X0);

    /* Need to skip stall checks for rs2 if the op doesn't have an rs2 */
    /* B-type, S-type, and R-type are the only ops with rs2 */
    has_rs2 = (opcode == OPCODE_BRANCH) || (opcode == OPCODE_STORE) || (opcode == OPCODE_OP);

    X_dest_required_rs1 = X_op_has_dest && (X_rd == reg_file_read_params.addr_rs1);
    X_dest_required_rs2 = X_op_has_dest && (X_rd == reg_file_read_params.addr_rs2) && has_rs2;

    W_dest_required_rs1 = W_op_has_dest && (W_rd == reg_file_read_params.addr_rs2);
    W_dest_required_rs2 = W_op_has_dest && (W_rd == reg_file_read_params.addr_rs2) && has_rs2;

    /* Don't have to stall for W-D RAW hazards if there is a forwarding path */
    /*
    * In this case M/W-bypass available means there will be a
    * bypass when the current instruction gets to the X stage
    */
    M_bypass_available_rs1 = X_op_has_dest && (X_rd == reg_file_read_params.addr_rs1);
    M_bypass_available_rs2 = X_op_has_dest && (X_rd == reg_file_read_params.addr_rs2);
    W_bypass_available_rs1 = M_op_has_dest && (M_rd == reg_file_read_params.addr_rs1);
    W_bypass_available_rs2 = M_op_has_dest && (M_rd == reg_file_read_params.addr_rs2);

    /* Need to stall for load-use hazards */
    load_use = (X_opcode == OPCODE_LOAD) && (X_dest_required_rs1 || X_dest_required_rs2);

    stall_F_D =
        (W_dest_required_rs1 && !(M_bypass_available_rs1 || W_bypass_available_rs1))
     || (W_dest_required_rs2 && !(M_bypass_available_rs2 || W_bypass_available_rs2))
     || load_use;
end

endmodule

