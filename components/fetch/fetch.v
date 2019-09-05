module fetch
(
    input wire clock,
    input wire reset,
    input wire[31:0] data_in,
    input wire set_PC,
    input wire[31:0] new_PC,
    input wire stall_PC,
    output wire[31:0] PC_out,
    output reg[31:0] instr
);

reg[31:0] PC;

assign PC_out = PC;

always @(posedge clock) begin
    if (reset) begin
        PC <= 32'h01000000;
    end else begin
        if (set_PC) begin
            PC <= new_PC;
        end else begin
            if (! stall_PC) begin
                PC <= PC + 4;
            end
        end
    end
end

always @(*) begin
    instr = data_in;
end

endmodule

