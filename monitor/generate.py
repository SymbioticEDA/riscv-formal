#!/usr/bin/env python3

import getopt, sys

isa = "rv32i"
prefix = None
channels = 1
xlen = None
ilen = None
aligned = False
compressed = False
ignore_mem = False
use_assert = False
quiet_mode = False
verbose_mode = False
noconsistency = False

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

  -M
      do not check the mem_ RVFI signals in the monitor

  -C
      do not check consistency of xreg/pc reads and writes

  -A
      add assert(0) statements to the error handlers

  -Q
      do not generate $display() statements in error handlers

  -V
      create $display() statements for printing all insns
""" % sys.argv[0])
    sys.exit(1)

try:
    opts, args = getopt.getopt(sys.argv[1:], "i:p:c:aMCAQV")
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
    elif o == "-M":
        ignore_mem = True
    elif o == "-C":
        noconsistency = True
    elif o == "-A":
        use_assert = True
    elif o == "-Q":
        quiet_mode = True
    elif o == "-V":
        verbose_mode = True
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

if ilen is None:
    ilen = 32

if "c" in isa:
    compressed = True

print("// DO NOT EDIT -- auto-generated from riscv-formal/monitor/generate.py");
print()

print("module %s (" % prefix);
print("  input clock,")
print("  input reset,")
print("  input [%d:0] rvfi_valid," % (channels-1))
print("  input [%d:0] rvfi_order," % (channels*8-1))
print("  input [%d:0] rvfi_insn," % (channels*32-1))
print("  input [%d:0] rvfi_trap," % (channels-1))
print("  input [%d:0] rvfi_halt," % (channels-1))
print("  input [%d:0] rvfi_intr," % (channels-1))
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
print("  input [%d:0] rvfi_mem_wdata," % (channels*xlen-1))
print("  output reg [15:0] errcode")
print(");")

errcodes = list()

for chidx in range(channels):
    print("  wire ch%d_rvfi_valid = rvfi_valid[%d];" % (chidx, chidx));
    print("  wire [7:0] ch%d_rvfi_order = rvfi_order[%d:%d];" % (chidx, 8*chidx+7, 8*chidx));
    print("  wire [31:0] ch%d_rvfi_insn = rvfi_insn[%d:%d];" % (chidx, 32*chidx+31, 32*chidx));
    print("  wire ch%d_rvfi_trap = rvfi_trap[%d];" % (chidx, chidx));
    print("  wire ch%d_rvfi_halt = rvfi_halt[%d];" % (chidx, chidx));
    print("  wire ch%d_rvfi_intr = rvfi_intr[%d];" % (chidx, chidx));
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

    errcodes.append("ch%d_errcode" % (chidx))
    print("  reg [15:0] ch%d_errcode;" % (chidx))
    print()

    print("  task ch%d_handle_error;" % (chidx))
    print("    input [15:0] code;")
    print("    input [511:0] msg;")
    print("    begin")

    if not quiet_mode:
        print("      $display(\"-------- RVFI Monitor error %%0d in channel %d: %%m --------\", code);" % (chidx))
        print("      $display(\"Error message: %0s\", msg);")
        for p in """rvfi_valid rvfi_order rvfi_insn rvfi_trap rvfi_halt rvfi_intr
                    rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                    rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata
                    rvfi_mem_addr rvfi_mem_rmask rvfi_mem_wmask rvfi_mem_rdata rvfi_mem_wdata
                    spec_valid spec_trap spec_rs1_addr spec_rs2_addr spec_rd_addr spec_rd_wdata
                    spec_pc_wdata spec_mem_addr spec_mem_rmask spec_mem_wmask spec_mem_wdata""".split():
            print("      $display(\"%s = %%x\", ch%d_%s);" % (p, chidx, p))
    print("      ch%d_errcode <= code;" % (chidx))

    if use_assert:
        print("      assert(0);")

    print("    end")
    print("  endtask")
    print()

    print("  always @(posedge clock) begin")
    print("    ch%d_errcode <= 0;" % (chidx))
    print("    if (!reset && ch%d_spec_valid) begin" % (chidx))

    if verbose_mode:
        print("      $display(\"-------- RVFI Monitor insn in channel %d: %%m --------\");" % (chidx))
        for p in """rvfi_valid rvfi_order rvfi_insn rvfi_trap rvfi_halt rvfi_intr
                    rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                    rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata
                    rvfi_mem_addr rvfi_mem_rmask rvfi_mem_wmask rvfi_mem_rdata rvfi_mem_wdata""".split():
            print("      $display(\"%s = %%x\", ch%d_%s);" % (p, chidx, p))

    if not noconsistency:
        print("      if (ch%d_rvfi_order != 0) begin" % (chidx))
        print("        ch%d_handle_error(%d, \"monitor without reordering\");" % (chidx, 100*(1+chidx)))
        print("      end")

    print("      if (ch%d_rvfi_trap != ch%d_spec_trap) begin" % (chidx, chidx))
    print("        ch%d_handle_error(%d, \"mismatch in trap\");" % (chidx, 100*(1+chidx)+1))
    print("      end")

    print("      if (ch%d_rvfi_rs1_addr != ch%d_spec_rs1_addr && ch%d_spec_rs1_addr != 0) begin" % (chidx, chidx, chidx))
    print("        ch%d_handle_error(%d, \"mismatch in rs1_addr\");" % (chidx, 100*(1+chidx)+2))
    print("      end")
    print("      if (ch%d_rvfi_rs2_addr != ch%d_spec_rs2_addr && ch%d_spec_rs2_addr != 0) begin" % (chidx, chidx, chidx))
    print("        ch%d_handle_error(%d, \"mismatch in rs2_addr\");" % (chidx, 100*(1+chidx)+3))
    print("      end")
    print("      if (ch%d_rvfi_rd_addr != ch%d_spec_rd_addr) begin" % (chidx, chidx))
    print("        ch%d_handle_error(%d, \"mismatch in rd_addr\");" % (chidx, 100*(1+chidx)+4))
    print("      end")

    if ignore_mem:
        print("      if (ch%d_rvfi_rd_wdata != ch%d_spec_rd_wdata && !ch%d_spec_mem_rmask) begin" % (chidx, chidx, chidx))
        print("        ch%d_handle_error(%d, \"mismatch in rd_wdata\");" % (chidx, 100*(1+chidx)+5))
        print("      end")
    else:
        print("      if (ch%d_rvfi_rd_wdata != ch%d_spec_rd_wdata) begin" % (chidx, chidx))
        print("        ch%d_handle_error(%d, \"mismatch in rd_wdata\");" % (chidx, 100*(1+chidx)+5))
        print("      end")

    print("      if (ch%d_rvfi_pc_wdata != ch%d_spec_pc_wdata) begin" % (chidx, chidx))
    print("        ch%d_handle_error(%d, \"mismatch in pc_wdata\");" % (chidx, 100*(1+chidx)+6))
    print("      end")

    if not ignore_mem:
        print("      if (ch%d_rvfi_mem_addr != ch%d_spec_mem_addr) begin" % (chidx, chidx))
        print("        ch%d_handle_error(%d, \"mismatch in mem_addr\");" % (chidx, 100*(1+chidx)+7))
        print("      end")
        print("      if (ch%d_rvfi_mem_wmask != ch%d_spec_mem_wmask) begin" % (chidx, chidx))
        print("        ch%d_handle_error(%d, \"mismatch in mem_wmask\");" % (chidx, 100*(1+chidx)+8))
        print("      end")

        for i in range(xlen//8):
            print("      if (!ch%d_rvfi_mem_rmask[%d] && ch%d_spec_mem_rmask[%d]) begin" % (chidx, i, chidx, i))
            print("        ch%d_handle_error(%d, \"mismatch in mem_rmask[%d]\");" % (chidx, 100*(1+chidx)+10+i, i))
            print("      end")
            print("      if (ch%d_rvfi_mem_wmask[%d] && ch%d_rvfi_mem_wdata[%d:%d] != ch%d_spec_mem_wdata[%d:%d]) begin" % (chidx, i, chidx, 8*i+7, 8*i, chidx, 8*i+7, 8*i))
            print("        ch%d_handle_error(%d, \"mismatch in mem_wdata[%d:%d]\");" % (chidx, 100*(1+chidx)+20+i, 8*i+7, 8*i))
            print("      end")

    print("    end")
    print("  end")
    print()

if not noconsistency:
    print("  // FIXME: Add reordering")
    print()

    print("  reg [31:0] shadow_xregs_valid;")
    print("  reg [%d:0] shadow_xregs [0:31];" % (xlen-1))
    print("  reg shadow_pc_valid;")
    print("  reg [%d:0] shadow_pc;" % (xlen-1))
    print()

    for chidx in range(channels):
        print("  wire ro%d_rvfi_valid = ch%d_rvfi_valid;" % (chidx, chidx));
        print("  wire [7:0] ro%d_rvfi_order = ch%d_rvfi_order;" % (chidx, chidx));
        print("  wire [31:0] ro%d_rvfi_insn = ch%d_rvfi_insn;" % (chidx, chidx));
        print("  wire ro%d_rvfi_trap = ch%d_rvfi_trap;" % (chidx, chidx));
        print("  wire ro%d_rvfi_halt = ch%d_rvfi_halt;" % (chidx, chidx));
        print("  wire ro%d_rvfi_intr = ch%d_rvfi_intr;" % (chidx, chidx));
        print("  wire [4:0] ro%d_rvfi_rs1_addr = ch%d_rvfi_rs1_addr;" % (chidx, chidx));
        print("  wire [4:0] ro%d_rvfi_rs2_addr = ch%d_rvfi_rs2_addr;" % (chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_rs1_rdata = ch%d_rvfi_rs1_rdata;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_rs2_rdata = ch%d_rvfi_rs2_rdata;" % (xlen-1, chidx, chidx));
        print("  wire [4:0] ro%d_rvfi_rd_addr = ch%d_rvfi_rd_addr;" % (chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_rd_wdata = ch%d_rvfi_rd_wdata;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_pc_rdata = ch%d_rvfi_pc_rdata;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_pc_wdata = ch%d_rvfi_pc_wdata;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_mem_addr = ch%d_rvfi_mem_addr;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_mem_rmask = ch%d_rvfi_mem_rmask;" % (xlen//8-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_mem_wmask = ch%d_rvfi_mem_wmask;" % (xlen//8-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_mem_rdata = ch%d_rvfi_mem_rdata;" % (xlen-1, chidx, chidx));
        print("  wire [%d:0] ro%d_rvfi_mem_wdata = ch%d_rvfi_mem_wdata;" % (xlen-1, chidx, chidx));
        print()

        print("  reg shadow%d_pc_valid;" % (chidx))
        print("  reg shadow%d_rs1_valid;" % (chidx))
        print("  reg shadow%d_rs2_valid;" % (chidx))
        print("  reg [%d:0] shadow%d_pc_rdata;" % (xlen-1, chidx))
        print("  reg [%d:0] shadow%d_rs1_rdata;" % (xlen-1, chidx))
        print("  reg [%d:0] shadow%d_rs2_rdata;" % (xlen-1, chidx))
        print()

        errcodes.append("ro%d_errcode" % (chidx))
        print("  reg [15:0] ro%d_errcode;" % (chidx))
        print()

        print("  task ro%d_handle_error;" % (chidx))
        print("    input [15:0] code;")
        print("    input [511:0] msg;")
        print("    begin")

        if not quiet_mode:
            print("      $display(\"-------- RVFI Monitor error %%0d in reordered channel %d: %%m --------\", code);" % (chidx))
            print("      $display(\"Error message: %0s\", msg);")
            for p in """rvfi_valid rvfi_order rvfi_insn rvfi_trap rvfi_halt rvfi_intr
                        rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                        rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata
                        rvfi_mem_addr rvfi_mem_rmask rvfi_mem_wmask rvfi_mem_rdata rvfi_mem_wdata""".split():
                print("      $display(\"%s = %%x\", ro%d_%s);" % (p, chidx, p))
            for p in """pc_valid pc_rdata rs1_valid rs1_rdata rs2_valid rs2_rdata""".split():
                print("      $display(\"shadow_%s = %%x\", shadow%d_%s);" % (p, chidx, p))
        print("      ro%d_errcode <= code;" % (chidx))

        if use_assert:
            print("      assert(0);")

        print("    end")
        print("  endtask")
        print()

        print("  always @* begin")
        print("    shadow%d_pc_valid = shadow_pc_valid;" % (chidx))
        print("    shadow%d_pc_rdata = shadow_pc;" % (chidx))

        for i in range(chidx):
            print("    if (!reset && ro%d_rvfi_valid) begin" % (i))
            print("      shadow%d_pc_valid = 1;" % (chidx))
            print("      shadow%d_pc_rdata = ro%d_rvfi_pc_wdata;" % (chidx, i))
            print("    end")

        print("  end")
        print()

        for rs in ["rs1", "rs2"]:
            print("  always @* begin")
            print("    shadow%d_%s_valid = 0;" % (chidx, rs))
            print("    shadow%d_%s_rdata = 0;" % (chidx, rs))
            print("    if (!reset && ro%d_rvfi_valid) begin" % (chidx))
            print("      shadow%d_%s_valid = shadow_xregs_valid[ro%d_rvfi_%s_addr];" % (chidx, rs, chidx, rs))
            print("      shadow%d_%s_rdata = shadow_xregs[ro%d_rvfi_%s_addr];" % (chidx, rs, chidx, rs))

            for i in range(chidx):
                print("      if (ro%d_rvfi_valid && ro%d_rvfi_rd_addr == ro%d_rvfi_%s_addr) begin" % (i, i, chidx, rs))
                print("        shadow%d_%s_valid = 1;" % (chidx, rs))
                print("        shadow%d_%s_rdata = ro%d_rvfi_rd_wdata;" % (chidx, rs, i))
                print("      end")

            print("    end")
            print("  end")
            print()

    print("  always @(posedge clock) begin")

    for chidx in range(channels):
        print("    ro%d_errcode <= 0;" % chidx)

    print("    if (reset) begin")
    print("      shadow_xregs_valid <= 1;")
    print("      shadow_xregs[0] <= 0;")
    print("      shadow_pc_valid <= 0;")
    print("    end")

    for chidx in range(channels):
        print("    if (!reset && ro%d_rvfi_valid) begin" % (chidx))
        for rs in ["rs1", "rs2", "pc"]:
            print("      if (shadow%d_%s_valid && shadow%d_%s_rdata != ro%d_rvfi_%s_rdata) begin" % (chidx, rs, chidx, rs, chidx, rs))
            print("        ro%d_handle_error(%d, \"mismatch with shadow %s\");" % (chidx, 100*(1+chidx)+(31 if rs == "rs1" else 32), rs))
            print("      end")
        print("      shadow_xregs_valid[ro%d_rvfi_rd_addr] <= 1;" % (chidx))
        print("      shadow_xregs[ro%d_rvfi_rd_addr] <= ro%d_rvfi_rd_wdata;" % (chidx, chidx))
        print("      shadow_pc_valid <= 1;")
        print("      shadow_pc <= ro%d_rvfi_pc_wdata;" % (chidx))
        print("    end")

    print("  end")
    print()

print("  always @(posedge clock) begin")
print("    errcode <= 0;")
print("    if (!reset) begin")

for v in errcodes:
    print("      if (%s) errcode <= %s;" % (v, v))

print("    end")
print("  end")
print("endmodule")

replace_db = list()
replace_db.append((" rvfi_isa_%s " % isa, " %s_isa_spec " % prefix))
replace_db.append(("`RISCV_FORMAL_XLEN", str(xlen)))
replace_db.append(("`RISCV_FORMAL_ILEN", str(ilen)))


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

print()
print_rewrite_file("../insns/isa_%s.v" % isa)

for insn in insn_list:
    print()
    print_rewrite_file("../insns/insn_%s.v" % insn)

