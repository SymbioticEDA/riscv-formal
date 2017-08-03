#!/bin/bash
case "$1" in
	-a) mopt="-M numeric"; shift;;
	-n) mopt="-M no-aliases"; shift;;
	-an) mopt=""; shift;;
	*) mopt="-M numeric,no-aliases"
esac
for w; do echo ".word 0x${w#0x}"; done > decode.s
riscv32-unknown-elf-gcc -c decode.s
riscv32-unknown-elf-objdump -d $mopt decode.o | grep -A999 ^000
rm -f decode.s decode.o
