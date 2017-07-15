#!/bin/sh

set -ex

export CONFIG=DefaultConfigWithRVFIMonitors
export MAKEFLAGS="-j$(nproc)"
export RISCV=$PWD/riscv-tools

if [ ! -d rocket-chip ]; then
	rm -rf rocket-chip
	git clone https://github.com/freechipsproject/rocket-chip
	cd rocket-chip

	git checkout RVFI
	git submodule update --init

	( cd ../../../monitor && python3 generate.py -p RVFIMonitor -c 2 -MC; ) > vsrc/RVFIMonitor.v
	sed -i '/^module/ s/\([A-Z]\+=\)/parameter &/g' vsrc/plusarg_reader.v
	sed -i 's/--top-module/-Wno-fatal &/' emulator/Makefrag-verilator

	cd ..
fi

if [ ! -d riscv-tools ]; then
	mkdir riscv-tools
	cd rocket-chip/riscv-tools
	git submodule update --init --recursive
	# sed -i 's/rv32ima/rv32i/g' build-rv32ima.sh
	./build.sh
	./build-rv32ima.sh
	cd ../..
fi

make -C rocket-chip/vsim verilog
yosys -v2 -l rocket-chip.yslog rocket-chip.ys

