import instructions_pkg::arch_reg;

package fetch_pkg

module fetch
(
    input logic clock,
    input logic reset,
    input arch_reg data_in,

    input logic set_PC,
    input arch_reg new_PC,
    input logic stall_PC,
    output arch_reg PC_out,
    output arch_reg instr
);

arch_reg PC;

always_comb begin
    PC_out = PC;
    instr = data_in;
end

always_ff @(posedge clock) begin
    if (reset) begin
        PC <= 32'h01000000;
    end else begin
        // Set PC always takes priority over stalling, to prevent
        // an issue where a stall happens during a branch, causing
        // the branch to be ignored.
        if (set_PC) begin
            PC <= new_PC;
        end else begin
            if (! stall_PC) begin
                PC <= PC + 4;
            end
        end
    end
end

endmodule

endpackage
