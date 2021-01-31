module reorder_buffer
parameter ROB_ADDR_WIDTH = 3;
          REG_FILE_ADDR_WIDTH = 7;
(
    // ROB status signals
    input wire complete_instr,
    input wire[ROB_ADDR_WIDTH - 1:0] completed_addr,

    // ROB read signals
    output wire retiring_instr,
    output wire[31:0] instr_out,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] dest_reg_out,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] old_reg_out,

    // ROB write signals
    input wire write_en,
    input wire[ROB_ADDR_WIDTH - 1:0] write_addr,
    input wire[31:0] instr_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] dest_reg_in,
    input wire[REG_FILE_ADDR_WIDTH - 1:0] old_reg_in,

    // Control signals
    input wire clock,
    input wire reset,
    output wire empty,
    output wire full
);
// TODO: interrupt handling

reg[31:0] instrs[2**ROB_ADDR_WIDTH];
reg valid[2**ROB_ADDR_WIDTH];
reg completed[2**ROB_ADDR_WIDTH];
reg[REG_FILE_ADDR_WIDTH - 1:0] dest_reg[2**ROB_ADDR_WIDTH];
reg[REG_FILE_ADDR_WIDTH - 1:0] old_dest_reg[2**ROB_ADDR_WIDTH];

reg[ROB_ADDR_WIDTH - 1:0] head;
reg[ROB_ADDR_WIDTH - 1:0] tail;

assign empty = head == tail && !valid[head];
assign full = head == tail && valid[head];

// Assign outputs as constant, only update head when retiring an instruction
assign instr_out = instrs[head];
assign dest_reg_out = dest_reg[head];
assign old_reg_in = old_dest_reg[head];

wire can_retire_head;
assign can_retire_head = valid[head] && completed[head];
assign retiring_instr = can_retire_head;

// Read block, head points to first used block
always @(posedge clock) begin
    if (reset) begin
        head = ROB_ADDR_WIDTH'b0;
    end else begin
        if (can_retire_head) begin
            head = head + 1;
        end
    end
end

// Write block, tail points to next free block
integer i;
always @(posedge clock) begin
    if (reset) begin
        tail = ROB_ADDR_WIDTH'b0;

        for (i = 0; i < 2**ROB_ADDR_WIDTH; i = i + 1) begin
            valid[i] = 0;
            completed[i] = 0;
        end
    end else begin
        if (!valid[tail] && write_en) begin
            instrs[tail] = instr_in;
            dest_reg[tail] = dest_reg_in;
            old_dest_reg[tail] = old_reg_in;

            valid[tail] = 1;
            completed[tail] = 0;
            tail = tail + 1;
        end
    end
end

// Block for completing instructions
always @(posedge clock) begin
    if (!reset) begin
        if (complete_instr) begin
            completed[completed_addr] = 1;
        end
    end
end
