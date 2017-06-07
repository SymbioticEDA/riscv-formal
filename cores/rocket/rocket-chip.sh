#!/bin/sh

set -ex

build_tools=false

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

	if $build_tools; then
		cd riscv-tools
		git submodule update --init --recursive
		# sed -i 's/rv32ima/rv32i/g' build-rv32ima.sh
		./build.sh
		./build-rv32ima.sh
		cd ..
	fi

	cd ..

	( cd ../../monitor && python3 generate.py -p RVFIMonitor; ) > rocket-chip/vsrc/RVFIMonitor.v
	sed -i 's/--top-module/-Wno-fatal &/' rocket-chip/emulator/Makefrag-verilator
fi

make -C rocket-chip/vsim verilog
yosys -v2 -l rocket-chip.yslog rocket-chip.ys

