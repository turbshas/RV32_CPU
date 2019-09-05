module decode_M
(
    input wire[31:0] instr,
    input wire[31:0] W_stage_instr,
    output reg mem_r_w,
    output reg[1:0] mem_access_size,
    output reg mem_load_unsigned,
    output reg mem_write_sel,
    output reg[1:0] reg_store_sel
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions
reg[2:0] funct3;
reg[4:0] instr_rs2;

// always block for picking out pieces of the instruction
always @(*) begin
    opcode = instr[6:2];
    funct3 = instr[14:12];
    instr_rs2 = instr[24:20];
end

/* Memory stage */

// Bypassing dmem_in (mem_write_sel)
reg [4:0] W_opcode, W_rd;
reg W_no_rd;
always @(*) begin
    // pick off useful parts for figuring out Instr is
    // in W stage
    W_opcode = W_stage_instr[6:2];
    W_rd = W_stage_instr[11:7];
    
    // check if instruction has a valid rd or not
    W_no_rd = (W_opcode == 5'b01000) || (W_opcode == 5'b11000) || (W_rd == 5'b00000);
    
    if ((!W_no_rd) && (instr_rs2 == W_rd))
        mem_write_sel = 1'b1; // use bypass
    else
        mem_write_sel = 1'b0; // use stage's register
end

// mem_r_w
// mem is R/!W
always @(*) begin
    case (opcode)
        5'b01000: mem_r_w = 0; // Stores
        default: mem_r_w = 1;
    endcase
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

endmodule

