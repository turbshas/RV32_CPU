#include <cstdio>
#include <cstdlib>

#include "verilated.h"

#include HEADER_NAME
#include "verilated_vcd_c.h"

#define DONE \
    do {\
        dut->eval();\
        tfp->dump(main_time);\
    } while (0)

#define INCREMENT_CLOCK(incr_val) \
    do {\
        main_time += incr_val;\
        dut->clock = !dut->clock;\
        DONE;\
    } while (0)

#define ECALL_INSTR 0x00000073
#define RET_INSTR 0x00008067
#define OPCODE 0x7f
#define JAL_OPCODE 0x6f
#define JAL_RD 0xf80
#define IS_FN_CALL(instr) \
    (\
     (((instr) & OPCODE) == JAL_OPCODE) \
     && (((instr) & JAL_RD) != 0))
#define IS_FN_RET(instr) ((instr) == RET_INSTR)

using namespace std;

VERILATOR_NAME *dut;

static vluint64_t main_time = 0;

double sc_time_stamp(void) {
    return main_time;
}

static const char fmt[] = "\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x, \n\
0x%08x, 0x%08x, 0x%08x, 0x%08x\n";

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);

    dut = new VERILATOR_NAME;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);

    tfp->open(TRACEFILE);

    dut->clock = 0;
    dut->reset = 1;
    DONE;
    INCREMENT_CLOCK(5);
    INCREMENT_CLOCK(5);
    INCREMENT_CLOCK(5);

    dut->reset = 0;

    printf("Register file before execution:\n");
    printf(fmt,
            dut->registers[0],  dut->registers[1],
            dut->registers[2],  dut->registers[3],
            dut->registers[4],  dut->registers[5],
            dut->registers[6],  dut->registers[7],
            dut->registers[8],  dut->registers[9],
            dut->registers[10], dut->registers[11],
            dut->registers[12], dut->registers[13],
            dut->registers[14], dut->registers[15],
            dut->registers[16], dut->registers[17],
            dut->registers[18], dut->registers[19],
            dut->registers[20], dut->registers[21],
            dut->registers[22], dut->registers[23],
            dut->registers[24], dut->registers[25],
            dut->registers[26], dut->registers[27],
            dut->registers[28], dut->registers[29],
            dut->registers[30], dut->registers[31]);

    unsigned call_stack = 1;
    while ((dut->instr_out != ECALL_INSTR) && (call_stack != 0)) {
        if (IS_FN_CALL(dut->instr_out)) {
            call_stack++;
        } else if (IS_FN_RET(dut->instr_out)) {
            call_stack--;
        }
        INCREMENT_CLOCK(5);
        INCREMENT_CLOCK(5);
    }
    INCREMENT_CLOCK(5);
    INCREMENT_CLOCK(5);

    printf("Register file after execution:\n");
    printf(fmt,
            dut->registers[0],  dut->registers[1],
            dut->registers[2],  dut->registers[3],
            dut->registers[4],  dut->registers[5],
            dut->registers[6],  dut->registers[7],
            dut->registers[8],  dut->registers[9],
            dut->registers[10], dut->registers[11],
            dut->registers[12], dut->registers[13],
            dut->registers[14], dut->registers[15],
            dut->registers[16], dut->registers[17],
            dut->registers[18], dut->registers[19],
            dut->registers[20], dut->registers[21],
            dut->registers[22], dut->registers[23],
            dut->registers[24], dut->registers[25],
            dut->registers[26], dut->registers[27],
            dut->registers[28], dut->registers[29],
            dut->registers[30], dut->registers[31]);

    tfp->close();
    dut->final();
    delete dut;
    return 0;
}

