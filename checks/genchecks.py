#!/usr/bin/env python3
#
# Copyright (C) 2017  Clifford Wolf <clifford@symbioticeda.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

import os, sys, shutil, re

nret = 1
isa = "rv32i"
ilen = 32
xlen = 32
csrs = set()
compr = False

depths = list()
groups = [None]
blackbox = False

cfgname = "checks"
basedir = "%s/../.." % os.getcwd()
incdir = basedir
corename = os.getcwd().split("/")[-1]
solver = "boolector"
dumpsmt2 = False
sbycmd = "sby"
config = dict()
mode = "bmc"

if len(sys.argv) > 1:
    assert 2 <= len(sys.argv) <= 4
    cfgname = sys.argv[1]
    if len(sys.argv) > 2:
        basedir = sys.argv[2]
    if len(sys.argv) > 3:
        incdir = sys.argv[3]

print("Reading %s.cfg." % cfgname)
with open("%s.cfg" % cfgname, "r") as f:
    cfgsection = None
    cfgsubsection = None
    for line in f:
        line = line.strip()

        if line.startswith("#"):
            continue

        if line.startswith("[") and line.endswith("]"):
            cfgsection = line.lstrip("[").rstrip("]")
            cfgsubsection = None
            if cfgsection.startswith("assume ") or cfgsection == "assume":
                cfgsubsection = cfgsection.split()[1:]
                cfgsection = "assume"
            continue

        if cfgsection is not None:
            if cfgsubsection is None:
                if cfgsection not in config:
                    config[cfgsection] = ""
                config[cfgsection] += line + "\n"
            else:
                if cfgsection not in config:
                    config[cfgsection] = []
                config[cfgsection].append((cfgsubsection, line))

if "options" in config:
    for line in config["options"].split("\n"):
        line = line.split()

        if len(line) == 0:
            continue

        elif line[0] == "nret":
            assert len(line) == 2
            nret = int(line[1])

        elif line[0] == "isa":
            assert len(line) == 2
            isa = line[1]

        elif line[0] == "blackbox":
            assert len(line) == 1
            blackbox = True

        elif line[0] == "solver":
            assert len(line) == 2
            solver = line[1]

        elif line[0] == "dumpsmt2":
            assert len(line) == 1
            dumpsmt2 = True

        elif line[0] == "mode":
            assert len(line) == 2
            assert(line[1] in ("bmc", "prove"))
            mode = line[1]

        else:
            print(line)
            assert 0

if "csrs" in config:
    for line in config["csrs"].split("\n"):
        for item in line.split():
            csrs.add(item)

if "64" in isa:
    xlen = 64

if "c" in isa:
    compr = True

if "groups" in config:
    groups += config["groups"].split()

print("Creating %s directory." % cfgname)
shutil.rmtree(cfgname, ignore_errors=True)
os.mkdir(cfgname)

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
hargs["incdir"] = incdir
hargs["core"] = corename
hargs["nret"] = nret
hargs["xlen"] = xlen
hargs["ilen"] = ilen
hargs["append"] = 0
hargs["mode"] = mode

if "cover" in config:
    hargs["cover"] = config["cover"]

instruction_checks = set()
consistency_checks = set()

if solver == "bmc3":
    hargs["engine"] = "abc bmc3"
    hargs["ilang_file"] = corename + "-gates.il"
elif solver == "btormc":
    hargs["engine"] = "btor btormc"
    hargs["ilang_file"] = corename + "-hier.il"
else:
    hargs["engine"] = "smtbmc %s%s" % ("--dumpsmt2 " if dumpsmt2 else "", solver)
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

def get_depth_cfg(patterns):
    ret = None
    if "depth" in config:
        for line in config["depth"].split("\n"):
            line = line.strip().split()
            if len(line) == 0:
                continue
            for pat in patterns:
                if re.fullmatch(line[0], pat):
                    ret = [int(s) for s in line[1:]]
    return ret

# ------------------------------ Instruction Checkers ------------------------------

