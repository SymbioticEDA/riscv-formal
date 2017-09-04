#!/usr/bin/env python3

import os, shutil, re

nret = 1
xlen = 32
ilen = 32

insn_depth = 30

reg_start = 20
reg_depth = 30

pc_fwd_start = 20
pc_fwd_depth = 30

pc_bwd_start = 20
pc_bwd_depth = 30

basedir = "%s/../.." % os.getcwd()
corename = os.getcwd().split("/")[-1]
smt_solver = "boolector"
use_aiger = False
sbycmd = "sby"
config = dict()

with open("genchecks.cfg", "r") as f:
    cfgsection = None
    for line in f:
        line = line.strip()

        if line.startswith("#"):
            continue

        if line.startswith("[") and line.endswith("]"):
            cfgsection = line.lstrip("[").rstrip("]")
            continue

        if cfgsection is not None:
            if cfgsection not in config:
                config[cfgsection] = ""
            config[cfgsection] += line + "\n"

if "options" in config:
    for line in config["options"].split("\n"):
        match = re.match(r"(\S+)\s*=\s*(.*)", line)
        if match:
            k, v = match.group(1), match.group(2)
            if k == "nret":
                nret = int(v)
            elif k == "insn_depth":
                insn_depth = int(v)
            elif k == "reg_start":
                reg_start = int(v)
            elif k == "reg_depth":
                reg_depth = int(v)
            elif k == "pc_fwd_start":
                pc_start = int(v)
            elif k == "pc_fwd_depth":
                pc_depth = int(v)
            elif k == "pc_bwd_start":
                pc_start = int(v)
            elif k == "pc_bwd_depth":
                pc_depth = int(v)
            else:
                assert 0
        else:
            assert line == ""

shutil.rmtree("checks", ignore_errors=True)
os.mkdir("checks")

def print_hfmt(f, text, **kwargs):
    for line in text.split("\n"):
        match = re.match(r"^\s*: ?(.*)", line)
        if match:
            line = match.group(1)
        elif line.strip() == "":
            continue
        print(re.sub(r"@([a-zA-Z0-9_]+)@",
                lambda match: str(kwargs[match.group(1)]), line), file=f)

hargs = dict()
hargs["basedir"] = basedir
hargs["core"] = corename
hargs["nret"] = nret
hargs["xlen"] = xlen
hargs["ilen"] = ilen
hargs["core"] = corename

checks = set()

if use_aiger:
    hargs["engine"] = "abc bmc3"
    hargs["ilang_file"] = corename + "-gates.il"
else:
    hargs["engine"] = "smtbmc --presat %s" % smt_solver
    hargs["ilang_file"] = corename + "-hier.il"

def test_disabled(check):
    if "filter-checks" in config:
        for line in config["filter-checks"].split("\n"):
            line = line.strip().split()
            if len(line) == 0: continue
            assert len(line) == 2 and line[0] in ["-", "+"]
            if re.match(line[1], check):
                return line[0] == "-"
    return False

# ------------------------------ Instruction Checkers ------------------------------

