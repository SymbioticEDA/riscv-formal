#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system
from sys import argv

rvfi_valid_0 = None
rvfi_valid_1 = None
rvfi_order_0 = None
rvfi_order_1 = None
rvfi_insn_0 = None
rvfi_insn_1 = None

for netinfo in parse_vcd(argv[1]).values():
    for net in netinfo['nets']:
        # print(net["hier"], net["name"])
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_0" and net["name"] == "valid":
            rvfi_valid_0 = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_0" and net["name"] == "order":
            rvfi_order_0 = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_0" and net["name"] == "insn":
            rvfi_insn_0 = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_1" and net["name"] == "valid":
            rvfi_valid_1 = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_1" and net["name"] == "order":
            rvfi_order_1 = netinfo['tv']
        if net["hier"] == "rvfi_testbench.wrapper.rvfi_channel_1" and net["name"] == "insn":
            rvfi_insn_1 = netinfo['tv']

assert len(rvfi_valid_0) == len(rvfi_order_0)
assert len(rvfi_valid_1) == len(rvfi_order_1)

assert len(rvfi_valid_0) == len(rvfi_insn_0)
assert len(rvfi_valid_1) == len(rvfi_insn_1)

prog = list()

for tv_valid, tv_order, tv_insn in zip(rvfi_valid_0, rvfi_order_0, rvfi_insn_0):
    if tv_valid[1] == '1':
        prog.append((int(tv_order[1], 2), int(tv_insn[1], 2)))

for tv_valid, tv_order, tv_insn in zip(rvfi_valid_1, rvfi_order_1, rvfi_insn_1):
    if tv_valid[1] == '1':
        prog.append((int(tv_order[1], 2), int(tv_insn[1], 2)))

with open("disasm.s", "w") as f:
    for tv_order, tv_insn in sorted(prog):
        if tv_insn & 3 != 3 and tv_insn & 0xffff0000 == 0:
            print(".hword 0x%04x # %d" % (tv_insn, tv_order), file=f)
        else:
            print(".word 0x%08x # %d" % (tv_insn, tv_order), file=f)

system("riscv32-unknown-elf-gcc -c disasm.s")
system("riscv32-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")

