import instructions_pkg::arch_reg;

package csr_pkg;

typedef enum logic[1:0] {
    CSR_ADDR_RW1 = 2'b00,
    CSR_ADDR_RW2 = 2'b01,
    CSR_ADDR_RW3 = 2'b10,
    CSR_ADDR_RO  = 2'b11
} csr_addr_access;

typedef enum logic[1:0] {
    CSR_PRIV_USER = 2'b00,
    CSR_PRIV_SUPERVISOR = 2'b01,
    /** Also permitted in Virtual Supervisor mode. */
    CSR_PRIV_HYPERVISOR = 2'b10,
    /** A handful are also debug-only. */
    CSR_PRIV_MACHINE = 2'b11
} csr_addr_priv;

typedef struct packed {
    csr_addr_access access;
    csr_addr_priv priv;
    logic[7:0] addr;
} csr_addr_t;

/**
 * Using x0 for RD with CSRRW causes no read to occur (and thus no side effects).
 * Using x0 for RS1 or immediate value of 0 with CSRRS or CSRRC
 * causes no write to occur (and thus no side effects).
 *
 * CSRRW always writes, CSRRS and CSRRC always read (and cause side effects).
 */
typedef enum logic[1:0] {
    CSR_WRITE_NONE = 2'b00,
    /** Read CSR -> store in RD, write RS1 to CSR. */
    CSR_WRITE_RW = 2'b01,
    /** Read CSR -> store in RD, write (CSR | RS1) to CSR (sets bits). */
    CSR_WRITE_RS = 2'b10,
    /** Read CSR -> store in RD, write (CSR & ~RS1) to CSR (clears bits). */
    CSR_WRITE_RC = 2'b11
} csr_write_func;

typedef enum logic {
    CSR_SEL_RS1 = 1'b0,
    CSR_SEL_IMM = 1'b1
} csr_input_sel;

typedef struct packed {
    csr_input_sel input_select;
    csr_write_func write_func;
} csr_funct3_t;

typedef struct packed {
    logic read_enable;
    logic write_enable;
    csr_input_sel input_select;
    csr_write_func write_func;
} csr_params_t;

