#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system
from sys import argv

rvfi_valid = None
rvfi_order = None
rvfi_insn = None

for netinfo in parse_vcd(argv[1]).values():
    for net in netinfo['nets']:
        # print(net["hier"], net["name"])
        if net["hier"] == "rvfi_testbench.wrapper" and net["name"] == "rvfi_valid":
            rvfi_valid = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper" and net["name"] == "rvfi_order":
            rvfi_order = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper" and net["name"] == "rvfi_insn":
            rvfi_insn = netinfo['tv']

assert len(rvfi_valid) == len(rvfi_order)
assert len(rvfi_valid) == len(rvfi_insn)

prog = list()

for tv_valid, tv_order, tv_insn in zip(rvfi_valid, rvfi_order, rvfi_insn):
    if tv_valid[1] == '1':
        prog.append((int(tv_order[1], 2), int(tv_insn[1], 2)))

with open("disasm.s", "w") as f:
    for tv_order, tv_insn in sorted(prog):
        if tv_insn & 3 != 3 and tv_insn & 0xffff0000 == 0:
            print(".hword 0x%04x # %d" % (tv_insn, tv_order), file=f)
        else:
            print(".word 0x%08x # %d" % (tv_insn, tv_order), file=f)

system("riscv64-unknown-elf-gcc -c disasm.s")
system("riscv64-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")

