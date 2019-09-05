#include "pass_fail.h"
int test(void);

int main(void) {
    return test();
}

int pass(void) {
    return 1;
}

int get_value(void) {
    return 3;
}

int test(void) {
    int a = get_value() + get_value();

    if (a == 6) {
        return pass();
    } else {
        return fail();
    }
}

int fail(void) {
    int c = 6;
    c = c + 4;

    return 0;
}

