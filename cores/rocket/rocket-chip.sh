#!/bin/sh

set -ex
export CONFIG=DefaultConfigWithRVFIMonitors
export MAKEFLAGS="-j$(nproc)"

rm -rf rocket-chip
git clone https://github.com/freechipsproject/rocket-chip
cd rocket-chip

git checkout RVFI
git submodule update --init

mkdir toolchain
export RISCV=$PWD/toolchain

# cd riscv-tools
# git submodule update --init --recursive
# MAKEFLAGS="-j$(nproc)" ./build-rv32ima.sh
# cd ..

cd vsim
make verilog

cd ../..
yosys rocket-chip.ys

