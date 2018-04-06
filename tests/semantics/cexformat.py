#!/usr/bin/env python3

from Verilog_VCD.Verilog_VCD import parse_vcd
from os import system, remove
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
    usage()

if len(args) != 1:
    usage()

data = dict()

for netinfo in parse_vcd(args[0]).values():
    for net in netinfo['nets']:
        if net["hier"] == "top":
            data[net["name"]] = int(netinfo['tv'][0][1], 2)
        if net["hier"] == "top.rvspec_inst" and (net["name"].startswith("in_") or net["name"].startswith("out_")):
            data[net["name"]] = int(netinfo['tv'][0][1], 2)

print()

with open(".cexformat_tmp.s", "w") as f:
    print(".word 0x%08X" % data["insn"], file=f)

system("riscv32-unknown-elf-gcc -c .cexformat_tmp.s")
system("riscv32-unknown-elf-objdump -d -M numeric,no-aliases .cexformat_tmp.o > .cexformat_tmp.t")

with open(".cexformat_tmp.t") as f:
    for line in f:
        if line.startswith("   0:"):
            s = "%s   (0x%s)" % (" ".join(line.split()[2:]), line.split()[1])
            print(s)
            print("=" * len(s))

remove(".cexformat_tmp.s")
remove(".cexformat_tmp.o")
remove(".cexformat_tmp.t")

print()

for i in range(1, 32):
    print("x%-2d 0x%08X 0x%08X%s" % (i, data["x%d" % i], data["nx%d" % i], "" if data["x%d" % i] == data["nx%d" % i] else " <--"))

print()

def prvalue(name, nbits):
    if nbits == 1 or nbits == 5:
        print("%-20s %10d" % (name, data[name]))
    elif nbits == 4:
        print("%-20s     0b%s" % (name, format(data[name], "04b")))
    elif nbits == 32:
        print("%-20s 0x%08X" % (name, data[name]))
    else:
        assert False

prvalue("rvfi_valid",      1)
prvalue("rvfi_insn",      32)
prvalue("rvfi_rs1_rdata", 32)
prvalue("rvfi_rs2_rdata", 32)

print()

prvalue("spec_valid",      1)
prvalue("spec_trap",       1)
prvalue("spec_rs1_addr",   5)
prvalue("spec_rs2_addr",   5)
prvalue("spec_rd_addr",    5)
prvalue("spec_rd_wdata",  32)

print()

prvalue("rvfi_pc_rdata",  32)
prvalue("spec_pc_wdata",  32)

print()

prvalue("spec_mem_rmask",  4)
prvalue("spec_mem_wmask",  4)
prvalue("spec_mem_addr",  32)
prvalue("rvfi_mem_rdata", 32)
prvalue("spec_mem_wdata", 32)

print()

prvalue("in_instr", 32)
prvalue("in_pc", 32)
prvalue("out_nextPC", 32)
prvalue("out_exception", 1)

print()

prvalue("out_storeEnable", 4)
prvalue("out_storeAddress", 32)
prvalue("out_storeData", 32)

print()

prvalue("out_loadEnable", 4)
prvalue("out_loadAddress", 32)
prvalue("in_loadData", 32)

print()
print("--------")
print()

print("let in_instr = fromIntegral 0x%08X" % data["insn"])
print("let in_loadData = fromIntegral 0x%08X" % data["rdata"])

if data["spec_rs1_addr"]:
    print("let register_rs1 = Just (%d, fromIntegral 0x%08X)" % (data["spec_rs1_addr"], data["rvfi_rs1_rdata"]))
else:
    print("let register_rs1 = Nothing")

if data["spec_rs2_addr"]:
    print("let register_rs2 = Just (%d, fromIntegral 0x%08X)" % (data["spec_rs2_addr"], data["rvfi_rs2_rdata"]))
else:
    print("let register_rs2 = Nothing")

print()

if data["spec_mem_wmask"]:
    print("let expected_out_store = Just (fromIntegral 0x%08X, fromIntegral 0x%08X)" % (data["spec_mem_addr"], data["spec_mem_wdata"]))
else:
    print("let expected_out_store = Nothing")

if data["spec_rd_addr"]:
    print("let expected_rd = Just (%d, fromIntegral 0x%08X)" % (data["spec_rd_addr"], data["spec_rd_wdata"]))
else:
    print("let expected_rd = Nothing")

if data["spec_mem_rmask"]:
    print("let expected_out_loadAddress = Just (fromIntegral 0x%08X)" % data["spec_mem_addr"])
else:
    print("let expected_out_loadAddress = Nothing")

print("let expected_out_exception = %s" % ("True" if data["spec_trap"] else "False"))

print()

