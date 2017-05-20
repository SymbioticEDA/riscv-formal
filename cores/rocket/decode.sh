#!/bin/bash
for w; do echo ".word 0x${w#0x}"; done > decode.s
riscv32-unknown-elf-gcc -c decode.s
riscv32-unknown-elf-objdump -d -M numeric,no-aliases decode.o | grep -A999 ^000
rm -f decode.s decode.o
