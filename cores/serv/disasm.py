#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system
from sys import argv, exit
from getopt import getopt

def usage():
    print("Usage: %s <vcd-file>" % argv[0])
    exit(1)

try:
    opts, args = getopt(argv[1:], "", [])
except:
    usage()

for o, a in opts:
    if o == "--64":
        pass
    else:
        usage()

if len(args) != 1:
    usage()

rvfi_valid = None
rvfi_order = None
rvfi_insn = None

for netinfo in parse_vcd(args[0]).values():
    for net in netinfo['nets']:
        # print(net["hier"], net["name"])
        if net["hier"] in ["rvfi_testbench.wrapper"] and net["name"] == "rvfi_valid":
            rvfi_valid = netinfo['tv']
        if net["hier"] in ["rvfi_testbench.wrapper"] and net["name"] == "rvfi_order":
            rvfi_order = netinfo['tv']
        if net["hier"] in ["rvfi_testbench.wrapper"] and net["name"] == "rvfi_insn":
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

system("/opt/riscv32imc/bin/riscv32-unknown-elf-gcc -c disasm.s")
system("/opt/riscv32imc/bin/riscv32-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")

