#!/bin/bash

set -eo pipefail

sudo apt install iverilog verilator yosys gtkwave npm
sudo npm install -g netlistsvg

# Copied from setup scripts
ask() {
    # https://gist.github.com/davejamesmiller/1965569
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do
        echo -n "$1 [$prompt] "
        read reply </dev/tty
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

if ask "Would you like to install the riscv toolchain and tests?" "N"; then
    cd ~
    git clone https://github.com/riscv/riscv-gnu-toolchain.git
    cd riscv-gnu-toolchain
    ./configure --prefix=~/riscv --with-arch=rv32gc --with-abi=ilp32d
    make -j

    cd ~
    git clone https://github.com/riscv/riscv-tests.git
    cd riscv-tests
    export RISCV=~/riscv
    ./configure --prefix=$RISCV/target --with-xlen=32
    make -j

    echo "Add the following directory to your path to use the toolchain:"
    echo "~/riscv/bin"
fi

