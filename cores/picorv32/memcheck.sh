#!/bin/bash
set -ex
yosys -p '
	read_verilog -formal memcheck.v
	read_verilog -formal -norestrict -assume-asserts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	prep -nordff -top testbench
	write_smt2 -wires memcheck.smt2
'
yosys-smtbmc -s yices -t 25 --dump-vcd output.vcd memcheck.smt2
