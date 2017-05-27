#!/usr/bin/env python3

import getopt, sys

isa = "rv32i"
prefix = None
channels = 1
xlen = None
aligned = False
compressed = False

def usage():
    print("""

Usage: %s [options] > outfile.v

  -i <isa>
      RISC-V ISA (default: rv32i)

  -p <prefix>
      use <prefix> as prefix for generated verilog modules
      default: riscv_formal_monitor_<isa>

  -c <number_of_rvfi_channels>
      number of RVFI channels (default: 1)

  -a
      create monitor for core with aligned memory access

""" % sys.argv[0])
    sys.exit(1)

try:
    opts, args = getopt.getopt(sys.argv[1:], "i:p:c:a")
except:
    usage()

for o, a in opts:
    if o == "-i":
        isa = a
    elif o == "-p":
        prefix = a
    elif o == "-c":
        channels = int(a)
    elif o == "-a":
        aligned = True
    else:
        usage()

if len(args) != 0:
    usage()

if prefix is None:
    prefix = "riscv_formal_monitor_%s" % isa

if isa.startswith("rv32"):
    xlen = 32
elif isa.startswith("rv64"):
    xlen = 64
else:
    usage()

if "c" in isa:
    compressed = True

print("// DO NOT EDIT -- auto-generated from generate.py");
print()

