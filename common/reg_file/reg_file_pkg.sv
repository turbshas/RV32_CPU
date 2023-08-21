import instructions_pkg::arch_reg_id;

package reg_file_pkg;

typedef struct packed {
    arch_reg_id addr_rs1;
    arch_reg_id addr_rs2;
} reg_file_read_params_t;

typedef struct packed {
    arch_reg_id addr_rd;
    logic write_enable;
} reg_file_write_params_t;

endpackage
