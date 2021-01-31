`include "csr_inc.v"

module csr (
    input wire clock,
    input wire reset,
    input wire instr_retired,

    input wire[11:0] csr_num,

    input wire write_csr,
    input wire[2:0] write_function,
    input wire[31:0] write_value,

    input wire read_csr,
    output wire[31:0] read_value,

    output wire illegal_instr_exception
);
//TODO: move control logic to decode

reg[63:0] cycle_counter;
reg[63:0] time_counter;
reg[63:0] retired_instr_counter;

always @(posedge clock) begin
    if (reset) begin
        cycle_counter = 64'h0;
    end else begin
        cycle_counter = cycle_counter + 1;
    end
end

always @(posedge clock) begin
    if (reset) begin
        time_counter = 64'h0;
    end else begin
        /* For now, time = clock cycle. TODO: have an actual timer */
        time_counter = time_counter + 1;
    end
end

always @(posedge close) begin
    if (reset) begin
        retired_instr_counter = 64'h0;
    end else begin
        if (instr_retired) begin
            retired_instr_counter = retired_instr_counter + 1;
        end
    end
end

always @(*) begin
    if (read_csr) begin
        illegal_instr_exception = 0;
        case (csr_num)
            `CSR_RDCYCLE:    read_value = cycle_counter[31:0];
            `CSR_RDCYCLEH:   read_value = cycle_counter[63:32];
            `CSR_RDTIME:     read_value = time_counter[31:0];
            `CSR_RDTIMEH:    read_value = time_counter[63:32];
            `CSR_RDINSTRET:  read_value = retired_instr_counter[31:0];
            `CSR_RDINSTRETH: read_value = retired_instr_counter[63:32];
            `default: illegal_instr_exception = 1;
        endcase
    end else begin
        read_value = 32'h0;
        illegal_instr_exception = 0;
    end
end

always @(*) begin
    if (write_csr) begin
        if (csr_num == `CSR_RDCYCLE || csr_num == `CSR_RDCYCLEH
         || csr_num == `CSR_RDTIME || csr_num == `CSR_RDTIMEH
         || csr_num == `CSR_RDINSTRET || csr_num == `CSR_RDINSTRETH) begin
             illegal_instr_exception = 1;
         end else begin
             illegal_instr_exception = 0;
         end
    end
end
