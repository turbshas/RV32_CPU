`include "csr_inc.v"

module csr (
    input logic clock,
    input logic reset,
    input logic instr_retired,
    input priv_mode_t priv_mode,

    input csr_addr_t csr_addr,

    input logic write_csr,
    input csr_write_func write_function,
    input arch_reg write_value,

    input logic read_csr,
    output arch_reg read_value,

    output logic illegal_instr_exception
);
//TODO: move control logic to decode

// CSR Instructions:
// - uses funct3 for write function
//    - x01 for RW
//    - x10 for RS
//    - x11 for RC
//    - x = 0 for register source (rs1), 1 for immediate source (5 bits)
// - csr address is 12 bits (31:20)
// - same opcode as ECALL/EBREAK
//   - funct3 = 000 for both
//   - rd and rs1 are expected to be 00000, but might just ignore
//   - funct7 = 0000 0000 0000 for ECALL, 0000 0000 0001 for EBREAK

csr_block_t csr_block;

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
        case (csr_addr)
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
        if (csr_addr == `CSR_RDCYCLE || csr_addr == `CSR_RDCYCLEH
         || csr_addr == `CSR_RDTIME || csr_addr == `CSR_RDTIMEH
         || csr_addr == `CSR_RDINSTRET || csr_addr == `CSR_RDINSTRETH) begin
             illegal_instr_exception = 1;
         end else begin
             illegal_instr_exception = 0;
         end
    end
end

endmodule
