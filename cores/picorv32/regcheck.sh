#!/bin/bash
set -ex
yosys -p '
	read_verilog -formal regcheck.v
	read_verilog -formal -norestrict -assume-asserts -D RISCV_FORMAL ../../../picorv32/picorv32.v
	prep -nordff -top testbench
	write_smt2 -wires regcheck.smt2
'
yosys-smtbmc -s yices -t 25 --dump-vcd output.vcd regcheck.smt2
