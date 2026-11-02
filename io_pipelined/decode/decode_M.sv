import mem_pkg::mem_params_t;
import mem_pkg::mem_access_size_t;
import mem_pkg::MEM_ACCESS_BYTE;
import mem_pkg::MEM_OP_READ;
import mem_pkg::MEM_OP_WRITE;

module decode_M
(
    input wire[31:0] instr,
    input wire[31:0] W_stage_instr,
    output mem_params_t dmem_params,
    output reg mem_write_sel,
    output reg[1:0] reg_store_sel
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions
reg[2:0] funct3;
reg[4:0] instr_rs2;

// always block for picking out pieces of the instruction
always_comb begin
    opcode = instr[6:2];
    funct3 = instr[14:12];
    instr_rs2 = instr[24:20];
end

/* Memory stage */

// Bypassing dmem_in (mem_write_sel)
reg [4:0] W_opcode, W_rd;
reg W_no_rd;
always_comb begin
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

// mem is R/!W
always_comb begin
    case (opcode)
        5'b01000: dmem_params.op = MEM_OP_WRITE; // Stores
        default: dmem_params.op = MEM_OP_READ;
    endcase
end

always_comb begin
    case (opcode)
        // Loads, stores
        5'b00000, 5'b01000: dmem_params.access_size = mem_access_size_t'({funct3[1:0]});
        default: dmem_params.access_size = MEM_ACCESS_BYTE;
    endcase
end

always_comb begin
    case (opcode)
        // Loads, stores
        5'b00000, 5'b01000: dmem_params.read_unsigned = funct3[2];
        default: dmem_params.read_unsigned = 0;
    endcase
end

// reg_store_sel, either takes ALU, MEM, or PC+4
always_comb begin
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

