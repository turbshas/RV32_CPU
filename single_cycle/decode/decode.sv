`include "constants.sv"
`include "exec_unit_interfaces.sv"

module decode
(
    input wire clock,
    input wire reset,
    input instr_packet instr,
    input wire branch_cmp_eq,
    input wire branch_cmp_lt,
    output reg reg_write_en,
    output reg[1:0] reg_store_sel,
    output arch_reg_id rd,
    output arch_reg_id rs1,
    output arch_reg_id rs2,
    output reg[2:0] imm_type,
    output exec_unit_params exec_params,
    output reg pc_input_sel,
    output reg mem_r_w,
    output reg[1:0] mem_access_size,
    output reg mem_load_unsigned,
    output reg branch_cmp_unsigned
);

// R-type values
opcode_32t opcode; 
funct3_t funct3;
funct7_t funct7;

// Memory Fence values
reg[3:0] fence_fm;
fence_instr_params fence_predecessor;
fence_instr_params fence_successor;

// always block for picking out pieces of the instruction
always @(*) begin
    opcode = instr.opcode;
    rd     = instr.params.r_instr.rd;
    funct3 = instr.params.r_instr.funct3;
    rs2    = instr.params.r_instr.rs2;
    funct7 = instr.params.r_instr.funct7;

    case (opcode)
        // LUI makes rs1 need to be set to reg 0
        `OPCODE_LUI: rs1 = 5'b00000;
        default: rs1 = instr.params.r_instr.rs1;
    endcase

    // Fence-specific values
    fence_fm = instr.params.fence.fm;
    fence_predecessor = instr.params.fence.predecessor;
    fence_successor = instr.params.fence.successor;
end

/* Reg/Immediate stage  */
always @(*) begin
    case (opcode)
        `OPCODE_JALR:   imm_type = `I_IMM_T;
        `OPCODE_LOAD:   imm_type = `I_IMM_T;
        `OPCODE_OP_IMM: imm_type = `I_IMM_T;
        `OPCODE_STORE:  imm_type = `S_IMM_T;
        `OPCODE_BRANCH: imm_type = `B_IMM_T;
        `OPCODE_LUI:    imm_type = `U_IMM_T;
        `OPCODE_AUIPC:  imm_type = `U_IMM_T;
        `OPCODE_JAL:    imm_type = `J_IMM_T;
        default:        imm_type = `NONE_IMM_T;
    endcase
end

/* Execute Stage  */

// exec_op
reg I_type_funct7;
always @(*) begin
    // SRAI/SRLI are the only I-type that uses funct7
    I_type_funct7 = (funct3 == 3'b101) & funct7[5];
    // changes based on r type or not used
    case (opcode)
        // R-Type
        `OPCODE_OP: exec_params.exec_op = {funct7[5], funct3};
        // I-Type
        `OPCODE_OP_IMM: exec_params.exec_op = {I_type_funct7, funct3};
        // All others, use add
        default: exec_params.exec_op = 4'b0000;
    endcase
end

// ALU operand1_sel / operand2_sel
always @(*) begin
    case (opcode)
        // R-Type
        `OPCODE_OP:
        begin
            exec_params.operand1_sel = `OP1_SEL_REG;
            exec_params.operand2_sel = `OP2_SEL_REG;
        end

        // B-Type, J-Type, AUIPC
        `OPCODE_BRANCH, `OPCODE_JAL, `OPCODE_AUIPC:
        begin
            exec_params.operand1_sel = `OP1_SEL_PC;
            exec_params.operand2_sel = `OP2_SEL_IMM;
        end

        // I-Type, S-Type, JALR, LUI (make sure rs1 is set to x0)
        //5'b00100, 5'b01000, 5'11001, 5'b01101:
        default:
        begin
            exec_params.operand1_sel = `OP1_SEL_REG;
            exec_params.operand2_sel = `OP2_SEL_IMM;
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
            `OPCODE_STORE, `OPCODE_BRANCH: reg_write_en = 0;
            default: reg_write_en = 1;
        endcase
    end
end

// reg_store_sel, either takes ALU, MEM, or PC+4
always @(*) begin
    case (opcode)
        // Loads
        `OPCODE_LOAD: reg_store_sel = 0; // MEM

        // JAL, JALR
        `OPCODE_JAL, `OPCODE_JALR: reg_store_sel = 2; // PC + 4

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
            `OPCODE_BRANCH:
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
            `OPCODE_JAL, `OPCODE_JALR: pc_input_sel = 1; // ALU

            // rest take PC+4 every time
            default: pc_input_sel = 0; // PC + 4

        endcase // opcode
    end
end

/* Memory stage */

// mem_r_w
// mem is R/!W (R = 1, W = 0)
always @(*) begin
    if (reset)
        mem_r_w = 1;
    else begin
        case (opcode)
            `OPCODE_STORE: mem_r_w = 0; // Stores
            default: mem_r_w = 1;
        endcase
    end
end

// mem_access_size
always @(*) begin
    case (opcode)
        // Loads, stores
        `OPCODE_LOAD, `OPCODE_STORE: mem_access_size = funct3[1:0];
        default: mem_access_size = 0;
    endcase
end

// mem_load_unsigned
always @(*) begin
    case (opcode)
        // Loads, stores
        `OPCODE_LOAD, `OPCODE_STORE: mem_load_unsigned = funct3[2];
        default: mem_load_unsigned = 0;
    endcase
end

endmodule

