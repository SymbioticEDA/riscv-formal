#!/bin/bash

set -ex

basedir=$PWD/../..
picorv32v=$basedir/../picorv32/picorv32.v
sbycmd="sby"

use_verific=false
check_bmc_depth=20
insn_bmc_depth=30
aigsmt=z3

rm -rf work
mkdir -p work
cd work

for check in reg pc imem dmem; do
	{
		cat <<- EOT
			[options]
			mode bmc
			aigsmt $aigsmt
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
				prep -nordff -top testbench

			EOT
		else
			cat <<- EOT
				[script]
				read_verilog -sv top.sv
				prep -nordff -top testbench
			EOT
		fi

		echo
		cat <<- EOT
			[file top.sv]
			\`define DEBUGNETS
			\`define RISCV_FORMAL
			\`define RISCV_FORMAL_NRET 1
			\`define RISCV_FORMAL_XLEN 32
			\`define RISCV_FORMAL_COMPRESSED
			\`include "rvfi_macros.vh"
			\`include "picorv32.v"
			\`include "${check}check.sv"
			\`include "rvfi_${check}_check.sv"

			[files]
			$picorv32v
			$basedir/checks/rvfi_macros.vh
			$basedir/checks/rvfi_${check}_check.sv
			$basedir/cores/picorv32/${check}check.sv
		EOT
	} > check_${check}.sby

	{
		echo "all:: check_${check}/PASS"
		echo "check_${check}/PASS:"
		echo "	${sbycmd} check_${check}.sby"
		echo "clean::"
		echo "	rm -rf check_${check}"
	} > check_${check}.mk
done

for insn in $basedir/insns/insn_*.v; do
	insn=${insn##*/insn_}
	insn=${insn%.v}
	{
		cat <<- EOT
			[options]
			mode bmc
			aigsmt $aigsmt
			depth $((insn_bmc_depth + 5))

			[engines]
			abc bmc3
		EOT

		echo
		if $use_verific; then
			cat <<- EOT
				[script]
				verific -sv top.sv
				verific -import testbench
				prep -nordff -top testbench
			EOT
		else
			cat <<- EOT
				[script]
				read_verilog -sv top.sv
				prep -nordff -top testbench
			EOT
		fi

		echo
		cat <<- EOT
			[file top.sv]
			\`define DEBUGNETS
			\`define RISCV_FORMAL
			\`define RISCV_FORMAL_NRET 1
			\`define RISCV_FORMAL_XLEN 32
			\`define RISCV_FORMAL_COMPRESSED
			\`define RISCV_FORMAL_BMC_DEPTH ${insn_bmc_depth}
			\`define RISCV_FORMAL_INSN_MODEL rvfi_insn_${insn}
			\`define RISCV_FORMAL_CHANNEL_IDX 0
			\`include "rvfi_macros.vh"
			\`include "picorv32.v"
			\`include "insncheck.sv"
			\`include "rvfi_insn_check.sv"
			\`include "insn_${insn}.v"

			[files]
			$picorv32v
			$basedir/checks/rvfi_macros.vh
			$basedir/checks/rvfi_insn_check.sv
			$basedir/cores/picorv32/insncheck.sv
			$basedir/insns/insn_${insn}.v
		EOT
	} > insn_${insn}.sby

	{
		echo "all:: insn_${insn}/PASS"
		echo "insn_${insn}/PASS:"
		echo "	${sbycmd} insn_${insn}.sby"
		echo "clean::"
		echo "	rm -rf insn_${insn}"
	} > insn_${insn}.mk
done

# launch longest running jobs first. obtain cached list of longest running jobs using this command:
# grep 'summary: Elapsed process time' work/*/logfile.txt | sed -r 's,^(.*/)?([^/]*)/.*\((.*)\),\3 \2,;' | sort -rn
while read _ job; do
	cat $job.mk >> makefile
	rm -f $job.mk
done <<- EOT
	1351 check_reg
	1286 insn_bgeu
	1170 insn_bge
	1034 insn_blt
	1033 insn_beq
	937 insn_bne
	751 insn_lhu
	733 insn_lw
	711 insn_bltu
	702 insn_lbu
	611 insn_lh
	594 insn_sh
	568 insn_lb
	489 insn_sb
	263 insn_sw
	242 insn_auipc
	202 insn_jal
EOT

cat *.mk >> makefile
rm -f *.mk

set +x
echo "ALL TESTS GENERATED. Run \"cd work; make -j$(nproc)\" next."

