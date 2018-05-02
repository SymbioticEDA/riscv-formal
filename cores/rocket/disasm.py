#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system
from sys import argv, exit
from getopt import getopt

mode_d = False
mode_64 = False

def usage():
    print("Usage: %s [-d] [--64] <vcd-file>" % argv[0])
    exit(1)

try:
    opts, args = getopt(argv[1:], "d", ["64"])
except:
    usage()

for o, a in opts:
    if o == "-d":
        mode_d = True
    elif o == "--64":
        mode_64 = True
    else:
        usage()

if len(args) != 1:
    usage()

if mode_d:
    tilelink_d_valid = None
    tilelink_d_ready = None
    tilelink_d_data = None

    for netinfo in parse_vcd(args[0]).values():
        for net in netinfo['nets']:
            print(net["hier"], net["name"])
            if net["hier"] in ["rvfi_testbench.wrapper", "testbench.uut"] and net["name"] == "io_master_0_d_valid":
                tilelink_d_valid = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper", "testbench.uut"] and net["name"] == "io_master_0_d_ready":
                tilelink_d_ready = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper", "testbench.uut"] and net["name"] == "io_master_0_d_bits_data":
                tilelink_d_data = netinfo['tv']

    assert len(tilelink_d_valid) == len(tilelink_d_ready)
    assert len(tilelink_d_valid) == len(tilelink_d_data)

    with open("disasm.s", "w") as f:
        for tv_valid, tv_ready, tv_data in zip(tilelink_d_valid, tilelink_d_ready, tilelink_d_data):
            if int(tv_valid[1], 2) and int(tv_ready[1], 2):
                print(".word 0x%04x" % int(tv_data[1], 2), file=f)
else:
    rvfi_valid_0 = None
    rvfi_valid_1 = None
    rvfi_order_0 = None
    rvfi_order_1 = None
    rvfi_insn_0 = None
    rvfi_insn_1 = None

    for netinfo in parse_vcd(args[0]).values():
        for net in netinfo['nets']:
            # print(net["hier"], net["name"])
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_0", "testbench.uut.rvfi_channel_0"] and net["name"] == "valid":
                rvfi_valid_0 = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_0", "testbench.uut.rvfi_channel_0"] and net["name"] == "order":
                rvfi_order_0 = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_0", "testbench.uut.rvfi_channel_0"] and net["name"] == "insn":
                rvfi_insn_0 = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_1", "testbench.uut.rvfi_channel_1"] and net["name"] == "valid":
                rvfi_valid_1 = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_1", "testbench.uut.rvfi_channel_1"] and net["name"] == "order":
                rvfi_order_1 = netinfo['tv']
            if net["hier"] in ["rvfi_testbench.wrapper.rvfi_channel_1", "testbench.uut.rvfi_channel_1"] and net["name"] == "insn":
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

if mode_64:
    system("riscv-tools/bin/riscv64-unknown-elf-gcc -c disasm.s")
    system("riscv-tools/bin/riscv64-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")
else:
    system("riscv-tools/bin/riscv32-unknown-elf-gcc -c disasm.s")
    system("riscv-tools/bin/riscv32-unknown-elf-objdump -d -M numeric,no-aliases disasm.o")