typedef struct packed {
    /** 0xF15 -> 0xFFF. */
    arch_reg[234:0] rsvd16; // 0xEB

    /** 0xF14 | MRO | Hardware Thread ID. */
    arch_reg mhartid;
    /** 0xF13 | MRO | Implementation ID. */
    arch_reg mimpid;
    /** 0xF12 | MRO | Architecture ID. */
    arch_reg marchid;
    /** 0xF11 | MRO | Vendor ID. */
    arch_reg vendorid;

    /** 0xCA0 -> 0xF10. */
    arch_reg[624:0] rsvd15; // 0x271

    /** 0xC83 -> 0xC9F | URO | High Performance Counters 3 -> 31, upper 32 bits. RV32I only */
    arch_reg hpmcounterh;
    /** 0xC82 | URO | Upper 32 bits of instret. RV32I only. */
    arch_reg instreth;
    /** 0xC81 | URO | Upper 32 bits of time. RV32I only. */
    arch_reg timeh;
    /** 0xC80 | URO | Upper 32 bits of cycle. RV32I only. */
    arch_reg cycleh;

    /** 0xC20 -> 0xC7F. */
    arch_reg[95:0] rsvd14; // 0x60

    /** 0xC03 -> 0xC1F | URO | High Performance Counters 3 -> 31. */
    arch_reg[31:3] hpmcounter;
    /** 0xC02 | URO | Instructions-retired counter for RDINSTRET instruction. */
    arch_reg instret;
    /** 0xC01 | URO | Timer for RDTIME instruction. */
    arch_reg timer;
    /** 0xC00 | URO | Cycle counter for RDCYCLE instruction. */
    arch_reg cycle;

    /** 0xBA0 -> 0xBFF. */
    arch_reg[95:0] rsvd13; // 0x60

    /** 0xB83 -> 0xB9F | MRW | Upper 32 bits of mhpmcounter registers (3 -> 31), RV32I only. */
    arch_reg[31:3] mhpmcounterh;
    /** 0xB82 | MRW | Upper 32 bits of minstret, RV32I only. */
    arch_reg minstreth;

    /** 0xB81. */
    arch_reg rsvd12;

    /** 0xB80 | MRW | Upper 32 bits of mcycle, RV32I only. */
    arch_reg mcycleh;

    /** 0xB04 -> 0xB7F. */
    arch_reg[123:0] rsvd11; // 0x7C

    /** 0xB03 -> 0xB1F | MRW | Machine performance-monitoring counters (3 -> 31). */
    arch_reg[31:3] mhpmcounter;
    /** 0xB02 | MRW | Machine instructions-retired counter. */
    arch_reg minstret;

    /** 0xB01. */
    arch_reg rsvd9;

    /** 0xB00 | MRW | Machine cycle counter. */
    arch_reg mcycle;

    /** 0x7B4 -> 0xAFF. */
    arch_reg[843:0] rsvd10; // 0x34C

    /** 0x7B2 -> 0x7B3 | DRW | Debug scratch registers (0 -> 1). */
    arch_reg[1:0] dscratch;
    /** 0x7B1 | DRW | Debug PC. */
    arch_reg dpc;
    /** 0x7B0 | DRW | Debug control and status register. */
    arch_reg dcsr;

    /** 0x7A4 -> 0x7AF. */
    arch_reg[11:0] rsvd9; // 0x00C

    /** 0x7A1 -> 0x7A3 | MRW | Debug/Trace trigger data registers (1 -> 3). */
    arch_reg[2:0] tdata;
    /** 0x7A0 | MRW | Debug/Trace trigger register select. */
    arch_reg tselect;

    /** 0x3B1 -> 0x79F. */
    arch_reg[1006:0] rsvd8; // 0x3EF

    /** 0x3B0 -> 0x3BF | MRW | Physical memory protection address registers 0 -> 15. */
    arch_reg[15:0] pmpaddr;

    /** 0x3A1 -> 0x3AF. */
    arch_reg[14:0] rsvd7; // 0x00F

    /** 0x3A0 | MRW | Physical memory protection configuration. RV32 only. */
    arch_reg pmpcfg3;
    /** 0x3A0 | MRW | Physical memory protection configuration. */
    arch_reg pmpcfg2;
    /** 0x3A0 | MRW | Physical memory protection configuration. RV32 only. */
    arch_reg pmpcfg1;
    /** 0x3A0 | MRW | Physical memory protection configuration. */
    arch_reg pmpcfg0;

    /** 0x345 -> 0x39F. */
    arch_reg[88:0] rsvd6; // 0x059

    /** 0x344 | MRW | Machine interrupt pending. */
    arch_reg mip;
    /** 0x343 | MRW | Machine bad address or instruction. */
    arch_reg mtval;
    /** 0x342 | MRW | Machine trap cause. */
    arch_reg mcause;
    /** 0x341 | MRW | Machine exception program counter. */
    arch_reg mepc;
    /** 0x340 | MRW | Scratch register for machine trap handlers. */
    arch_reg mscratch;

    /** 0x323 -> 0x33F | MRW | Machine performance-monitoring event selector. */
    arch_reg[31:3] mhpevent;

    /** 0x320 | MRW | Machine counter-inhibit register. */
    arch_reg mcountinhibit;

    /** 0x307 -> 0x33F. */
    arch_reg[56:0] rsvd5; // 0x039

    /** 0x306 | MRW | Machine counter enable. */
    arch_reg mcounteren;
    /** 0x305 | MRW | Machine trap-handler base address. */
    arch_reg mtvec;
    /** 0x304 | MRW | Machine interrupt-enable register. */
    arch_reg mie;
    /** 0x303 | MRW | Machine interrupt delegation register. */
    arch_reg mideleg;
    /** 0x302 | MRW | Machine exception delegation register. */
    arch_reg medeleg;
    /** 0x301 | MRW | ISA and extensions. */
    arch_reg misa;
    /** 0x300 | MRW | Machine status register. */
    arch_reg mstatus;

    /** 0x181 -> 0x2FF. */
    arch_reg[382:0] rsvd4; // 0x17F

    /** 0x180 | SRW | Supervisor address translation and protection. */
    arch_reg satp;
    /** 0x144 | SRW | Supervisor interrupt pending. */
    arch_reg sip;
    /** 0x143 | SRW | Supervisor bad address or instruction. */
    arch_reg stval;
    /** 0x142 | SRW | Supervisor trap cause. */
    arch_reg scause;
    /** 0x141 | SRW | Supervisor exception program counter. */
    arch_reg sepc;
    /** 0x140 | SRW | Scratch register for supervisor trap handlers. */
    arch_reg sscratch;
    /** 0x106 | SRW | Supervisor counter enable. */
    arch_reg scounteren;
    /** 0x105 | SRW | Supervisor trap handler base address. */
    arch_reg stvec;
    /** 0x104 | SRW | Supervisor interrupt-enable register. */
    arch_reg sie;
    /** 0x103 | SRW | Supervisor interrupt delegation register. */
    arch_reg sideleg;
    /** 0x102 | SRW | Supervisor exception delegation register. */
    arch_reg sedeleg;

    /** 0x101. */
    arch_reg rsvd3;

    /** 0x100 | SRW | Supervisor status register. */
    arch_reg sstatus;

    /** 0x045 -> 0x0FF. */
    arch_reg[186:0] rsvd2; // 0x0BB

    /** 0x044 | URW | User Interrupt Pending. */
    arch_reg uip;
    /** 0x043 | URW | User bad address or instruction. */
    arch_reg utval;
    /** 0x042 | URW | User trap cause. */
    arch_reg ucause;
    /** 0x041 | URW | User exception program counter. */
    arch_reg uepc;
    /** 0x040 | URW | Scratch register for user trap handlers. */
    arch_reg uscratch;
    /** 0x006 -> 0x3F. */
    arch_reg[52:0] rsvd1; // 0x35
    /** 0x005 | URW | User trap handler base address. */
    arch_reg utvec;
    /** 0x004 | URW | User interrupt-enable register. */
    arch_reg uie;
    /** 0x003 | URW | Floating-point Control and Status Register (frm + fflags). */
    arch_reg fcsr;
    /** 0x002 | URW | Floating-point Dynamic Rounding Mode. */
    arch_reg frm;
    /** 0x001 | URW | Floating-point Accrued Exceptions. */
    arch_reg fflags;
    /** 0x000 | URW | User status register. */
    arch_reg ustatus;
} csr_block_t;

endpackage
