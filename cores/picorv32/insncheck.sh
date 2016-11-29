#!/bin/bash

solver="bmc3"
insn="addi"

while getopts s:i: opt; do
	case "$opt" in
		s) solver="$OPTARG";;
		i) insn="$OPTARG";;
		*) exit 1
	esac
done

yosys_script="
	read_verilog -formal insncheck.v
	read_verilog -formal -norestrict -assume-asserts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	read_verilog -formal -D INSN_VH=\"${insn}.vh\" -D CHANNEL_IDX=0 ../../insns/checker.v
	prep -nordff -top testbench
"

case "$solver" in
	bmc3)
		yosys_script="$yosys_script
			miter -assert -flatten testbench miter
			hierarchy -top miter
			setattr -unset keep
			memory_map; opt -full; techmap
			opt -fast; abc -fast;; stat
			write_blif insncheck_${insn}.blif
		"
		solver_cmd="yosys-abc -c 'read_blif insncheck_${insn}.blif; undc; strash; zero; bmc3 -F 25 -v'"
		;;
	*)
		yosys_script="$yosys_script
			write_smt2 -wires insncheck_${insn}.smt2
		"
		solver_cmd="yosys-smtbmc -s $solver -t 25 --dump-vcd output.vcd insncheck_${insn}.smt2"
		;;
esac

set -ex
yosys -p "$yosys_script"
eval "$solver_cmd"
