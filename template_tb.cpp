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

static size_t
read_in_file(const char *file_name, uint32_t *dest, const size_t dest_len)
{
    FILE *file = fopen(file_name, "r");

    char line[16];
    size_t i = 0;
    while ((i < dest_len) && fgets(line, sizeof(line), file)) {
        const uint32_t value = strtol(line, NULL, 16);
        dest[i] = value;
        i++;
    }

    fclose(file);

    return i;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        /* Requires test name and tracefile name passed in */
        printf("Usage: <executable> <test file> <output trace file>\n");
        exit(-1);
    }

    const char *test_file_name = argv[1];
    const char *trace_file_name = argv[2];

    const size_t file_contents_len = 1024;
    uint32_t file_contents[file_contents_len];
    const size_t lines_read = read_in_file(test_file_name, file_contents, file_contents_len);

    Verilated::commandArgs(argc, argv);

    dut = new VERILATOR_NAME;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);

    tfp->open(trace_file_name);

    dut->clock = 0;
    dut->reset = 1;
    DONE;
    INCREMENT_CLOCK(5);
    INCREMENT_CLOCK(5);
    INCREMENT_CLOCK(5);

    dut->setup_write = 1;
    const uint32_t starting_address = 0x01000000;
    for (size_t i = 0; i < lines_read; i++) {
        dut->setup_address = starting_address + (i * 4);
        dut->setup_data_in = file_contents[i];

        INCREMENT_CLOCK(5);
        INCREMENT_CLOCK(5);
    }

    dut->reset = 0;

    tfp->close();
    dut->final();
    delete dut;
    return 0;
}

