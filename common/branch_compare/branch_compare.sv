import instructions_pkg::arch_reg;
import instructions_pkg::pc_input_sel_t;
import instructions_pkg::PC_INPUT_ALU;
import instructions_pkg::PC_INPUT_PC_PLUS_4;
import branch_compare_pkg::BRANCH_COND_EQ;
import branch_compare_pkg::BRANCH_COND_NE;
import branch_compare_pkg::BRANCH_COND_LT;
import branch_compare_pkg::BRANCH_COND_GE;

interface branch_compare_io(input arch_reg rs1, input arch_reg rs2);
    logic unsigned_cmp;
    branch_cond_t branch_cond;

    pc_input_sel_t branch_result;

    modport DECODE (output unsigned_cmp, output branch_cond, input branch_result);
    modport DECODE_BR_CMP (output unsigned_cmp, output branch_cond);
    modport BRANCH_CMP (input rs1, input rs2, input unsigned_cmp, input branch_cond, output branch_result);
endinterface

module branch_compare(branch_compare_io bc_if);

logic unsigned_lt;
logic signed_lt;
logic equal; /* 1 if rs1 == rs2 */
logic less_than; /* 1 if rs1 < rs2 */
logic result_internal;

assign unsigned_lt = bc_if.rs1 < bc_if.rs2;
assign signed_lt = $signed(bc_if.rs1) < $signed(bc_if.rs2);
assign equal = bc_if.rs1 == bc_if.rs2;
assign less_than = bc_if.unsigned_cmp ? unsigned_lt : signed_lt;

always_comb begin
    case (bc_if.branch_cond)
        BRANCH_COND_EQ: result_internal = equal;
        BRANCH_COND_NE: result_internal = !equal;
        BRANCH_COND_LT: result_internal = less_than;
        BRANCH_COND_GE: result_internal = !less_than;
        default: result_internal = 1'b0;
    endcase
end

assign bc_if.branch_result = result_internal ? PC_INPUT_ALU : PC_INPUT_PC_PLUS_4;

endmodule