def check_insn(grp, insn, chanidx, csr_mode=False):
    pf = "" if grp is None else grp+"_"
    if csr_mode:
        check = "%scsrw_%s_ch%d" % (pf, insn, chanidx)
        depth_cfg = get_depth_cfg(["%scsrw" % (pf,), "%scsrw_ch%d" % (pf, chanidx), "%scsrw_%s" % (pf, insn), "%scsrw_%s_ch%d" % (pf, insn, chanidx)])
    else:
        check = "%sinsn_%s_ch%d" % (pf, insn, chanidx)
        depth_cfg = get_depth_cfg(["%sinsn" % (pf,), "%sinsn_ch%d" % (pf, chanidx), "%sinsn_%s" % (pf, insn), "%sinsn_%s_ch%d" % (pf, insn, chanidx)])

    if depth_cfg is None: return
    assert len(depth_cfg) == 1

    if test_disabled(check): return
    instruction_checks.add(check)

    hargs["insn"] = insn
    hargs["checkch"] = check
    hargs["channel"] = "%d" % chanidx
    hargs["depth"] = depth_cfg[0]
    hargs["depth_plus"] = depth_cfg[0] + 1
    hargs["skip"] = depth_cfg[0]

    with open("%s/%s.sby" % (cfgname, check), "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode @mode@
                : expect pass,fail
                : append @append@
                : depth @depth_plus@
                : skip @skip@
                :
                : [engines]
                : @engine@
                :
                : [script]
        """, **hargs)

        if "script-defines" in config:
            print_hfmt(sby_file, config["script-defines"], **hargs)

        print("read_verilog -sv %s.sv" % check, file=sby_file)

        if "script-sources" in config:
            print_hfmt(sby_file, config["script-sources"], **hargs)

        print_hfmt(sby_file, """
                : prep -flatten -nordff -top rvfi_testbench
        """, **hargs)

        if "script-link" in config:
            print_hfmt(sby_file, config["script-link"], **hargs)

        print_hfmt(sby_file, """
                : chformal -early
                :
                : [files]
                : @basedir@/checks/rvfi_macros.vh
                : @basedir@/checks/rvfi_channel.sv
                : @basedir@/checks/rvfi_testbench.sv
        """, **hargs)

        if csr_mode:
            print_hfmt(sby_file, """
                    : @basedir@/checks/rvfi_csrw_check.sv
            """, **hargs)
        else:
            print_hfmt(sby_file, """
                    : @basedir@/checks/rvfi_insn_check.sv
                    : @basedir@/insns/insn_@insn@.v
            """, **hargs)

        print_hfmt(sby_file, """
                :
                : [file defines.sv]
                : `define RISCV_FORMAL
                : `define RISCV_FORMAL_NRET @nret@
                : `define RISCV_FORMAL_XLEN @xlen@
                : `define RISCV_FORMAL_ILEN @ilen@
                : `define RISCV_FORMAL_RESET_CYCLES 1
                : `define RISCV_FORMAL_CHECK_CYCLE @depth@
                : `define RISCV_FORMAL_CHANNEL_IDX @channel@
        """, **hargs)

        if "assume" in config:
            print("`define RISCV_FORMAL_ASSUME", file=sby_file)

        if mode == "prove":
            print("`define RISCV_FORMAL_UNBOUNDED", file=sby_file)

        for csr in sorted(csrs):
            print("`define RISCV_FORMAL_CSR_%s" % csr.upper(), file=sby_file)

        if csr_mode and insn in ("mcycle", "minstret"):
            print("`define RISCV_FORMAL_CSRWH", file=sby_file)

        if csr_mode:
            print_hfmt(sby_file, """
                    : `define RISCV_FORMAL_CHECKER rvfi_csrw_check
                    : `define RISCV_FORMAL_CSRW_NAME @insn@
            """, **hargs)
        else:
            print_hfmt(sby_file, """
                    : `define RISCV_FORMAL_CHECKER rvfi_insn_check
                    : `define RISCV_FORMAL_INSN_MODEL rvfi_insn_@insn@
            """, **hargs)

        if blackbox:
            print("`define RISCV_FORMAL_BLACKBOX_REGS", file=sby_file)

        if compr:
            print("`define RISCV_FORMAL_COMPRESSED", file=sby_file)

        if "defines" in config:
            print_hfmt(sby_file, config["defines"], **hargs)

        print_hfmt(sby_file, """
                : `include "rvfi_macros.vh"
                :
                : [file @checkch@.sv]
                : `include "defines.sv"
                : `include "rvfi_channel.sv"
                : `include "rvfi_testbench.sv"
        """, **hargs)

        if csr_mode:
            print_hfmt(sby_file, """
                    : `include "rvfi_csrw_check.sv"
            """, **hargs)
        else:
            print_hfmt(sby_file, """
                    : `include "rvfi_insn_check.sv"
                    : `include "insn_@insn@.v"
            """, **hargs)

        if "assume" in config:
            print("", file=sby_file)
            print("[file assume_stmts.vh]", file=sby_file)
            for pat, line in config["assume"]:
                enabled = True
                for p in pat:
                    if p.startswith("!"):
                        p = p[1:]
                        enabled = False
                    else:
                        enabled = True
                    if re.match(p, check):
                        enabled = not enabled
                        break
                if enabled:
                    print(line, file=sby_file)

for grp in groups:
    with open("%s/insns/isa_%s.txt" % (basedir, isa)) as isa_file:
        for insn in isa_file:
            for chanidx in range(nret):
                check_insn(grp, insn.strip(), chanidx)

    for csr in sorted(csrs):
        for chanidx in range(nret):
            check_insn(grp, csr, chanidx, csr_mode=True)

# ------------------------------ Consistency Checkers ------------------------------

def check_cons(grp, check, chanidx=None, start=None, trig=None, depth=None, csr_mode=False):
    pf = "" if grp is None else grp+"_"
    if csr_mode:
        csr_name = check
        check = pf + "csrc_" + csr_name
        hargs["check"] = "csrc"

        if chanidx is not None:
            depth_cfg = get_depth_cfg(["%scsrc" % (pf,), check, "%scsrc_ch%d" % (pf, chanidx), "%s_ch%d" % (check, chanidx)])
            hargs["channel"] = "%d" % chanidx
            check += "_ch%d" % chanidx

        else:
            depth_cfg = get_depth_cfg(["csrc", check])
    else:
        hargs["check"] = check
        check = pf + check

        if chanidx is not None:
            depth_cfg = get_depth_cfg([check, "%s_ch%d" % (check, chanidx)])
            hargs["channel"] = "%d" % chanidx
            check += "_ch%d" % chanidx

        else:
            depth_cfg = get_depth_cfg([check])

    if depth_cfg is None: return

    if start is not None:
        start = depth_cfg[start]
    else:
        start = 1

    if trig is not None:
        trig = depth_cfg[trig]

    if depth is not None:
        depth = depth_cfg[depth]

    hargs["start"] = start
    hargs["depth"] = depth
    hargs["depth_plus"] = depth + 1
    hargs["skip"] = depth

    hargs["checkch"] = check

    hargs["xmode"] = hargs["mode"]
    if check == "cover": hargs["xmode"] = "cover"

    if test_disabled(check): return
    consistency_checks.add(check)

    with open("%s/%s.sby" % (cfgname, check), "w") as sby_file:
        print_hfmt(sby_file, """
                : [options]
                : mode @xmode@
                : expect pass,fail
                : append @append@
                : depth @depth_plus@
                : skip @skip@
                :
                : [engines]
                : @engine@
                :
                : [script]
        """, **hargs)

        if "script-defines" in config:
            print_hfmt(sby_file, config["script-defines"], **hargs)

        if ("script-defines %s" % hargs["check"]) in config:
            print_hfmt(sby_file, config["script-defines %s" % hargs["check"]], **hargs)

        print_hfmt(sby_file, """
                : read_verilog -sv @checkch@.sv
        """, **hargs)

        if "script-sources" in config:
            print_hfmt(sby_file, config["script-sources"], **hargs)

        print_hfmt(sby_file, """
                : prep -flatten -nordff -top rvfi_testbench
        """, **hargs)

        if "script-link" in config:
            print_hfmt(sby_file, config["script-link"], **hargs)

        print_hfmt(sby_file, """
                : chformal -early
                :
                : [files]
                : @basedir@/checks/rvfi_macros.vh
                : @basedir@/checks/rvfi_channel.sv
                : @basedir@/checks/rvfi_testbench.sv
                : @basedir@/checks/rvfi_@check@_check.sv
                :
                : [file defines.sv]
        """, **hargs)

        print_hfmt(sby_file, """
                : `define RISCV_FORMAL
                : `define RISCV_FORMAL_NRET @nret@
                : `define RISCV_FORMAL_XLEN @xlen@
                : `define RISCV_FORMAL_ILEN @ilen@
                : `define RISCV_FORMAL_CHECKER rvfi_@check@_check
                : `define RISCV_FORMAL_RESET_CYCLES @start@
                : `define RISCV_FORMAL_CHECK_CYCLE @depth@
        """, **hargs)

        if "assume" in config:
            print("`define RISCV_FORMAL_ASSUME", file=sby_file)

        if mode == "prove":
            print("`define RISCV_FORMAL_UNBOUNDED", file=sby_file)

        for csr in sorted(csrs):
            print("`define RISCV_FORMAL_CSR_%s" % csr.upper(), file=sby_file)

        if csr_mode:
            if csr_name in ("mcycle", "minstret"):
                print("`define RISCV_FORMAL_CSRC_UPCNT", file=sby_file)
            print("`define RISCV_FORMAL_CSRC_NAME " + csr_name, file=sby_file)

        if blackbox and hargs["check"] != "liveness":
            print("`define RISCV_FORMAL_BLACKBOX_ALU", file=sby_file)

        if blackbox and hargs["check"] != "reg":
            print("`define RISCV_FORMAL_BLACKBOX_REGS", file=sby_file)

        if chanidx is not None:
            print("`define RISCV_FORMAL_CHANNEL_IDX %d" % chanidx, file=sby_file)

        if trig is not None:
            print("`define RISCV_FORMAL_TRIG_CYCLE %d" % trig, file=sby_file)

        if hargs["check"] in ("liveness", "hang"):
            print("`define RISCV_FORMAL_FAIRNESS", file=sby_file)

        if "defines" in config:
            print_hfmt(sby_file, config["defines"], **hargs)

        if ("defines %s" % hargs["check"]) in config:
            print_hfmt(sby_file, config["defines %s" % hargs["check"]], **hargs)

        print_hfmt(sby_file, """
                : `include "rvfi_macros.vh"
                :
                : [file @checkch@.sv]
                : `include "defines.sv"
                : `include "rvfi_channel.sv"
                : `include "rvfi_testbench.sv"
                : `include "rvfi_@check@_check.sv"
        """, **hargs)

        if check == pf+"cover":
            print_hfmt(sby_file, """
                    :
                    : [file cover_stmts.vh]
                    : @cover@
            """, **hargs)

        if "assume" in config:
            print("", file=sby_file)
            print("[file assume_stmts.vh]", file=sby_file)
            for pat, line in config["assume"]:
                enabled = True
                for p in pat:
                    if p.startswith("!"):
                        p = p[1:]
                        enabled = False
                    else:
                        enabled = True
                    if re.match(p, check):
                        enabled = not enabled
                        break
                if enabled:
                    print(line, file=sby_file)

for grp in groups:
    for i in range(nret):
        check_cons(grp, "reg", chanidx=i, start=0, depth=1)
        check_cons(grp, "pc_fwd", chanidx=i, start=0, depth=1)
        check_cons(grp, "pc_bwd", chanidx=i, start=0, depth=1)
        check_cons(grp, "liveness", chanidx=i, start=0, trig=1, depth=2)
        check_cons(grp, "unique", chanidx=i, start=0, trig=1, depth=2)
        check_cons(grp, "causal", chanidx=i, start=0, depth=1)
        check_cons(grp, "ill", chanidx=i, depth=0)

    check_cons(grp, "hang", start=0, depth=1)
    check_cons(grp, "cover", start=0, depth=1)

    for csr in sorted(csrs):
        for chanidx in range(nret):
            check_cons(grp, csr, chanidx, start=0, depth=1, csr_mode=True)

# ------------------------------ Makefile ------------------------------

def checks_key(check):
    if "sort" in config:
        for index, line in enumerate(config["sort"].split("\n")):
            if re.fullmatch(line.strip(), check):
                return "%04d-%s" % (index, check)
    if check.startswith("insn_"):
        return "9999-%s" % check
    return "9998-%s" % check

with open("%s/makefile" % cfgname, "w") as mkfile:
    print("all:", end="", file=mkfile)

    checks = list(sorted(consistency_checks | instruction_checks, key=checks_key))

    for check in checks:
        print(" %s" % check, end="", file=mkfile)
    print(file=mkfile)

    for check in checks:
        print("%s: %s/status" % (check, check), file=mkfile)
        print("%s/status:" % check, file=mkfile)
        print("\t%s %s.sby" % (sbycmd, check), file=mkfile)
        print(".PHONY: %s" % check, file=mkfile)

print("Generated %d checks." % (len(consistency_checks) + len(instruction_checks)))
