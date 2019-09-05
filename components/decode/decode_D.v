`include "imm_gen_inc.v"

module decode_D
(
    input wire[31:0] instr,
    input wire[31:0] X_stage_instr,
    input wire[31:0] M_stage_instr,
    input wire[31:0] W_stage_instr,
    output reg[4:0] rs1,
    output reg[4:0] rs2,
    output reg[2:0] imm_type,
    output reg stall_F_D
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions

// always block for picking out pieces of the instruction
always @(*) begin
    opcode = instr[6:2];

    case (opcode)
        // LUI makes this need to be set to reg 0
        5'b01101: rs1 = 5'b00000;
        default: rs1 = instr[19:15];
    endcase

    rs2    = instr[24:20];
end

/* Reg/Immediate stage  */

// always block for determining instruction type
always @(*) begin
    case (opcode)
        5'b11001: imm_type = `I_IMM_T;
        5'b00000: imm_type = `I_IMM_T;
        5'b00100: imm_type = `I_IMM_T;
        5'b01000: imm_type = `S_IMM_T;
        5'b11000: imm_type = `B_IMM_T;
        5'b01101: imm_type = `U_IMM_T;
        5'b00101: imm_type = `U_IMM_T;
        5'b11011: imm_type = `J_IMM_T;
        default: imm_type = `NONE_IMM_T;
    endcase
end

reg[4:0] X_opcode, X_rd;
reg[4:0] M_opcode, M_rd;
reg[4:0] W_opcode, W_rd;
reg X_op_has_dest, M_op_has_dest, W_op_has_dest;
reg has_rs2;
reg X_dest_required_rs1, X_dest_required_rs2;
reg W_dest_required_rs1, W_dest_required_rs2;
reg M_bypass_available_rs1, M_bypass_available_rs2;
reg W_bypass_available_rs1, W_bypass_available_rs2;
reg load_use;
// always block for determining whether to stall or not
always @(*) begin
    X_opcode = X_stage_instr[6:2];
    M_opcode = M_stage_instr[6:2];
    W_opcode = W_stage_instr[6:2];
    X_rd = X_stage_instr[11:7];
    M_rd = M_stage_instr[11:7];
    W_rd = W_stage_instr[11:7];

    /* B-type and S-type have no destination. Also, ignore writes to x0 */
    X_op_has_dest = (X_opcode != 5'b11000) && (X_opcode != 5'b01000) && (X_rd != 5'b00000);
    M_op_has_dest = (M_opcode != 5'b11000) && (M_opcode != 5'b01000) && (M_rd != 5'b00000);
    W_op_has_dest = (W_opcode != 5'b11000) && (W_opcode != 5'b01000) && (W_rd != 5'b00000);

    /* Need to skip stall checks for rs2 if the op doesn't have an rs2 */
    /* B-type, S-type, and R-type are the only ops with rs2 */
    has_rs2 = (opcode == 5'b11000) || (opcode == 5'b01000) || (opcode == 5'b01100);

    X_dest_required_rs1 = X_op_has_dest && (X_rd == rs1);
    X_dest_required_rs2 = X_op_has_dest && (X_rd == rs2) && has_rs2;

    W_dest_required_rs1 = W_op_has_dest && (W_rd == rs1);
    W_dest_required_rs2 = W_op_has_dest && (W_rd == rs2) && has_rs2;

    /* Don't have to stall for W-D RAW hazards if there is a forwarding path */
    /*
    * In this case M/W-bypass available means there will be a
    * bypass when the current instruction gets to the X stage
    */
    M_bypass_available_rs1 = X_op_has_dest && (X_rd == rs1);
    M_bypass_available_rs2 = X_op_has_dest && (X_rd == rs2);
    W_bypass_available_rs1 = M_op_has_dest && (M_rd == rs1);
    W_bypass_available_rs2 = M_op_has_dest && (M_rd == rs2);

    /* Need to stall for load-use hazards */
    load_use = (X_opcode == 5'b00000) && (X_dest_required_rs1 || X_dest_required_rs2);

    stall_F_D =
        (W_dest_required_rs1 && !(M_bypass_available_rs1 || W_bypass_available_rs1))
     || (W_dest_required_rs2 && !(M_bypass_available_rs2 || W_bypass_available_rs2))
     || load_use;
end

endmodule

