`include "constants.sv"
`include "instructions.sv"

`include "write_back_inc.sv"

module decode_write_back
(
    input logic reset,
    input opcode_t opcode,
    output logic reg_write_en,
    output write_back_select_t reg_store_sel
);

// reg_write_en
always_comb begin
    if (reset)
        reg_write_en = 0;
    else begin
        case (opcode)
            // S-Type, B-Type
            OPCODE_STORE, OPCODE_BRANCH: reg_write_en = 0;
            default: reg_write_en = 1;
        endcase
    end
end

// reg_store_sel, either takes ALU, MEM, or PC+4
always_comb begin
    case (opcode)
        // Loads
        OPCODE_LOAD: reg_store_sel = WRITE_BACK_SEL_MEM; // MEM

        // JAL, JALR
        OPCODE_JAL, OPCODE_JALR: reg_store_sel = WRITE_BACK_SEL_PC; // PC + 4

        // All other ops modify registers in rd
        default: reg_store_sel = WRITE_BACK_SEL_ALU; // ALU
    endcase
end

endmodule
