#!/bin/bash

assume_picorv32_asserts=false
solver="z3"
n=50

while getopts as:n: opt; do
	case "$opt" in
		a) assume_picorv32_asserts=true;;
		s) solver="$OPTARG";;
		n) n="$OPTARG";;
		*) exit 1
	esac
done

read_verilog_picorv32_opts=""
if $assume_picorv32_asserts; then
	read_verilog_picorv32_opts="-formal -norestrict -assume-asserts"
fi

yosys_script="
	read_verilog -formal memcheck.v
	read_verilog $read_verilog_picorv32_opts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	prep -nordff -top testbench
"

case "$solver" in
	bmc3_aig)
		yosys_script="$yosys_script
			flatten
			setattr -unset keep
			delete -output
			memory_map; opt -full; techmap
			opt -fast; abc -g AND -fast;; stat
			write_aiger memcheck.aig
		"
		solver_cmd="yosys-abc -c 'read_aiger memcheck.aig; fold; logic; undc; strash; zero; bmc3 -F $n -v'"
		;;
	bmc3_blif)
		yosys_script="$yosys_script
			miter -assert -flatten testbench miter
			hierarchy -top miter
			setattr -unset keep
			memory_map; opt -full; techmap
			opt -fast; abc -fast;; stat
			write_blif memcheck.blif
		"
		solver_cmd="yosys-abc -c 'read_blif memcheck.blif; undc; strash; zero; bmc3 -F $n -v'"
		;;
	*)
		yosys_script="$yosys_script
			write_smt2 -wires memcheck.smt2
		"
		solver_cmd="yosys-smtbmc -s $solver -t $n --dump-vcd output.vcd memcheck.smt2"
		;;
esac

set -ex
yosys -p "$yosys_script"
eval "$solver_cmd"
