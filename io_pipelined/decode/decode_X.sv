import branch_compare_pkg::branch_cond_t;
import instructions_pkg::pc_input_sel_t;
import instructions_pkg::PC_INPUT_ALU;
import instructions_pkg::PC_INPUT_PC_PLUS_4;
import exec_unit_pkg::exec_unit_params_t;
import exec_unit_pkg::exec_op_t;
import exec_unit_pkg::EXEC_OP_ADD;
import exec_unit_pkg::OP1_SEL_REG;
import exec_unit_pkg::OP1_SEL_PC;
import exec_unit_pkg::OP2_SEL_REG;
import exec_unit_pkg::OP2_SEL_IMM;

module decode_X
(
    input wire[31:0] instr,
    input pc_input_sel_t branch_result,
    input wire[31:0] M_stage_instr,
    input wire[31:0] W_stage_instr,
    output exec_unit_params_t exec_unit_params,
    output reg[1:0] rs1_source,
    output reg[1:0] rs2_source,
    output reg dmem_in_sel,
    output pc_input_sel_t pc_input_sel,
    output reg flush_F_D,
    output branch_compare_params_t branch_cmp_params
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions
reg[2:0] funct3;
reg[6:0] funct7;
reg [4:0] instr_rs1, instr_rs2;

// always block for picking out pieces of the instruction
always_comb begin
    opcode = instr[6:2];
    funct3 = instr[14:12];
    funct7 = instr[31:25];
    case (opcode)
        // LUI makes this need to be set to reg 0
        5'b01101: instr_rs1 = 5'b00000;
        default: instr_rs1 = instr[19:15];
    endcase
    instr_rs2 = instr[24:20];
end

assign branch_cmp_params.unsigned_cmp = funct3[1];
assign branch_cmp_params.branch_cond = branch_cond_t'({funct3[2],funct3[0]});
/* If we're setting the PC, need to flush F and D stages */
assign flush_F_D = pc_input_sel;
// does not have forwarding from M stage, and rs2_source[0] only changes
// to a 1 when it detects it needs to forward from W stage
assign dmem_in_sel = rs2_source[0];

always_comb begin
    // either takes PC+4 or ALU when branch false or true respectively, on
    // a B instruction
    // always take jump on a jump instruction
    case (opcode)
        // B-Type
        5'b11000: pc_input_sel = branch_result;
        // Jump is unconditional
        5'b11001, 5'b11011: pc_input_sel = PC_INPUT_ALU;
        // rest take PC+4 every time
        default: pc_input_sel = PC_INPUT_PC_PLUS_4;
    endcase // opcode
end

reg I_type_funct7;
always_comb begin
    // SRAI/SRLI are the only I-type that uses funct7
    I_type_funct7 = (funct3 == 3'b101) & funct7[5];
    // changes based on r type or not used
    case (opcode)
        // R-Type
        5'b01100: exec_unit_params.exec_op = exec_op_t'({funct7[5], funct3});
        // I-Type
        5'b00100: exec_unit_params.exec_op = exec_op_t'({I_type_funct7, funct3});
        // All others, use add
        default: exec_unit_params.exec_op = EXEC_OP_ADD;
    endcase
end

// TODO: see if I can clean this block up as well
// logic for determining where rs1 or rs2 come from,
// bypass or reg file
// if rs1 or rs2 is not used, that is handled by other parts
//reg [1:0] rs1_source;
//reg [1:0] rs2_source;
reg [4:0] M_opcode, M_rd;
reg [4:0] W_opcode, W_rd;
reg M_no_rd, W_no_rd;
always_comb begin
    // have to look at instructions from X,M,W stages,
    // source priority: M then W then regfile
    // signals to set:
    //   2'b00 : reg file, 2'b10 : M, 2'b11 : W

    // pick off useful parts for figuring out Instr is
    // in each stage
    M_opcode = M_stage_instr[6:2];
    W_opcode = W_stage_instr[6:2];
    M_rd = M_stage_instr[11:7];
    W_rd = W_stage_instr[11:7];

    // determine if M and W stage has valid rd to forward, i.e. not S or B type
    M_no_rd = (M_opcode == 5'b01000) || (M_opcode == 5'b11000);
    W_no_rd = (W_opcode == 5'b01000) || (W_opcode == 5'b11000);

    // rs1_source bypass gives priority to youngest instruction
    if (instr_rs1 == 5'b00000)
        rs1_source = 2'b00; /* Whenever x0 is used, do not bypass */
    else begin
        if ((!M_no_rd) && (instr_rs1 == M_rd))
            rs1_source = 2'b10;
        else if ((!W_no_rd) && (instr_rs1 == W_rd))
            rs1_source = 2'b11;
        else
            rs1_source = 2'b00;
    end

    // rs2_source bypass gives priority to youngest instruction
    if (instr_rs2 == 5'b00000)
        rs2_source = 2'b00; /* Whenever x0 is used, do not bypass */
    else begin
        if ((!M_no_rd) && (instr_rs2 == M_rd))
            rs2_source = 2'b10;
        else if ((!W_no_rd) && (instr_rs2 == W_rd))
            rs2_source = 2'b11;
        else
            rs2_source = 2'b00;
    end
end

always_comb begin
    case (opcode)
        // R-Type
        5'b01100:
        begin
            exec_unit_params.operand1_sel = OP1_SEL_REG;
            exec_unit_params.operand2_sel = OP2_SEL_REG;
        end

        // B-Type, J-Type, AUIPC
        5'b11000, 5'b11011 , 5'b00101 :
        begin
            exec_unit_params.operand1_sel = OP1_SEL_PC;
            exec_unit_params.operand2_sel = OP2_SEL_IMM;
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        //5'b00100, 5'b01000, 5'11001, 5'b01101:
        default:
        begin
            exec_unit_params.operand1_sel = OP1_SEL_REG;
            exec_unit_params.operand2_sel = OP2_SEL_IMM;
        end
    endcase
end

endmodule

