`include "imm_gen_inc.v"

module decode
(
    input wire clock,
    input wire reset,
    input wire[31:0] instr,
    input wire branch_cmp_eq,
    input wire branch_cmp_lt,
    output reg[3:0] exec_op,
    output reg reg_write_en,
    output reg[1:0] reg_store_sel,
    output reg[4:0] rd,
    output reg[4:0] rs1,
    output reg[4:0] rs2,
    output reg[2:0] imm_type,
    output reg operand1_sel,
    output reg operand2_sel,
    output reg pc_input_sel,
    output reg mem_r_w,
    output reg[1:0] mem_access_size,
    output reg mem_load_unsigned,
    output reg branch_cmp_unsigned
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions
reg[2:0] funct3;
reg[6:0] funct7;

// always block for picking out pieces of the instruction
always @(*) begin
    opcode = instr[6:2];
    rd     = instr[11:7];
    funct3 = instr[14:12];

    case (opcode)
        // LUI makes this need to be set to reg 0
        5'b01101: rs1 = 5'b00000;
        default: rs1 = instr[19:15];
    endcase

    rs2    = instr[24:20];
    funct7 = instr[31:25];

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

// 

/* Execute Stage  */

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

// ALU operand1_sel / operand2_sel
always @(*) begin
    case (opcode)
        // R-Type
        5'b01100:
        begin
            operand1_sel = 0; // reg
            operand2_sel = 0; // reg
        end

        // B-Type, J-Type, AUIPC
        5'b11000, 5'b11011 , 5'b00101 :
        begin
            operand1_sel = 1; // PC
            operand2_sel = 1; // imm
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        //5'b00100, 5'b01000, 5'11001, 5'b01101:
        default:
        begin
            operand1_sel = 0; // reg
            operand2_sel = 1; // imm
        end


    endcase
end


/* Write-Back Stage  */

// reg_write_en
always @(*) begin
    if (reset)
        reg_write_en = 0;
    else begin
        case (opcode)
            // S-Type, B-Type
            5'b01000, 5'b11000: reg_write_en = 0;
            default: reg_write_en = 1;
        endcase
    end
end

// reg_store_sel, either takes ALU, MEM, or PC+4
always @(*) begin
    case (opcode)
        // Loads
        5'b00000: reg_store_sel = 0; // MEM

        // JAL, JALR
        5'b11011, 5'b11001: reg_store_sel = 2; // PC + 4

        // All other ops modify registers in rd
        default: reg_store_sel = 1; // ALU
    endcase
end

// branch_cmp_unsigned
always @(*) begin
    branch_cmp_unsigned = funct3[1];
end

// pc_input_sel
always @(*) begin
    // either takes PC+4 or ALU when branch false or true respectively, on
    // a B instruction
    // always take jump on a jump instruction
    if (reset)
        pc_input_sel = 0;
    else begin
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
end

// mem_r_w
// mem is R/!W
always @(*) begin
    if (reset)
        mem_r_w = 1;
    else begin
        case (opcode)
            5'b01000: mem_r_w = 0; // Stores
            default: mem_r_w = 1;
        endcase
    end
end

// mem_access_size
always @(*) begin
    case (opcode)
        // Loads, stores
        5'b00000, 5'b01000: mem_access_size = funct3[1:0];
        default: mem_access_size = 0;
    endcase
end

// mem_load_unsigned
always @(*) begin
    case (opcode)
        // Loads, stores
        5'b00000, 5'b01000: mem_load_unsigned = funct3[2];
        default: mem_load_unsigned = 0;
    endcase
end

endmodule

