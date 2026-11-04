import instructions_pkg::arch_reg;
import mem_pkg::mem_params_t;
import mem_pkg::MEM_OP_READ;
import mem_pkg::MEM_ACCESS_WORD;

module stage_F
(
    input logic clock,
    input logic reset,
    input logic pc_input_sel,
    input arch_reg new_PC_in,
    input logic stall_F_D,
    output arch_reg PC_out,
    output arch_reg imem_out,
    output arch_reg instr,

    // Test stuff
    input arch_reg setup_address,
    input arch_reg setup_data_in,
    input logic setup_write
);

mem_params_t imem_params;
assign imem_params.op = MEM_OP_READ;
assign imem_params.access_size = MEM_ACCESS_WORD;
assign imem_params.read_unsigned = 1;

mem imem(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .address(PC_out),
    .data_in(),
    .params(imem_params),
    /* Outputs */
    .data_out(imem_out),
    /* Setup stuff for tests */
    .setup_write(setup_write),
    .setup_address(setup_address),
    .setup_data_in(setup_data_in)
);

fetch fetch_inst(
    /* Inputs */
    .clock(clock),
    .reset(reset),
    .data_in(imem_out),
    .set_PC(pc_input_sel),
    .new_PC(new_PC_in),
    .stall_PC(stall_F_D),
    /* Outputs */
    .PC_out(PC_out),
    .instr(instr)
);

endmodule

