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

using namespace std;

VERILATOR_NAME *dut;

static vluint64_t main_time = 0;

double sc_time_stamp(void) {
    return main_time;
}

int main(int argc, char *argv[]) {
    Verilated::commandArgs(argc, argv);

    dut = new VERILATOR_NAME;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);

    tfp->open(TRACEFILE);

    tfp->close();
    dut->final();
    delete dut;
    return 0;
}

