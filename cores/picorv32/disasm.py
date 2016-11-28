#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system

rvfi_valid = None
rvfi_insn = None

for netinfo in parse_vcd('output.vcd').values():
    for net in netinfo['nets']:
        if net["hier"] == "testbench" and net["name"] == "rvfi_valid":
            rvfi_valid = netinfo['tv']
        if net["hier"] == "testbench" and net["name"] == "rvfi_insn":
            rvfi_insn = netinfo['tv']

assert len(rvfi_valid) == len(rvfi_insn)

with open("disasm.s", "w") as f:
    for tv_valid, tv_insn in zip(rvfi_valid, rvfi_insn):
        assert tv_valid[0] == tv_insn[0]
        if tv_valid[1] == '1':
            print(".word 0x%08x" % int(tv_insn[1], 2), file=f)

system("riscv32-unknown-elf-gcc -c disasm.s")
system("riscv32-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")

