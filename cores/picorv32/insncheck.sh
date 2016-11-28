#!/bin/bash
set -ex
yosys -p '
	read_verilog -formal insncheck.v
	read_verilog -formal -norestrict -assume-asserts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	read_verilog -formal -D INSN_VH="addi.vh" -D CHANNEL_IDX=0 ../../insns/checker.v
	prep -nordff -top testbench
	write_smt2 -wires insncheck.smt2
'
yosys-smtbmc -s yices -t 25 --dump-vcd output.vcd insncheck.smt2
