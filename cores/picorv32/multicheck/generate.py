#!/usr/bin/env python3

import os

depth = 15
warmup = True

insn_list = list()

insn_rvfi = {
    "valid": 1,
    "insn": 32,
    "pc_rdata": 32,
    "rs1_rdata": 32,
    "rs2_rdata": 32,
    "mem_rdata": 32
}

insn_spec = {
    "valid": 1,
    "trap": 1,
    "rs1_addr": 5,
    "rs2_addr": 5,
    "rd_addr": 5,
    "rd_wdata": 32,
    "pc_wdata": 32,
    "mem_addr": 32,
    "mem_rmask": 4,
    "mem_wmask": 4,
    "mem_wdata": 32
}

with open("../../../insns/isa_rv32i.txt", "r") as f:
    for line in f:
        insn_list.append(line.strip())

print("Generating HDL snippets.")

with open("models.vh", "w") as f:
    for insn in insn_list:
        print("(* keep *) wire enable_%s = $anyseq;" % insn, file=f)
        for port, width in insn_spec.items():
            print("(* keep *) wire [%d:0] insn_%s_%s;" % (width-1, insn, port), file=f)
        print("rvfi_insn_%s insn_%s (" % (insn, insn), file=f)
        for port in insn_rvfi.keys():
            if port == "valid":
                print("  .rvfi_%s(rvfi_%s && enable_%s)," % (port, port, insn), file=f)
            else:
                print("  .rvfi_%s(rvfi_%s)," % (port, port), file=f)
        for port in insn_spec.keys():
            print("  .spec_%s(insn_%s_%s)," % (port, insn, port), file=f)
        print(");", file=f)

    for port in insn_spec.keys():
        print("assign spec_%s =" % port, file=f)
        for insn in insn_list:
            print("  insn_%s_valid ? insn_%s_%s :" % (insn, insn, port), file=f)
        print("  0;", file=f)

with open("insns.vh", "w") as f:
    for insn in insn_list:
        print("`include \"../../../insns/insn_%s.v\"" % insn, file=f)

print("Running Yosys.")

os.system("yosys -v2 -l testbench.yslog -p 'read_verilog -formal testbench.sv; prep -top testbench -nordff; write_smt2 testbench.smt2'")

print("Generating SMT2 files.")

for mode in ["single_%s" % insn for insn in insn_list] + ["serial", "parallel"]:
    with open("test_%s.smt2" % mode, "w") as f:
        print("(set-logic QF_AUFBV)", file=f)

        with open("testbench.smt2", "r") as tb:
            for line in tb: print(line, end="", file=f)

        for step in range(depth):
            print("(declare-fun s%d () testbench_s)" % step, file=f)
            if step == 0:
                print("(assert (and (testbench_h s%d) (testbench_u s%d) (testbench_is s%d) (testbench_i s%d)))" % (step, step, step, step), file=f)
            else:
                print("(assert (and (testbench_h s%d) (testbench_u s%d) (not (testbench_is s%d)) (testbench_t s%d s%d)))" % (step, step, step, step-1, step), file=f)

            if step != depth-1:
                for insn in insn_list:
                    print("(assert (not (|testbench_n enable_%s| s%d)))" % (insn, step), file=f)
                if warmup:
                    print("(check-sat)", file=f)

            else:
                if mode == "parallel":
                    for insn in insn_list:
                        print("(assert (|testbench_n enable_%s| s%d))" % (insn, step), file=f)
                    print("(assert (not (testbench_a s%d)))" % step, file=f)
                    print("(echo \"         %s\")" % mode, file=f)
                    print("(check-sat)", file=f)

                elif mode == "serial":
                    for insn in insn_list:
                        print("(push 1)", file=f)
                        for en_insn in insn_list:
                            if insn == en_insn:
                                print("(assert (|testbench_n enable_%s| s%d))" % (en_insn, step), file=f)
                            else:
                                print("(assert (not (|testbench_n enable_%s| s%d)))" % (en_insn, step), file=f)
                        print("(assert (not (testbench_a s%d)))" % step, file=f)
                        print("(echo \"         serial_%s\")" % insn, file=f)
                        print("(check-sat)", file=f)
                        print("(pop 1)", file=f)

                elif mode.startswith("single_"):
                    for insn in insn_list:
                        if mode == ("single_%s" % insn):
                            print("(assert (|testbench_n enable_%s| s%d))" % (insn, step), file=f)
                        else:
                            print("(assert (not (|testbench_n enable_%s| s%d)))" % (insn, step), file=f)
                    print("(assert (not (testbench_a s%d)))" % step, file=f)
                    print("(echo \"         %s\")" % mode, file=f)
                    print("(check-sat)", file=f)

                else:
                    assert False

print("Generating runall.sh.")

with open("runall.sh", "w") as f:
    print("#!/bin/bash", file=f)
    print("rm -f results.txt", file=f)
    for mode in ["single_%s" % insn for insn in insn_list] + ["serial", "parallel"]:
        print("/usr/bin/time -o results.txt -a --quiet -f '%%M %%U %s' yices-smt2 --incremental test_%s.smt2" % (mode, mode), file=f)

