#!/usr/bin/env python3

def handle_isa(isa):
    with open("../../insns/isa_%s.txt" % isa, "r") as f:
        insns = f.read().split()

    with open("isa_coverage_%s.v" % isa, "w") as f:
        print("// DO NOT EDIT -- auto-generated from riscv-formal/tests/coverage/generate.py", file=f)
        print("", file=f)

        print("`define ISA_COVERAGE_LEN_%s %d" % (isa.upper(), len(insns)), file=f)
        print("module isa_coverage_%s (input [31:0] insn, output [%d:0] valid);" % (isa, len(insns)-1), file=f)

        for index, insn in enumerate(sorted(insns)):
            print("  rvfi_insn_%s insn_%s (" % (insn, insn), file=f)
            print("    .rvfi_valid(1'b1),", file=f)
            print("    .rvfi_insn(insn),", file=f)
            print("    .rvfi_pc_rdata(32'h00000000),", file=f)
            print("    .rvfi_rs1_rdata(32'h00000000),", file=f)
            print("    .rvfi_rs2_rdata(32'h00000000),", file=f)
            print("    .rvfi_mem_rdata(32'h00000000),", file=f)
            print("    .spec_valid(valid[%d])" % index, file=f)
            print("  );", file=f)
            
        print("endmodule", file=f)

handle_isa("rv32i")
handle_isa("rv32ic")
handle_isa("rv64i")
handle_isa("rv64ic")
