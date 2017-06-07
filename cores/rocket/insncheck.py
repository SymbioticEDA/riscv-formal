#!/usr/bin/env python3

import os, shutil, re

basedir = "%s/../.." % os.getcwd()
insn_bmc_depth = 50
use_aiger = False
sbycmd = "sby"

shutil.rmtree("insncheck", ignore_errors=True)
os.mkdir("insncheck")

def print_hfmt(f, text, **kwargs):
    for line in text.split("\n"):
        match = re.match(r"^\s*: ?(.*)", line)
        if match:
            line = re.sub(r"@([a-zA-Z0-9_]+)@",
                    lambda match: str(kwargs[match.group(1)]),
                    match.group(1))
            print(line, file=f)

with open("../../insns/isa_rv32i.txt") as isa_file:
    for insn in isa_file:
        insn = insn.strip()

        with open("insncheck/insn_%s.sby" % insn, "w") as sby_file:
            if use_aiger:
                engine = "abc bmc3"
                ilang_file = "rocket-chip-gates.il"
            else:
                engine = "smtbmc yices"
                ilang_file = "rocket-chip.il"

            print_hfmt(sby_file, """
                    : [options]
                    : mode bmc
                    : depth @depth_plus_5@
                    :
                    : [engines]
                    : @engine@
                    :
                    : [script]
                    : verilog_defines -D RISCV_FORMAL
                    : verilog_defines -D RISCV_FORMAL_NRET=1
                    : verilog_defines -D RISCV_FORMAL_XLEN=32
                    : verilog_defines -D RISCV_FORMAL_ILEN=32
                    : verilog_defines -D RISCV_FORMAL_BMC_DEPTH=@depth@
                    : verilog_defines -D RISCV_FORMAL_INSN_MODEL=rvfi_insn_@insn@
                    : verilog_defines -D RISCV_FORMAL_CHANNEL_IDX=0
                    : read_verilog -sv @basedir@/checks/rvfi_macros.vh
                    : read_verilog -sv @basedir@/cores/rocket/wrapper.sv
                    : read_verilog -sv @basedir@/cores/rocket/insncheck.sv
                    : read_verilog -sv @basedir@/checks/rvfi_insn_check.sv
                    : read_verilog -sv @basedir@/insns/insn_@insn@.v
                    : read_ilang @basedir@/cores/rocket/@ilang_file@
                    : prep -top testbench
            """,
                    depth_plus_5=(insn_bmc_depth + 5),
                    depth=insn_bmc_depth,
                    insn=insn,
                    engine=engine,
                    ilang_file=ilang_file,
                    basedir=basedir)

with open("insncheck/makefile", "w") as mkfile:
    print("all:", end="", file=mkfile)

    with open("../../insns/isa_rv32i.txt") as isa_file:
        for insn in isa_file:
            print(" insn_%s/PASS" % insn.strip(), end="", file=mkfile)
    print(file=mkfile)

    with open("../../insns/isa_rv32i.txt") as isa_file:
        for insn in isa_file:
            print("insn_%s/PASS:" % insn.strip(), file=mkfile)
            print("\t%s insn_%s.sby" % (sbycmd, insn.strip()), file=mkfile)

