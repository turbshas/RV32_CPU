module decode_W
(
    input wire[31:0] instr,
    output reg reg_write_en,
    output reg[4:0] rd
);

// R-type values
reg[4:0] opcode; // 2 lsb are always 11 for 32-bit instructions

// always block for picking out pieces of the instruction
always @(*) begin
    opcode = instr[6:2];
    rd     = instr[11:7];
end

/* Write-Back Stage  */

// reg_write_en
always @(*) begin
    case (opcode)
        // S-Type, B-Type
        5'b01000, 5'b11000: reg_write_en = 0;
        default: reg_write_en = 1;
    endcase
end

endmodule

