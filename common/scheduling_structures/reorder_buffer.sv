module reorder_buffer
parameter ROB_ADDR_WIDTH = 5;
          REG_FILE_ADDR_WIDTH = 7;

    typedef struct {
        reg[31:0] instr;
        reg valid;
        reg completed;
        reg[REG_FILE_ADDR_WIDTH - 1:0] dest_reg;
        reg[REG_FILE_ADDR_WIDTH - 1:0] old_dest_reg;
    } rob_entry;
(
    // ROB read signals
    output rob_entry rob_entry_out,

    // ROB write signals
    input wire write_en,
    input rob_entry rob_entry_in,

    // Control signals
    input wire clock,
    input wire reset,

    input wire complete_instr,
    input wire[ROB_ADDR_WIDTH - 1:0] completed_addr,
    output wire retiring_instr, // This is output to increment the # of instructions retired status register
    output wire empty,
    output wire full,

    input wire interrupt_triggered,
    output wire rolling_back,
    output wire[31:0] rolling_back_instr,
    output wire[REG_FILE_ADDR_WIDTH - 1:0] phys_reg_mapping
);
// TODO: interrupt/branch misprediction handling

rob_entry rob_entries[2**ROB_ADDR_WIDTH];
reg[ROB_ADDR_WIDTH - 1:0] head;
reg[ROB_ADDR_WIDTH - 1:0] tail;
rob_entry head_entry;
rob_entry tail_entry;
rob_entry last_valid_entry;
wire can_retire_head;
reg rolling_back_for_interrupt;

always @(*) begin
    head_entry = rob_entries[head];
    tail_entry = rob_entries[tail];
    last_valid_entry = rob_entries[tail - 1];

    // Reading logic
    rob_entry_out.instr = head_entry.instr;
    rob_entry_out.valid = head_entry.valid;
    rob_entry_out.completed = head_entry.completed;
    rob_entry_out.dest_reg = head_entry.dest_reg;
    rob_entry_out.old_dest_reg = head_entry.old_dest_reg;

    // Status signals
    empty = head == tail && !head_entry.valid;
    full = head == tail && head_entry.valid;
    can_retire_head = head_entry.valid && head_entry.completed;
    retiring_instr = can_retire_head;
    rolling_back = interrupt_triggered || rolling_back_for_interrupt;
    rolling_back_instr = last_valid_entry.instr;
    phys_reg_mapping = last_valid_entry.old_dest_reg;
end

always @(posedge clock) begin
    if (reset) begin
        head <= ROB_ADDR_WIDTH'b0;
        tail <= ROB_ADDR_WIDTH'b0;

        for (i = 0; i < 2**ROB_ADDR_WIDTH; i = i + 1) begin
            rob_entries[i].valid <= 0;
            rob_entries[i].completed <= 0;
        end
    end else if (interrupt_triggered || rolling_back_for_interrupt) begin
        if (head == tail)  begin
            rolling_back_for_interrupt <= 0;
        end else begin
            rolling_back_for_interrupt <= 1;
            last_valid_entry.valid <= 0;
            last_valid_entry.completed <= 0;
            tail <= tail - 1;
        end
    end else begin
        // Instruction retiring
        if (can_retire_head) begin
            head <= head + 1;
        end

        // Writing logic
        if (!tail_entry.valid && write_en) begin
            tail_entry.instr <= rob_entry_in.instr;
            tail_entry.dest_reg <= rob_entry_in.dest_reg;
            tail_entry.old_dest_reg <= rob_entry_in.old_dest_reg;

            tail_entry.valid <= 1;
            tail_entry.completed <= 0;
            tail <= tail + 1;
        end

        // Instruction completion - allows retiring the instruction that completed
        if (complete_instr) begin
            rob_entries[completed_addr].completed <= 1;
        end
    end
end
