import instructions_pkg::instr_packet;
import write_back_pkg::reg_file_write_params_t;
import write_back_pkg::write_back_select_t;

package decode_write_back_pkg

module decode_write_back
(
    input logic reset,
    input instr_packet instr,
    output reg_file_write_params_t reg_file_write_params,
    output write_back_select_t reg_store_sel
);

// reg file write enable
always_comb begin
    if (reset)
        reg_file_write_params.write_enable = 0;
    else begin
        case (instr.opcode)
            // S-Type, B-Type
            // TODO: CSR instructions need write enable on the reg file only if they are reading a CSR
            OPCODE_STORE, OPCODE_BRANCH: reg_file_write_params.write_enable = 0;
            default: reg_file_write_params.write_enable = 1;
        endcase
    end
end

always_comb begin
    reg_file_write_params.addr_rd = instr.params.r_instr.rd;
end

// reg_store_sel, either takes ALU, MEM, or PC+4
always_comb begin
    case (instr.opcode)
        // Loads
        OPCODE_LOAD: reg_store_sel = WRITE_BACK_SEL_MEM; // MEM

        // JAL, JALR
        OPCODE_JAL, OPCODE_JALR: reg_store_sel = WRITE_BACK_SEL_PC; // PC + 4

        // All other ops modify registers in rd
        default: reg_store_sel = WRITE_BACK_SEL_ALU; // ALU
    endcase
end

endmodule

endpackage
