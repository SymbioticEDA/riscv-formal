#!/bin/bash

set -ex

basedir=$PWD/../..
picorv32v=$basedir/../picorv32/picorv32.v

use_verific=false
check_bmc_depth=20
insn_bmc_depth=30

read_verilog_picorv32_opts=""
# read_verilog_picorv32_opts="-formal -norestrict -assume-asserts"

rm -rf work
mkdir -p work
cd work

for check in reg pc imem dmem; do
	{
		cat <<- EOT
			[options]
			mode bmc
			depth $((check_bmc_depth))

			[engines]
			abc bmc3
		EOT

		echo
		if $use_verific; then
			cat <<- EOT
				[script]
				verific -sv top.sv
				verific -import testbench

				[file top.sv]
				\`define RISCV_FORMAL
				\`define RISCV_FORMAL_NRET 1
				\`define RISCV_FORMAL_XLEN 32
				\`include "rvfi_macros.vh"
				\`include "picorv32.v"
				\`include "${check}check.v"
				\`include "rvfi_${check}_check.v"
			EOT
		else
			cat <<- EOT
				[script]
				verilog_defines -D RISCV_FORMAL
				verilog_defines -D RISCV_FORMAL_NRET=1
				verilog_defines -D RISCV_FORMAL_XLEN=32
				read_verilog rvfi_macros.vh

				read_verilog $read_verilog_picorv32_opts picorv32.v
				read_verilog -formal ${check}check.v
				read_verilog -formal rvfi_${check}_check.v
				prep -nordff -top testbench
			EOT
		fi

		echo
		cat <<- EOT
			[files]
			$picorv32v
			$basedir/checks/rvfi_macros.vh
			$basedir/checks/rvfi_${check}_check.v
			$basedir/cores/picorv32/${check}check.v
		EOT
	} > check_${check}.sby

	{
		echo "all:: check_${check}/PASS"
		echo "check_${check}/PASS:"
		echo "	sby check_${check}.sby"
		echo "clean::"
		echo "	rm -rf check_${check}"
	} >> makefile
done

for insn in $basedir/insns/insn_*.v; do
	insn=${insn##*/insn_}
	insn=${insn%.v}
	cat > insn_${insn}.sby <<- EOT
		[options]
		mode bmc
		depth $((insn_bmc_depth + 5))

		[engines]
		abc bmc3

		[script]
		verilog_defines -D RISCV_FORMAL
		verilog_defines -D RISCV_FORMAL_NRET=1
		verilog_defines -D RISCV_FORMAL_XLEN=32
		verilog_defines -D RISCV_FORMAL_BMC_DEPTH=${insn_bmc_depth}
		verilog_defines -D RISCV_FORMAL_INSN=${insn}
		verilog_defines -D RISCV_FORMAL_CHANNEL_IDX=0
		read_verilog rvfi_macros.vh

		read_verilog picorv32.v
		read_verilog insn_${insn}.v
		read_verilog -formal insncheck.v
		read_verilog -formal rvfi_insn_check.v
		prep -nordff -top testbench

		[files]
		$picorv32v
		$basedir/checks/rvfi_macros.vh
		$basedir/checks/rvfi_insn_check.v
		$basedir/insns/insn_${insn}.v
		$basedir/cores/picorv32/insncheck.v
	EOT

	{
		echo "all:: insn_${insn}/PASS"
		echo "insn_${insn}/PASS:"
		echo "	sby insn_${insn}.sby"
		echo "clean::"
		echo "	rm -rf insn_${insn}"
	} >> makefile
done

set +x
echo "ALL TESTS GENERATED. Run \"cd work; make -j$(nproc)\" next."

