#!/usr/bin/env python3

import os

isa = "rv32ic"
compressed = True
xlen = 32

with open("../../insns/isa_%s.txt" % isa, "r") as f:
    insns = f.read().split()

if False:
    # for testing purposes we use this insns only
    insns = ["add", "addi", "c_add", "c_addi"]

# there are open questions regarding c_li, c_lui, and c_addi16sp
# details: https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/mr3H6S6IIts

if "c_li" in insns: insns.remove("c_li")
if "c_lui" in insns: insns.remove("c_lui")
if "c_addi16sp" in insns: insns.remove("c_addi16sp")

# the spike models for the following instructions utilize spike
# macros that have not been modelled in this environment yet:
#
# c_jal c_jalr
# c_lw c_lwsp
# c_sw c_swsp
# jal jalr
# lb lbu lh lhu lw
# sb sh sw

with open("makefile", "w") as makefile:
    print("all::", file=makefile)

    print("makefile: generate.py", file=makefile)
    print("\tpython3 generate.py", file=makefile)

    print("riscv-isa-sim:", file=makefile)
    print("\trm -rf riscv-isa-sim.part", file=makefile)
    print("\tgit clone https://github.com/riscv/riscv-isa-sim.git riscv-isa-sim.part", file=makefile)
    print("\tmv riscv-isa-sim.part riscv-isa-sim", file=makefile)

    for insn in insns:
        with open("test_%s.v" % insn, "w") as f:
            print("// DO NOT EDIT -- auto-generated from generate.py", file=f)
            print("`define RISCV_FORMAL_XLEN %d" % xlen, file=f)
            if compressed: print("`define RISCV_FORMAL_COMPRESSED", file=f)
            print("`include \"../../insns/insn_%s.v\"" % insn, file=f)

        with open("test_%s.cc" % insn, "w") as f:
            print("// DO NOT EDIT -- auto-generated from generate.py", file=f)
            print("#define xlen %d" % xlen, file=f)
            print("#include <stdio.h>", file=f)
            print("#include <assert.h>", file=f)
            print("#include \"test_%s.h\"" % insn, file=f)
            print("#include \"common.h\"", file=f)
            print("#include \"riscv-isa-sim/riscv/encoding.h\"", file=f)
            print("void test_%s(state_t pre_state, insn_t insn)" % insn, file=f)
            print("{", file=f)
            print("  const reg_t &pc = pre_state.pc;", file=f)
            print("  state_t post_state = pre_state;", file=f)
            print("  rvfi_insn_%s_state_t model;" % insn, file=f)
            print("  bool valid = (insn.bits() & MASK_%s) == MATCH_%s;" % (insn.upper(), insn.upper()), file=f)
            print("  model.rvfi_valid.value_0_0 = 1;", file=f)
            print("  model.rvfi_insn.value_31_0 = insn.bits();", file=f)
            print("  rvfi_insn_%s_eval(&model);" % insn, file=f)
            print("#include \"riscv-isa-sim/riscv/insns/%s.h\"" % insn, file=f)
            print("  printf(\"insn = 0x%08x\", int(model.rvfi_insn.value_31_0));", file=f)
            print("  assert(valid == model.spec_valid.value_0_0);", file=f)
            # FIXME: Add additional checks beyond insn matching
            print("}", file=f)

        print("all:: test_%s.ok" % insn, file=makefile)

        print("test_%s.ok: test_%s.h common.h riscv-isa-sim" % (insn, insn), file=makefile)
        print("\tcbmc --trace --no-built-in-assertions --function test_%s test_%s.cc | tee test_%s.cbmc_out" % (insn, insn, insn), file=makefile)
        print("\tgrep 'VERIFICATION SUCCESSFUL' test_%s.cbmc_out" % insn, file=makefile)
        print("\tmv test_%s.cbmc_out test_%s.ok" % (insn, insn), file=makefile)

        print("test_%s.h: test_%s.v ../../insns/insn_%s.v makefile" % (insn, insn, insn), file=makefile)
        print(("\tyosys -ql test_%s.yslog -p 'synth -top rvfi_insn_%s; " +
                "write_simplec -i64 test_%s.h' test_%s.v") % (insn, insn, insn, insn), file=makefile)

        print("clean::", file=makefile)
        print("\trm -f test_%s.ok test_%s.cc test_%s.v test_%s.h test_%s.yslog" % (insn, insn, insn, insn, insn), file=makefile)

    print("mrproper: clean", file=makefile)
    print("\trm -rf test_*.cbmc_out riscv-isa-sim makefile", file=makefile)

