#!/bin/sh

set -ex

export CONFIG=DefaultConfigWithRVFIMonitors
export MAKEFLAGS="-j$(nproc)"
export RISCV=$PWD/rocket-chip/toolchain

if [ ! -d rocket-chip ]; then
	rm -rf rocket-chip
	git clone https://github.com/freechipsproject/rocket-chip
	cd rocket-chip

	git checkout RVFI
	git submodule update --init

	mkdir toolchain

	# cd riscv-tools
	# git submodule update --init --recursive
	# ./build-rv32ima.sh
	# cd ..

	cd ..
fi

make -C rocket-chip/vsim verilog
yosys -v2 -l rocket-chip.yslog rocket-chip.ys