def check_insn(insn, chanidx):
    check = "insn_%s_ch%d" % (insn, chanidx)
    if test_disabled(check): return
    checks.add(check)

    hargs["insn"] = insn
    hargs["channel"] = "%d" % chanidx
    hargs["depth"] = insn_depth
    hargs["depth_plus_5"] = insn_depth + 5

    with open("checks/%s.sby" % check, "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode bmc
                : append 5
                : tbtop wrapper.uut
                : depth @depth_plus_5@
                :
                : [engines]
                : @engine@
                :
                : [script]
                : verilog_defines -D RISCV_FORMAL
                : verilog_defines -D RISCV_FORMAL_NRET=@nret@
                : verilog_defines -D RISCV_FORMAL_XLEN=@xlen@
                : verilog_defines -D RISCV_FORMAL_ILEN=@ilen@
                : verilog_defines -D RISCV_FORMAL_CHECKER=rvfi_insn_check
                : verilog_defines -D RISCV_FORMAL_RESET_CYCLES=1
                : verilog_defines -D RISCV_FORMAL_CHECK_CYCLE=@depth@
                : verilog_defines -D RISCV_FORMAL_INSN_MODEL=rvfi_insn_@insn@
                : verilog_defines -D RISCV_FORMAL_CHANNEL_IDX=@channel@
                : verilog_defines -D RISCV_FORMAL_STRICT_READ
        """, **hargs)

        if "script-defines" in config:
            print_hfmt(sby_file, config["script-defines"], **hargs)

        print_hfmt(sby_file, """
                : read_verilog -sv @basedir@/checks/rvfi_macros.vh
                : read_verilog -sv @basedir@/checks/rvfi_channel.sv
                : read_verilog -sv @basedir@/checks/rvfi_testbench.sv
                : read_verilog -sv @basedir@/checks/rvfi_insn_check.sv
                : read_verilog -sv @basedir@/insns/insn_@insn@.v
        """, **hargs)

        if "script-sources" in config:
            print_hfmt(sby_file, config["script-sources"], **hargs)

        print_hfmt(sby_file, """
                : prep -nordff -top rvfi_testbench
        """, **hargs)

with open("../../insns/isa_rv32i.txt") as isa_file:
    for insn in isa_file:
        for chanidx in range(nret):
            check_insn(insn.strip(), chanidx)

# ------------------------------ Consistency Checkers ------------------------------

def check_cons(check, chanidx=None, start=None, trig=None, depth=None):
    hargs["check"] = check
    hargs["start"] = start

    hargs["depth"] = depth
    hargs["depth_plus_5"] = depth + 5

    if chanidx is not None:
        hargs["channel"] = "%d" % chanidx
        check += "_ch%d" % chanidx

    if test_disabled(check): return
    checks.add(check)

    with open("checks/%s.sby" % check, "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode bmc
                : append 5
                : tbtop wrapper.uut
                : depth @depth_plus_5@
                :
                : [engines]
                : @engine@
                :
                : [script]
                : verilog_defines -D RISCV_FORMAL
                : verilog_defines -D RISCV_FORMAL_NRET=@nret@
                : verilog_defines -D RISCV_FORMAL_XLEN=@xlen@
                : verilog_defines -D RISCV_FORMAL_ILEN=@ilen@
                : verilog_defines -D RISCV_FORMAL_CHECKER=rvfi_@check@_check
                : verilog_defines -D RISCV_FORMAL_RESET_CYCLES=@start@
                : verilog_defines -D RISCV_FORMAL_CHECK_CYCLE=@depth@
        """, **hargs)

        if chanidx is not None:
            print("verilog_defines -D RISCV_FORMAL_CHANNEL_IDX=%d" % chanidx, file=sby_file)

        if trig is not None:
            print("verilog_defines -D RISCV_FORMAL_TRIG_CYCLE=%d" % trig, file=sby_file)

        if "script-defines" in config:
            print_hfmt(sby_file, config["script-defines"], **hargs)

        print_hfmt(sby_file, """
                : read_verilog -sv @basedir@/checks/rvfi_macros.vh
                : read_verilog -sv @basedir@/checks/rvfi_channel.sv
                : read_verilog -sv @basedir@/checks/rvfi_testbench.sv
                : read_verilog -sv @basedir@/checks/rvfi_@check@_check.sv
        """, **hargs)

        if "script-sources" in config:
            print_hfmt(sby_file, config["script-sources"], **hargs)

        print_hfmt(sby_file, """
                : prep -top rvfi_testbench
        """, **hargs)

for i in range(nret):
    check_cons("reg", chanidx=i, start=reg_start, depth=reg_depth)

for i in range(nret):
    check_cons("pc_fwd", chanidx=i, start=pc_fwd_start, depth=pc_fwd_depth)
    check_cons("pc_bwd", chanidx=i, start=pc_bwd_start, depth=pc_bwd_depth)

# ------------------------------ Makefile ------------------------------

with open("checks/makefile", "w") as mkfile:
    print("all:", end="", file=mkfile)

    for check in checks:
        print(" %s/PASS" % check, end="", file=mkfile)
    print(file=mkfile)

    for check in checks:
        print("%s/PASS:" % check, file=mkfile)
        print("\t%s %s.sby" % (sbycmd, check), file=mkfile)

