module decode_X
(
    input wire[31:0] instr,
    input wire branch_cmp_eq,
    input wire branch_cmp_lt,
    input wire[31:0] M_stage_instr,
    input wire[31:0] W_stage_instr,
    output reg[3:0] exec_op,
    output reg[1:0] operand1_sel,
    output reg[1:0] operand2_sel,
    output reg[1:0] b_operand1_sel,
    output reg[1:0] b_operand2_sel,
    output reg dmem_in_sel ,
    output reg pc_input_sel,
    output reg flush_F_D,
    output reg branch_cmp_unsigned
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions
reg[2:0] funct3;
reg[6:0] funct7;
reg [4:0] instr_rs1, instr_rs2;

// always block for picking out pieces of the instruction
always @(*) begin
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

/* Execute Stage  */

// branch_cmp_unsigned
always @(*) begin
    branch_cmp_unsigned = funct3[1];
end

// pc_input_sel
always @(*) begin
    // either takes PC+4 or ALU when branch false or true respectively, on
    // a B instruction
    // always take jump on a jump instruction
    case (opcode)
        // B-Type
        5'b11000:
          begin
            // Check each branch inst.
            case ({funct3[2],funct3[0]})
                2'b00: pc_input_sel = branch_cmp_eq; // BEQ
                2'b01: pc_input_sel = !(branch_cmp_eq); // BNE
                2'b11: pc_input_sel = !(branch_cmp_lt); // BGE
                2'b10: pc_input_sel = branch_cmp_lt; // BLT
            endcase // funct3
          end
        
        // Jump is unconditional
        5'b11001, 5'b11011: pc_input_sel = 1; // ALU

        // rest take PC+4 every time
        default: pc_input_sel = 0; // PC + 4
    endcase // opcode
end

always @(*) begin
    /* If we're setting the PC, need to flush F and D stages */
    flush_F_D = pc_input_sel;
end

// exec_op
reg I_type_funct7;
always @(*) begin
    // SRAI/SRLI are the only I-type that uses funct7
    I_type_funct7 = (funct3 == 3'b101) & funct7[5];
    // changes based on r type or not used
    case (opcode)
        // R-Type
        5'b01100: exec_op = {funct7[5], funct3};
        // I-Type
        5'b00100: exec_op = {I_type_funct7, funct3};
        // All others, use add
        default: exec_op = 4'b0000;
    endcase
end

// logic for determining where rs1 or rs2 come from,
// bypass or reg file
// if rs1 or rs2 is not used, that is handled by other parts
reg [1:0] rs1_source;
reg [1:0] rs2_source;
reg [4:0] M_opcode, M_rd;
reg [4:0] W_opcode, W_rd;
reg M_no_rd, W_no_rd;
always @(*) begin
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

// ALU operand1_sel / operand2_sel
always @(*) begin
    case (opcode)
        // R-Type
        5'b01100:
        begin
            operand1_sel = rs1_source; // reg
            operand2_sel = rs2_source; // reg
        end

        // B-Type, J-Type, AUIPC
        5'b11000, 5'b11011 , 5'b00101 :
        begin
            operand1_sel = 2'b01; // PC
            operand2_sel = 2'b01; // imm
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        //5'b00100, 5'b01000, 5'11001, 5'b01101:
        default:
        begin
            operand1_sel = rs1_source; // reg
            operand2_sel = 2'b01; // imm
        end
    endcase
end

// Branch b_operand1_sel / b_operand2_sel
always @(*) begin
    b_operand1_sel = rs1_source;
    b_operand2_sel = rs2_source;
end

// dmem_in_sel logic
always @(*) begin
    // does not have forwarding from M stage, and rs2_source[0] only changes
    // to a 1 when it detects it needs to forward from W stage
    dmem_in_sel = rs2_source[0];
end

endmodule

