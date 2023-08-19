module reg_free_list
parameter REG_FILE_ADDR_WIDTH = 7;
(
    input wire clock,
    input wire reset,

    input wire take_next_free,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] free_reg_num,

    input wire reg_freed,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] freed_reg_num,

    output wire empty,
    output wire full
);

// Always need at least 32 regs mapped for the architectural regs
reg[REG_FILE_ADDR_WIDTH - 1:0] free_regs[2**REG_FILE_ADDR_WIDTH];
reg[REG_FILE_ADDR_WIDTH - 1:0] head;
reg[REG_FILE_ADDR_WIDTH - 1:0] tail;

// TODO: should these be clocked?
assign free_reg_num = free_regs[0];
assign empty = head == (tail + 1);
assign full = (head + 2**REG_ADDR_WIDTH - 32) == tail;

integer i;
always @(posedge clock) begin
    if (reset) begin
        head <= 0;
        tail <= 2**REG_FILE_ADDR_WIDTH - 32 - 1;
        for (i = 0; i < 2**REG_FILE_ADDR_WIDTH - 32; i = i + 1) begin
            free_regs[i] <= i + 32;
        end
        for (i = 2**REG_FILE_ADDR_WIDTH - 32; i < 2**REG_FILE_ADDR_WIDTH; i = i + 1) begin
            free_regs[i] <= 0;
        end
    end else begin
        if (take_next_free && !empty) begin
            head <= head + 1;
        end
        if (reg_free && !full) begin
            free_regs[tail + 1] <= freed_reg_num;
            tail <= tail + 1;
        end
    end
end

endmodule
