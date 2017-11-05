#!/bin/bash
set -ex
yosys -p '
	read_verilog picorv32.v
	chparam -set COMPRESSED_ISA 0 -set BARREL_SHIFTER 1 picorv32
	prep -flatten -top picorv32
	design -stash gold

	read_verilog -D RISCV_FORMAL picorv32.v
	chparam -set COMPRESSED_ISA 0 -set BARREL_SHIFTER 1 picorv32
	prep -flatten -top picorv32
	delete -port picorv32/rvfi_*
	design -stash gate

	design -copy-from gold -as gold picorv32
	design -copy-from gate -as gate picorv32
	memory_map; opt -fast
	equiv_make gold gate equiv
	hierarchy -top equiv

	opt -fast
	equiv_simple
	equiv_induct
	equiv_status -assert
'
