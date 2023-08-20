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

if ask "Would you like to install the riscv toolchain and tests? This will require installing additional packages." "N"; then
    sudo apt install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev

    cd ~
    git clone https://github.com/riscv/riscv-gnu-toolchain.git
    cd riscv-gnu-toolchain
    export RISCV=$HOME/riscv
    ./configure --prefix=$RISCV --with-arch=rv32gc --with-abi=ilp32d
    make

    cd ~
    git clone https://github.com/riscv/riscv-tests.git
    cd riscv-tests
    git submodule update --init --recursive
    autoconf
    ./configure --prefix=$RISCV/tests --with-xlen=32
    RISCV_BIN=$RISCV/bin
    export PATH=$PATH:$RISCV_BIN
    make

    echo "Add the following directory to your path to use the toolchain:"
    echo "$RISCV_BIN"
fi

