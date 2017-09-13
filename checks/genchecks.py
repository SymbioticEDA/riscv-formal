#!/usr/bin/env python3

import os, shutil, re

nret = 1
isa = "rv32i"
ilen = 32
xlen = 32
compr = False

insn_depth = 30

reg_start = 20
reg_depth = 30

pc_fwd_start = 20
pc_fwd_depth = 30

pc_bwd_start = 20
pc_bwd_depth = 30

liveness_start = 10
liveness_trig = 20
liveness_depth = 30

unique_start = 10
unique_trig = 20
unique_depth = 30

causal_start = 20
causal_depth = 30

blackbox = False

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
            elif k == "isa":
                isa = v
            elif k == "insn_depth":
                insn_depth = int(v)
            elif k == "reg_start":
                reg_start = int(v)
            elif k == "reg_depth":
                reg_depth = int(v)
            elif k == "pc_fwd_start":
                pc_fwd_start = int(v)
            elif k == "pc_fwd_depth":
                pc_fwd_depth = int(v)
            elif k == "pc_bwd_start":
                pc_bwd_start = int(v)
            elif k == "pc_bwd_depth":
                pc_bwd_depth = int(v)
            elif k == "liveness_start":
                liveness_start = int(v)
            elif k == "liveness_trig":
                liveness_trig = int(v)
            elif k == "liveness_depth":
                liveness_depth = int(v)
            elif k == "unique_start":
                unique_start = int(v)
            elif k == "unique_trig":
                unique_trig = int(v)
            elif k == "unique_depth":
                unique_depth = int(v)
            elif k == "causal_start":
                causal_start = int(v)
            elif k == "causal_depth":
                causal_depth = int(v)
            elif k == "blackbox":
                blackbox = bool(int(v))
            else:
                assert 0
        else:
            assert line == ""

if "64" in isa:
    xlen = 64

if "c" in isa:
    compr = True

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

instruction_checks = set()
consistency_checks = set()

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
    instruction_checks.add(check)

    hargs["insn"] = insn
    hargs["channel"] = "%d" % chanidx
    hargs["depth"] = insn_depth
    hargs["depth_plus"] = insn_depth + 2

    with open("checks/%s.sby" % check, "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode bmc
                : append 5
                : tbtop wrapper.uut
                : depth @depth_plus@
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
        """, **hargs)

        if blackbox:
            print("verilog_defines -D RISCV_FORMAL_BLACKBOX_REGS", file=sby_file)

        if compr:
            print("verilog_defines -D RISCV_FORMAL_COMPRESSED", file=sby_file)

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

with open("../../insns/isa_%s.txt" % isa) as isa_file:
    for insn in isa_file:
        for chanidx in range(nret):
            check_insn(insn.strip(), chanidx)

# ------------------------------ Consistency Checkers ------------------------------

def check_cons(check, chanidx=None, start=None, trig=None, depth=None):
    hargs["check"] = check
    hargs["start"] = start

    hargs["depth"] = depth
    hargs["depth_plus"] = depth + 2

    if chanidx is not None:
        hargs["channel"] = "%d" % chanidx
        check += "_ch%d" % chanidx

    if test_disabled(check): return
    consistency_checks.add(check)

    with open("checks/%s.sby" % check, "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode bmc
                : append 5
                : tbtop wrapper.uut
                : depth @depth_plus@
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

        if blackbox and hargs["check"] != "liveness":
            print("verilog_defines -D RISCV_FORMAL_BLACKBOX_ALU", file=sby_file)

        if blackbox and hargs["check"] != "reg":
            print("verilog_defines -D RISCV_FORMAL_BLACKBOX_REGS", file=sby_file)

        if chanidx is not None:
            print("verilog_defines -D RISCV_FORMAL_CHANNEL_IDX=%d" % chanidx, file=sby_file)

        if trig is not None:
            print("verilog_defines -D RISCV_FORMAL_TRIG_CYCLE=%d" % trig, file=sby_file)

        if "script-defines" in config:
            print_hfmt(sby_file, config["script-defines"], **hargs)

        if ("script-defines %s" % hargs["check"]) in config:
            print_hfmt(sby_file, config["script-defines %s" % hargs["check"]], **hargs)

        print_hfmt(sby_file, """
                : read_verilog -sv @basedir@/checks/rvfi_macros.vh
                : read_verilog -sv @basedir@/checks/rvfi_channel.sv
                : read_verilog -sv @basedir@/checks/rvfi_testbench.sv
                : read_verilog -sv @basedir@/checks/rvfi_@check@_check.sv
        """, **hargs)

        if "script-sources" in config:
            print_hfmt(sby_file, config["script-sources"], **hargs)

        print_hfmt(sby_file, """
                : prep -nordff -top rvfi_testbench
        """, **hargs)

for i in range(nret):
    check_cons("reg", chanidx=i, start=reg_start, depth=reg_depth)

for i in range(nret):
    check_cons("pc_fwd", chanidx=i, start=pc_fwd_start, depth=pc_fwd_depth)
    check_cons("pc_bwd", chanidx=i, start=pc_bwd_start, depth=pc_bwd_depth)

for i in range(nret):
    check_cons("liveness", chanidx=i, start=liveness_start, trig=liveness_trig, depth=liveness_depth)
    check_cons("unique", chanidx=i, start=unique_start, trig=unique_trig, depth=unique_depth)

for i in range(nret):
    check_cons("causal", chanidx=i, start=causal_start, depth=causal_depth)

# ------------------------------ Makefile ------------------------------

with open("checks/makefile", "w") as mkfile:
    print("all:", end="", file=mkfile)

    checks = list(sorted(consistency_checks)) + list(sorted(instruction_checks))

    for check in checks:
        print(" %s/PASS" % check, end="", file=mkfile)
    print(file=mkfile)

    for check in checks:
        print("%s/PASS:" % check, file=mkfile)
        print("\t%s %s.sby" % (sbycmd, check), file=mkfile)

