#!/usr/bin/env python3

import os

isa = "rv32ic"

check_match = True
check_pc = True
check_rd = True
check_regs = True
check_mem = True

compressed = "c" in isa
xlen = 32 if "32" in isa else 64

with open("../../insns/isa_%s.txt" % isa, "r") as f:
    insns = f.read().split()

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
            print("// DO NOT EDIT -- auto-generated from riscv-formal/tests/spike/generate.py", file=f)
            print("`define RISCV_FORMAL_XLEN %d" % xlen, file=f)
            print("`define RISCV_FORMAL_ILEN 32", file=f)
            if compressed: print("`define RISCV_FORMAL_COMPRESSED", file=f)
            print("`include \"../../insns/insn_%s.v\"" % insn, file=f)

        with open("test_%s.cc" % insn, "w") as f:
            print("// DO NOT EDIT -- auto-generated from riscv-formal/tests/spike/generate.py", file=f)
            print("#define xlen %d" % xlen, file=f)
            print("#define value_xlen value_%d_0" % (xlen-1), file=f)
            print("#include <stdio.h>", file=f)
            print("#include <assert.h>", file=f)
            print("#include \"test_%s.h\"" % insn, file=f)
            print("#include \"common.h\"", file=f)
            print("#include \"riscv-isa-sim/riscv/encoding.h\"", file=f)
            print("void test_%s(mmu_t mmu, state_t pre_state, insn_t insn)" % insn, file=f)
            print("{", file=f)
            print("  mmu.optype = 0;", file=f)
            print("  pre_state.pc = zext_xlen(pre_state.pc) & ~(reg_t)%d;" % (1 if compressed else 3), file=f)
            print("  pre_state.XPR[0] = 0;", file=f)
            for i in range(1, 32):
                print("  pre_state.XPR[%d] = sext_xlen(pre_state.XPR[%d]);" % (i, i), file=f)
            print("  insn.b = sext32(insn.b);", file=f)
            print("  const reg_t &pc = pre_state.pc;", file=f)
            print("  reg_t npc = pc + insn.length();", file=f)
            print("  state_t post_state = pre_state;", file=f)
            print("  post_state.pc = npc;", file=f)
            print("  rvfi_insn_%s_state_t model = { };" % insn, file=f)
            print("  bool valid = (insn.bits() & MASK_%s) == MATCH_%s;" % (insn.upper(), insn.upper()), file=f)
            print("  if (((insn.bits() & 3) != 3) && ((insn.bits() >> 16) != 0)) valid = false;", file=f)
            print("  model.rvfi_valid.value_0_0 = 1;", file=f)
            print("  model.rvfi_insn.value_31_0 = insn.bits();", file=f)
            print("  model.rvfi_pc_rdata.value_xlen = pre_state.pc;", file=f)
            print("  rvfi_insn_%s_init(&model);" % insn, file=f)
            print("  model.rvfi_rs1_rdata.value_xlen = pre_state.XPR[model.spec_rs1_addr.value_4_0];", file=f)
            print("  model.rvfi_rs2_rdata.value_xlen = pre_state.XPR[model.spec_rs2_addr.value_4_0];", file=f)
            print("  model.rvfi_mem_rdata.value_xlen = mmu.rdata;", file=f)
            print("  rvfi_insn_%s_eval(&model);" % insn, file=f)
            if insn == "c_lui":
                print("if (insn.rvc_rd() == 2) valid = false;", file=f)
                print("#include \"riscv-isa-sim/riscv/insns/c_lui.h\"", file=f)
            elif insn == "c_addi16sp":
                print("if (insn.rvc_rd() != 2) valid = false;", file=f)
                print("#include \"riscv-isa-sim/riscv/insns/c_lui.h\"", file=f)
            else:
                print("#include \"riscv-isa-sim/riscv/insns/%s.h\"" % insn, file=f)
            print("  if ((post_state.pc & %d) != 0) valid = false;" % (1 if compressed else 3), file=f)
            print("  printf(\"int main() {\\n\"", file=f)
            print("         \"  insn_t insn(%u);\\n\"", file=f)
            print("         \"  state_t state = { };\\n\"", file=f)
            print("         \"  mmu_t mmu = { };\\n\"", file=f)
            print("         \"  state.pc = %u;\\n\"", file=f)
            print("         \"  state.XPR[%u] = %d;\\n\"", file=f)
            print("         \"  state.XPR[%u] = %d;\\n\"", file=f)
            print("         \"  mmu.rdata = %u;\\n\"", file=f)
            print("         \"  test_%s(mmu, state, insn);\\n\"" % insn, file=f)
            print("         \"  return 0;\\n\"", file=f)
            print("         \"}\\n\", int(insn.bits()), int(pre_state.pc),", file=f)
            print("         int(model.spec_rs1_addr.value_4_0), int(pre_state.XPR[model.spec_rs1_addr.value_4_0]),", file=f)
            print("         int(model.spec_rs2_addr.value_4_0), int(pre_state.XPR[model.spec_rs2_addr.value_4_0]),", file=f)
            print("         int(mmu.rdata));", file=f)
            print("  // printf(\"valid: spike=%d riscv-formal=%d\\n\", int(valid), int(model.spec_valid.value_0_0));", file=f)
            print("  // printf(\"rs1_addr: riscv-formal=%u\\n\", int(model.spec_rs1_addr.value_4_0));", file=f)
            print("  // printf(\"rs2_addr: riscv-formal=%u\\n\", int(model.spec_rs2_addr.value_4_0));", file=f)
            print("  // printf(\"rd_addr: riscv-formal=%u\\n\", int(model.spec_rd_addr.value_4_0));", file=f)
            print("  // printf(\"rs1_rdata: spike=0x%016llx\\n\", (long long)pre_state.XPR[model.spec_rs1_addr.value_4_0]);", file=f)
            print("  // printf(\"rs2_rdata: spike=0x%016llx\\n\", (long long)pre_state.XPR[model.spec_rs2_addr.value_4_0]);", file=f)
            print("  // printf(\"rd_wdata: spike=0x%016llx riscv-formal=0x%016llx\\n\", (long long)post_state.XPR[model.spec_rd_addr.value_4_0], (long long)model.spec_rd_wdata.value_xlen);", file=f)
            if check_match:
                print("  assert(valid == model.spec_valid.value_0_0);", file=f)
            print("  if (valid) {", file=f)
            if check_pc:
                print("    assert(zext_xlen(post_state.pc) == model.spec_pc_wdata.value_xlen);", file=f)
            if check_rd:
                print("    assert(post_state.XPR[model.spec_rd_addr.value_4_0] == (reg_t)sext_xlen(model.spec_rd_wdata.value_xlen));", file=f)
            if check_regs:
                for i in range(0, 32):
                    print("    if (model.spec_rd_addr.value_4_0 != %d) assert(post_state.XPR[%d] == pre_state.XPR[%d]);" % (i, i, i), file=f)
            if check_mem:
                print("    int8_t model_mem_optype = 100;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  0 && model.spec_mem_wmask.value_3_0 ==  0) model_mem_optype =  0;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  1 && model.spec_mem_wmask.value_3_0 ==  0) model_mem_optype =  1;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  3 && model.spec_mem_wmask.value_3_0 ==  0) model_mem_optype =  2;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 == 15 && model.spec_mem_wmask.value_3_0 ==  0) model_mem_optype =  4;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  0 && model.spec_mem_wmask.value_3_0 ==  1) model_mem_optype = -1;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  0 && model.spec_mem_wmask.value_3_0 ==  3) model_mem_optype = -2;", file=f)
                print("    if (model.spec_mem_rmask.value_3_0 ==  0 && model.spec_mem_wmask.value_3_0 == 15) model_mem_optype = -4;", file=f)
                print("    // printf(\"mem_rmask: riscv-formal=%x\\n\", (int)model.spec_mem_rmask.value_3_0);", file=f)
                print("    // printf(\"mem_wmask: riscv-formal=%x\\n\", (int)model.spec_mem_wmask.value_3_0);", file=f)
                print("    // printf(\"mem_optype: spike=%d riscv-formal=%d\\n\", (int)mmu.optype, (int)model_mem_optype);", file=f)
                print("    // printf(\"mem_addr: spike=0x%016llx riscv-formal=0x%016llx\\n\", (long long)mmu.addr, (long long)sext_xlen(model.spec_mem_addr.value_xlen));", file=f)
                print("    // printf(\"mem_rdata: spike=0x%016llx riscv-formal=0x%016llx\\n\", (long long)mmu.rdata, (long long)zext_xlen(model.rvfi_mem_rdata.value_xlen));", file=f)
                print("    // printf(\"mem_wdata: spike=0x%016llx riscv-formal=0x%016llx\\n\", (long long)mmu.wdata, (long long)zext_xlen(model.spec_mem_wdata.value_xlen));", file=f)
                print("    assert(mmu.optype == model_mem_optype);", file=f)
                print("    if (model_mem_optype)", file=f)
                print("      assert(zext_xlen(mmu.addr) == zext_xlen(model.spec_mem_addr.value_xlen));", file=f)
                print("    if (model_mem_optype == -1)", file=f)
                print("      assert((mmu.wdata & 0xff) == (model.spec_mem_wdata.value_xlen & 0xff));", file=f)
                print("    if (model_mem_optype == -2)", file=f)
                print("      assert((mmu.wdata & 0xffff) == (model.spec_mem_wdata.value_xlen & 0xffff));", file=f)
                print("    if (model_mem_optype == -4)", file=f)
                print("      assert((mmu.wdata & 0xffffffff) == (model.spec_mem_wdata.value_xlen & 0xffffffff));", file=f)
                print("    if (model_mem_optype == -8)", file=f)
                print("      assert(mmu.wdata == model.spec_mem_wdata.value_xlen);", file=f)
            print("  }", file=f)
            print("}", file=f)

        print("all:: test_%s.ok" % insn, file=makefile)

        print("test_%s.ok: test_%s.h common.h riscv-isa-sim" % (insn, insn), file=makefile)
        print("\ttime cbmc --trace --stop-on-fail --no-built-in-assertions --function test_%s test_%s.cc | ts -s '%%H:%%M:%%S [%s]' | tee test_%s.cbmc_out" % (insn, insn, insn, insn), file=makefile)
        print("\tgrep 'VERIFICATION SUCCESSFUL' test_%s.cbmc_out" % insn, file=makefile)
        print("\tmv test_%s.cbmc_out test_%s.ok" % (insn, insn), file=makefile)

        print("test_%s.h: test_%s.v ../../insns/insn_%s.v makefile" % (insn, insn, insn), file=makefile)
        print(("\tyosys -ql test_%s.yslog -p 'synth -top rvfi_insn_%s; opt_clean -purge; " +
                "write_simplec -i64 test_%s.h' test_%s.v") % (insn, insn, insn, insn), file=makefile)

    print("clean:", file=makefile)
    print("\trm -f test_*.ok test_*.h test_*.yslog test_*.cbmc_out", file=makefile)

    print("mrproper: clean", file=makefile)
    print("\trm -rf test_*.cc test_*.v riscv-isa-sim makefile", file=makefile)

