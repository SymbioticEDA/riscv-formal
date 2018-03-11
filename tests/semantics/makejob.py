#!/usr/bin/env python3

import sys, glob, os

insn = sys.argv[1]
clash_files = glob.glob("riscv-semantics/src/verilog/Clash/rvspec/*.v")

with open("insn_%s.sby" % insn, "w") as f:
    print("[options]", file=f)
    print("mode bmc", file=f)
    print("depth 1", file=f)
    print("", file=f)

    print("[engines]", file=f)
    print("smtbmc boolector", file=f)
    print("", file=f)

    print("[script]", file=f)
    print("read_verilog -sv defines.vh", file=f)
    print("read_verilog -sv rvfi_macros.vh", file=f)
    print("read_verilog -sv top.sv", file=f)
    print("read_verilog -sv insn_%s.v" % insn, file=f)
    for fn in clash_files:
        print("read_verilog %s" % os.path.basename(fn), file=f)
    print("prep -nordff -top top", file=f)
    print("flatten rvspec", file=f)
    print("hierarchy", file=f)
    print("opt -fast", file=f)

    print("[file defines.vh]", file=f)
    print("`define RISCV_FORMAL", file=f)
    print("`define RISCV_FORMAL_XLEN 32", file=f)
    print("`define RISCV_FORMAL_ILEN 32", file=f)
    print("`define RISCV_FORMAL_INSN_MODEL rvfi_insn_%s" % insn, file=f)
    print("`define RISCV_FORMAL_ALIGNED_MEM", file=f)
    # print("`define RISCV_FORMAL_COMPRESSED", file=f)
    print("", file=f)

    print("[files]", file=f)
    print("top.sv", file=f)
    print("../../checks/rvfi_macros.vh", file=f)
    print("../../insns/insn_%s.v" % insn, file=f)
    for fn in clash_files:
        print(fn, file=f)
