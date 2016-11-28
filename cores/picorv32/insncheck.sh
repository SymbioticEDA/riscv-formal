#!/bin/bash
set -ex
yosys -p '
	read_verilog -formal insncheck.v
	read_verilog -formal -norestrict -assume-asserts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	read_verilog -formal -D INSN_VH="addi.vh" -D CHANNEL_IDX=0 ../../insns/checker.v
	prep -nordff -top testbench
	write_smt2 -wires insncheck.smt2
	# miter -assert -flatten testbench miter
	# hierarchy -top miter
	# setattr -unset keep
	# memory_map; opt -full; techmap
	# opt -fast; abc -fast;; stat
	# write_blif insncheck.blif
'
# yosys-abc -c 'read_blif insncheck.blif; undc; strash; zero; bmc3 -F 25 -v'
yosys-smtbmc -s yices -t 25 --dump-vcd output.vcd insncheck.smt2