print("module %s (" % prefix);
print("  input clock,")
print("  input reset,")
print("  input [%d:0] rvfi_valid," % (channels-1))
print("  input [%d:0] rvfi_order," % (channels*8-1))
print("  input [%d:0] rvfi_insn," % (channels*32-1))
print("  input [%d:0] rvfi_trap," % (channels-1))
print("  input [%d:0] rvfi_rs1_addr," % (channels*5-1))
print("  input [%d:0] rvfi_rs2_addr," % (channels*5-1))
print("  input [%d:0] rvfi_rs1_rdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_rs2_rdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_rd_addr," % (channels*5-1))
print("  input [%d:0] rvfi_rd_wdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_pc_rdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_pc_wdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_mem_addr," % (channels*xlen-1))
print("  input [%d:0] rvfi_mem_rmask," % (channels*xlen//8-1))
print("  input [%d:0] rvfi_mem_wmask," % (channels*xlen//8-1))
print("  input [%d:0] rvfi_mem_rdata," % (channels*xlen-1))
print("  input [%d:0] rvfi_mem_wdata" % (channels*xlen-1))
print(");")

for chidx in range(channels):
    print("  wire ch%d_rvfi_valid = rvfi_valid[%d];" % (chidx, chidx));
    print("  wire [7:0] ch%d_rvfi_order = rvfi_order[%d:%d];" % (chidx, 8*chidx+7, 8*chidx));
    print("  wire [31:0] ch%d_rvfi_insn = rvfi_insn[%d:%d];" % (chidx, 32*chidx+31, 32*chidx));
    print("  wire ch%d_rvfi_trap = rvfi_trap[%d];" % (chidx, chidx));
    print("  wire [4:0] ch%d_rvfi_rs1_addr = rvfi_rs1_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx));
    print("  wire [4:0] ch%d_rvfi_rs2_addr = rvfi_rs2_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx));
    print("  wire [%d:0] ch%d_rvfi_rs1_rdata = rvfi_rs1_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_rs2_rdata = rvfi_rs2_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [4:0] ch%d_rvfi_rd_addr = rvfi_rd_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx));
    print("  wire [%d:0] ch%d_rvfi_rd_wdata = rvfi_rd_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_pc_rdata = rvfi_pc_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_pc_wdata = rvfi_pc_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_mem_addr = rvfi_mem_addr[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_mem_rmask = rvfi_mem_rmask[%d:%d];" % (xlen//8-1, chidx, xlen//8*chidx+xlen//8-1, xlen//8*chidx));
    print("  wire [%d:0] ch%d_rvfi_mem_wmask = rvfi_mem_wmask[%d:%d];" % (xlen//8-1, chidx, xlen//8*chidx+xlen//8-1, xlen//8*chidx));
    print("  wire [%d:0] ch%d_rvfi_mem_rdata = rvfi_mem_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print("  wire [%d:0] ch%d_rvfi_mem_wdata = rvfi_mem_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx));
    print()

    print("  wire ch%d_spec_valid;" % (chidx));
    print("  wire ch%d_spec_trap;" % (chidx));
    print("  wire [4:0] ch%d_spec_rs1_addr;" % (chidx));
    print("  wire [4:0] ch%d_spec_rs2_addr;" % (chidx));
    print("  wire [4:0] ch%d_spec_rd_addr;" % (chidx));
    print("  wire [%d:0] ch%d_spec_rd_wdata;" % (xlen-1, chidx));
    print("  wire [%d:0] ch%d_spec_pc_wdata;" % (xlen-1, chidx));
    print("  wire [%d:0] ch%d_spec_mem_addr;" % (xlen-1, chidx));
    print("  wire [%d:0] ch%d_spec_mem_rmask;" % (xlen//8-1, chidx));
    print("  wire [%d:0] ch%d_spec_mem_wmask;" % (xlen//8-1, chidx));
    print("  wire [%d:0] ch%d_spec_mem_wdata;" % (xlen-1, chidx));
    print()

    print("  %s_isa_spec ch%d_isa_spec (" % (prefix, chidx))
    for p in """rvfi_valid rvfi_insn rvfi_pc_rdata rvfi_rs1_rdata rvfi_rs2_rdata rvfi_mem_rdata
                spec_valid spec_trap spec_rs1_addr spec_rs2_addr spec_rd_addr spec_rd_wdata
                spec_pc_wdata spec_mem_addr spec_mem_rmask spec_mem_wmask spec_mem_wdata""".split():
        print("    .%s(ch%d_%s)%s" % (p, chidx, p, "," if p != "spec_mem_wdata" else ""))
    print("  );")
    print()

    print("  reg ch%d_error;" % (chidx))
    print()

    print("  task ch%d_print_error; begin" % (chidx))
    print("    $display(\"-------- RVFI Monitor INSN Error in Channel %d: %%m --------\");" % (chidx))
    for p in """rvfi_valid rvfi_order rvfi_insn rvfi_trap rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata
                rvfi_mem_addr rvfi_mem_rmask rvfi_mem_wmask rvfi_mem_rdata rvfi_mem_wdata
                spec_valid spec_trap spec_rs1_addr spec_rs2_addr spec_rd_addr spec_rd_wdata
                spec_pc_wdata spec_mem_addr spec_mem_rmask spec_mem_wmask spec_mem_wdata""".split():
        print("    $display(\"%s = %%x\", ch%d_%s);" % (p, chidx, p))
    print("    ch%d_error <= 1;" % (chidx))
    print("  end endtask")
    print()

    print("  always @(posedge clock) begin")
    print("    ch%d_error <= 0;" % (chidx))
    print("    if (!reset && ch%d_spec_valid) begin" % (chidx))

    print("      if (ch%d_rvfi_trap != ch%d_spec_trap) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in trap.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_rs1_addr != ch%d_spec_rs1_addr && ch%d_spec_rs1_addr != 0) begin" % (chidx, chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in rs1_addr.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_rs2_addr != ch%d_spec_rs2_addr && ch%d_spec_rs2_addr != 0) begin" % (chidx, chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in rs2_addr.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_rd_addr != ch%d_spec_rd_addr) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in rd_addr.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_rd_wdata != ch%d_spec_rd_wdata) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in rd_wdata.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_pc_wdata != ch%d_spec_pc_wdata) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in pc_wdata.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_mem_addr != ch%d_spec_mem_addr) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in mem_addr.\");" % (chidx))
    print("      end")
    print("      if (ch%d_rvfi_mem_wmask != ch%d_spec_mem_wmask) begin" % (chidx, chidx))
    print("        ch%d_print_error; $display(\"Error details: mismatch in mem_wmask.\");" % (chidx))
    print("      end")

    for i in range(xlen//8):
        print("      if (!ch%d_rvfi_mem_rmask[%d] && ch%d_spec_mem_rmask[%d]) begin" % (chidx, i, chidx, i))
        print("        ch%d_print_error; $display(\"Error details: mismatch in mem_rmask[%d].\");" % (chidx, i))
        print("      end")
        print("      if (ch%d_rvfi_mem_wmask[%d] && ch%d_rvfi_mem_wdata[%d:%d] != ch%d_spec_mem_wdata[%d:%d]) begin" % (chidx, i, chidx, 8*i+7, 8*i, chidx, 8*i+7, 8*i))
        print("        ch%d_print_error; $display(\"Error details: mismatch in mem_wdata[%d:%d].\");" % (chidx, 8*i+7, 8*i))
        print("      end")

    print("    end")
    print("  end")
    print()

print("  // FIXME: Add consistency checks for PC and registers.")
print("endmodule")

replace_db = list()
replace_db.append((" rvfi_isa_%s " % isa, " %s_isa_spec " % prefix))
replace_db.append(("`RISCV_FORMAL_XLEN", str(xlen)))


insn_list = list()
with open("../insns/isa_%s.txt" % isa) as f:
    for insn in f:
        insn = insn.strip()
        insn_list.append(insn)
        replace_db.append((" rvfi_insn_%s " % insn, " %s_insn_%s " % (prefix, insn)))

def print_rewrite_file(filename):
    with open(filename) as f:
        flag_compressed_ifdef = False
        flag_compressed_ifndef = False
        flag_aligned_ifdef = False
        flag_aligned_ifndef = False

        for line in f:
            if line.startswith("`ifdef RISCV_FORMAL_COMPRESSED"):
                flag_compressed_ifdef = True
                flag_compressed_ifndef = False
                continue

            if line.startswith("`ifndef RISCV_FORMAL_COMPRESSED"):
                flag_compressed_ifdef = False
                flag_compressed_ifndef = True
                continue

            if line.startswith("`ifdef RISCV_FORMAL_ALIGNED_MEM"):
                flag_aligned_ifdef = True
                flag_aligned_ifndef = False
                continue

            if line.startswith("`ifndef RISCV_FORMAL_ALIGNED_MEM"):
                flag_aligned_ifdef = False
                flag_aligned_ifndef = True
                continue

            if line.startswith("`else"):
                flag_compressed_ifdef, flag_compressed_ifndef = flag_compressed_ifndef, flag_compressed_ifdef
                flag_aligned_ifdef, flag_aligned_ifndef = flag_aligned_ifndef, flag_aligned_ifdef
                continue

            if line.startswith("`endif"):
                flag_compressed_ifdef = False
                flag_compressed_ifndef = False
                flag_aligned_ifdef = False
                flag_aligned_ifndef = False
                continue

            if flag_compressed_ifdef and not compressed:
                continue

            if flag_compressed_ifndef and compressed:
                continue

            if flag_aligned_ifdef and not aligned:
                continue

            if flag_aligned_ifndef and aligned:
                continue

            for a, b in replace_db:
                line = line.replace(a, b)

            print(line, end="")

print_rewrite_file("../insns/isa_%s.v" % isa)

for insn in insn_list:
    print_rewrite_file("../insns/insn_%s.v" % insn)

