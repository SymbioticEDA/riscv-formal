#!/bin/bash
riscv=riscv32
case "$1" in
	-a) mopt="-M numeric"; shift;;
	-n) mopt="-M no-aliases"; shift;;
	-an) mopt=""; shift;;
	-64) riscv=riscv64; shift;;
	*) mopt="-M numeric,no-aliases"
esac
for w; do echo ".word 0x${w#0x}"; done > decode.s
${riscv}-unknown-elf-gcc -c decode.s
${riscv}-unknown-elf-objdump -d $mopt decode.o | grep -A999 ^000
rm -f decode.s decode.o
