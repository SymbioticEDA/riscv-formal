#!/usr/bin/env python3

import getopt, sys
from math import log2, ceil

isa = "rv32i"
prefix = None
channels = 1
robdepth = 256
xlen = None
ilen = None
aligned = False
compressed = False
ignore_mem = False
use_assert = False
quiet_mode = False
verbose_mode = False
noregscheck = False
nopccheck = False

def usage():
    print("""

Usage: %s [options] > outfile.v

  -i <isa>
      RISC-V ISA (default: rv32i)

  -p <prefix>
      use <prefix> as prefix for generated verilog modules
      default: riscv_formal_monitor_<isa>

  -c <int>
      number of RVFI channels (default: 1)

  -r <int>
      depth of reorder buffer (must be a power of two, default: 256)
      setting this option to 0 will disabling reordering

  -a
      create monitor for core with aligned memory access

  -M
      do not check the mem_ RVFI signals in the monitor

  -R
      do not check consistency of reg reads and writes

  -P
      do not check consistency of pc reads and writes

  -A
      add assert(0) statements to the error handlers

  -Q
      do not generate $display() statements in error handlers

  -V
      create $display() statements for printing all insns
""" % sys.argv[0])
    sys.exit(1)

try:
    opts, args = getopt.getopt(sys.argv[1:], "i:p:c:r:aMRPAQV")
except:
    usage()

for o, a in opts:
    if o == "-i":
        isa = a
    elif o == "-p":
        prefix = a
    elif o == "-c":
        channels = int(a)
    elif o == "-r":
        robdepth = int(a)
    elif o == "-a":
        aligned = True
    elif o == "-M":
        ignore_mem = True
    elif o == "-R":
        noregscheck = True
    elif o == "-P":
        nopccheck = True
    elif o == "-U":
        nocausality = True
    elif o == "-O":
        nocompleteness = True
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

print("// DO NOT EDIT -- auto-generated from riscv-formal/monitor/generate.py")
print("//")
print("// Command line options: %s" % " ".join(sys.argv[1:]))
print()

print("module %s (" % prefix)
print("  input clock,")
print("  input reset,")
print("  input [%d:0] rvfi_valid," % (channels-1))
print("  input [%d:0] rvfi_order," % (channels*64-1))
print("  input [%d:0] rvfi_insn," % (channels*32-1))
print("  input [%d:0] rvfi_trap," % (channels-1))
print("  input [%d:0] rvfi_halt," % (channels-1))
print("  input [%d:0] rvfi_intr," % (channels-1))
print("  input [%d:0] rvfi_mode," % (channels*2-1))
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
print("  input [%d:0] rvfi_mem_extamo," % (channels-1))
print("  output reg [15:0] errcode")
print(");")

errcodes = list()

for chidx in range(channels):
    print("  wire ch%d_rvfi_valid = rvfi_valid[%d];" % (chidx, chidx))
    print("  wire [63:0] ch%d_rvfi_order = rvfi_order[%d:%d];" % (chidx, 64*chidx+63, 64*chidx))
    print("  wire [31:0] ch%d_rvfi_insn = rvfi_insn[%d:%d];" % (chidx, 32*chidx+31, 32*chidx))
    print("  wire ch%d_rvfi_trap = rvfi_trap[%d];" % (chidx, chidx))
    print("  wire ch%d_rvfi_halt = rvfi_halt[%d];" % (chidx, chidx))
    print("  wire ch%d_rvfi_intr = rvfi_intr[%d];" % (chidx, chidx))
    print("  wire [4:0] ch%d_rvfi_rs1_addr = rvfi_rs1_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx))
    print("  wire [4:0] ch%d_rvfi_rs2_addr = rvfi_rs2_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx))
    print("  wire [%d:0] ch%d_rvfi_rs1_rdata = rvfi_rs1_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_rs2_rdata = rvfi_rs2_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [4:0] ch%d_rvfi_rd_addr = rvfi_rd_addr[%d:%d];" % (chidx, 5*chidx+4, 5*chidx))
    print("  wire [%d:0] ch%d_rvfi_rd_wdata = rvfi_rd_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_pc_rdata = rvfi_pc_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_pc_wdata = rvfi_pc_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_mem_addr = rvfi_mem_addr[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_mem_rmask = rvfi_mem_rmask[%d:%d];" % (xlen//8-1, chidx, xlen//8*chidx+xlen//8-1, xlen//8*chidx))
    print("  wire [%d:0] ch%d_rvfi_mem_wmask = rvfi_mem_wmask[%d:%d];" % (xlen//8-1, chidx, xlen//8*chidx+xlen//8-1, xlen//8*chidx))
    print("  wire [%d:0] ch%d_rvfi_mem_rdata = rvfi_mem_rdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire [%d:0] ch%d_rvfi_mem_wdata = rvfi_mem_wdata[%d:%d];" % (xlen-1, chidx, xlen*chidx+xlen-1, xlen*chidx))
    print("  wire ch%d_rvfi_mem_extamo = rvfi_mem_extamo[%d];" % (chidx, chidx))
    print()

    print("  wire ch%d_spec_valid;" % (chidx))
    print("  wire ch%d_spec_trap;" % (chidx))
    print("  wire [4:0] ch%d_spec_rs1_addr;" % (chidx))
    print("  wire [4:0] ch%d_spec_rs2_addr;" % (chidx))
    print("  wire [4:0] ch%d_spec_rd_addr;" % (chidx))
    print("  wire [%d:0] ch%d_spec_rd_wdata;" % (xlen-1, chidx))
    print("  wire [%d:0] ch%d_spec_pc_wdata;" % (xlen-1, chidx))
    print("  wire [%d:0] ch%d_spec_mem_addr;" % (xlen-1, chidx))
    print("  wire [%d:0] ch%d_spec_mem_rmask;" % (xlen//8-1, chidx))
    print("  wire [%d:0] ch%d_spec_mem_wmask;" % (xlen//8-1, chidx))
    print("  wire [%d:0] ch%d_spec_mem_wdata;" % (xlen-1, chidx))
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
        print("      $display(\"-------- RVFI Monitor error %%0d in channel %d: %%m at time %%0t --------\", code, $time);" % (chidx))
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
    print("    if (!reset && ch%d_rvfi_valid) begin" % (chidx))

    if verbose_mode:
        print("      $display(\"-------- RVFI Monitor insn in channel %d: %%m at time %%0t --------\", $time);" % (chidx))
        for p in """rvfi_valid rvfi_order rvfi_insn rvfi_trap rvfi_halt rvfi_intr
                    rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                    rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata
                    rvfi_mem_addr rvfi_mem_rmask rvfi_mem_wmask rvfi_mem_rdata rvfi_mem_wdata
                    spec_valid spec_trap""".split():
            print("      $display(\"%s = %%x\", ch%d_%s);" % (p, chidx, p))

    print("      if (ch%d_spec_valid) begin" % (chidx))

    print("        if (ch%d_rvfi_trap != ch%d_spec_trap) begin" % (chidx, chidx))
    print("          ch%d_handle_error(%d, \"mismatch in trap\");" % (chidx, 100*(1+chidx)+1))
    print("        end")

    print("        if (ch%d_rvfi_rs1_addr != ch%d_spec_rs1_addr && ch%d_spec_rs1_addr != 0) begin" % (chidx, chidx, chidx))
    print("          ch%d_handle_error(%d, \"mismatch in rs1_addr\");" % (chidx, 100*(1+chidx)+2))
    print("        end")
    print("        if (ch%d_rvfi_rs2_addr != ch%d_spec_rs2_addr && ch%d_spec_rs2_addr != 0) begin" % (chidx, chidx, chidx))
    print("          ch%d_handle_error(%d, \"mismatch in rs2_addr\");" % (chidx, 100*(1+chidx)+3))
    print("        end")
    print("        if (ch%d_rvfi_rd_addr != ch%d_spec_rd_addr) begin" % (chidx, chidx))
    print("          ch%d_handle_error(%d, \"mismatch in rd_addr\");" % (chidx, 100*(1+chidx)+4))
    print("        end")

    if ignore_mem:
        print("        if (ch%d_rvfi_rd_wdata != ch%d_spec_rd_wdata && !ch%d_spec_mem_rmask) begin" % (chidx, chidx, chidx))
        print("          ch%d_handle_error(%d, \"mismatch in rd_wdata\");" % (chidx, 100*(1+chidx)+5))
        print("        end")
    else:
        print("        if (ch%d_rvfi_rd_wdata != ch%d_spec_rd_wdata) begin" % (chidx, chidx))
        print("          ch%d_handle_error(%d, \"mismatch in rd_wdata\");" % (chidx, 100*(1+chidx)+5))
        print("        end")

    print("        if (ch%d_rvfi_pc_wdata != ch%d_spec_pc_wdata) begin" % (chidx, chidx))
    print("          ch%d_handle_error(%d, \"mismatch in pc_wdata\");" % (chidx, 100*(1+chidx)+6))
    print("        end")

    if not ignore_mem:
        print("        if (ch%d_rvfi_mem_wmask != ch%d_spec_mem_wmask) begin" % (chidx, chidx))
        print("          ch%d_handle_error(%d, \"mismatch in mem_wmask\");" % (chidx, 100*(1+chidx)+8))
        print("        end")

        for i in range(xlen//8):
            print("        if (!ch%d_rvfi_mem_rmask[%d] && ch%d_spec_mem_rmask[%d]) begin" % (chidx, i, chidx, i))
            print("          ch%d_handle_error(%d, \"mismatch in mem_rmask[%d]\");" % (chidx, 100*(1+chidx)+10+i, i))
            print("        end")
            print("        if (ch%d_rvfi_mem_wmask[%d] && ch%d_rvfi_mem_wdata[%d:%d] != ch%d_spec_mem_wdata[%d:%d]) begin" % (chidx, i, chidx, 8*i+7, 8*i, chidx, 8*i+7, 8*i))
            print("          ch%d_handle_error(%d, \"mismatch in mem_wdata[%d:%d]\");" % (chidx, 100*(1+chidx)+20+i, 8*i+7, 8*i))
            print("        end")

        print("        if (ch%d_rvfi_mem_addr != ch%d_spec_mem_addr && (ch%d_rvfi_mem_wmask || ch%d_rvfi_mem_rmask)) begin" % (chidx, chidx, chidx, chidx))
        print("          ch%d_handle_error(%d, \"mismatch in mem_addr\");" % (chidx, 100*(1+chidx)+7))
        print("        end")

    print("      end")
    print("    end")
    print("  end")
    print()

if not nopccheck or not noregscheck:
    for chidx in range(channels):
        rob_data_width = 3*5 + 5*xlen + 2
        print("  wire rob_i%d_valid;" % chidx)
        print("  wire [63:0] rob_i%d_order;" % chidx)
        print("  wire [%d:0] rob_i%d_data;" % (rob_data_width-1, chidx))
        print()
        print("  wire rob_o%d_valid;" % chidx)
        print("  wire [63:0] rob_o%d_order;" % chidx)
        print("  wire [%d:0] rob_o%d_data;" % (rob_data_width-1, chidx))
        print()
        print("  wire ro%d_rvfi_valid = rob_o%d_valid;" % (chidx, chidx))
        print("  assign rob_i%d_valid = ch%d_rvfi_valid;" % (chidx, chidx))
        print()
        print("  wire [63:0] ro%d_rvfi_order = rob_o%d_order;" % (chidx, chidx))
        print("  assign rob_i%d_order = ch%d_rvfi_order;" % (chidx, chidx))
        print()

        cursor = 0
        for n, w in [("rs1_addr", 5), ("rs2_addr", 5), ("rd_addr", 5), ("rs1_rdata", xlen), ("rs2_rdata", xlen),
                ("rd_wdata", xlen), ("pc_rdata", xlen), ("pc_wdata", xlen), ("intr", 1), ("trap", 1)]:
            print("  wire [%d:0] ro%d_rvfi_%s = rob_o%d_data[%d:%d];" % (w-1, chidx, n, chidx, cursor+w-1, cursor))
            print("  assign rob_i%d_data[%d:%d] = ch%d_rvfi_%s;" % (chidx, cursor+w-1, cursor, chidx, n))
            print()
            cursor += w

    errcodes.append("rob_errcode")
    print("  wire [15:0] rob_errcode;")
    print()

    print("  %s_rob rob (" % prefix)
    print("    .clock(clock),")
    print("    .reset(reset),")
    for chidx in range(channels):
        print("    .i%d_valid(rob_i%d_valid)," % (chidx, chidx))
        print("    .i%d_order(rob_i%d_order)," % (chidx, chidx))
        print("    .i%d_data(rob_i%d_data)," % (chidx, chidx))
        print("    .o%d_valid(rob_o%d_valid)," % (chidx, chidx))
        print("    .o%d_order(rob_o%d_order)," % (chidx, chidx))
        print("    .o%d_data(rob_o%d_data)," % (chidx, chidx))
    print("    .errcode(rob_errcode)")
    print("  );")
    print()

    if not quiet_mode or use_assert:
        print("  always @(posedge clock) begin")
        print("    if (!reset && rob_errcode) begin")
        if not quiet_mode:
            print("      $display(\"-------- RVFI Monitor ROB error %0d: %m at time %0t --------\", rob_errcode, $time);")
            print("      $display(\"No details on ROB errors available.\");")
        if use_assert:
            print("      assert(0);")
        print("    end")
        print("  end")
        print()

if not nopccheck:
    print("  reg shadow_pc_valid;")
    print("  reg shadow_pc_trap;")
    print("  reg [%d:0] shadow_pc;" % (xlen-1))
    print()

    for chidx in range(channels):
        print("  reg shadow%d_pc_valid;" % (chidx))
        print("  reg shadow%d_pc_trap;" % (chidx))
        print("  reg [%d:0] shadow%d_pc_rdata;" % (xlen-1, chidx))
        print()

        errcodes.append("ro%d_errcode_p" % (chidx))
        print("  reg [15:0] ro%d_errcode_p;" % (chidx))
        print()

        print("  task ro%d_handle_error_p;" % (chidx))
        print("    input [15:0] code;")
        print("    input [511:0] msg;")
        print("    begin")

        if not quiet_mode:
            print("      $display(\"-------- RVFI Monitor error %%0d in reordered channel %d: %%m at time %%0t --------\", code, $time);" % (chidx))
            print("      $display(\"Error message: %0s\", msg);")
            for p in """rvfi_valid rvfi_order rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                        rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata rvfi_intr rvfi_trap""".split():
                print("      $display(\"%s = %%x\", ro%d_%s);" % (p, chidx, p))
            for p in """pc_valid pc_rdata""".split():
                print("      $display(\"shadow_%s = %%x\", shadow%d_%s);" % (p, chidx, p))
        print("      ro%d_errcode_p <= code;" % (chidx))

        if use_assert:
            print("      assert(0);")

        print("    end")
        print("  endtask")
        print()

        print("  always @* begin")
        print("    shadow%d_pc_valid = shadow_pc_valid;" % (chidx))
        print("    shadow%d_pc_trap = shadow_pc_trap;" % (chidx))
        print("    shadow%d_pc_rdata = shadow_pc;" % (chidx))

        for i in range(chidx):
            print("    if (!reset && ro%d_rvfi_valid) begin" % (i))
            print("      shadow%d_pc_valid = !ro%d_rvfi_trap;" % (chidx, chidx))
            print("      shadow%d_pc_trap = ro%d_rvfi_trap;" % (chidx, chidx))
            print("      shadow%d_pc_rdata = ro%d_rvfi_pc_wdata;" % (chidx, i))
            print("    end")

        print("  end")
        print()

    print("  always @(posedge clock) begin")

    for chidx in range(channels):
        print("    ro%d_errcode_p <= 0;" % chidx)

    print("    if (reset) begin")
    print("      shadow_pc_valid <= 0;")
    print("      shadow_pc_trap <= 0;")
    print("    end")

    for chidx in range(channels):
        print("    if (!reset && ro%d_rvfi_valid) begin" % (chidx))
        print("      if (shadow%d_pc_valid && shadow%d_pc_rdata != ro%d_rvfi_pc_rdata && !ro%d_rvfi_intr) begin" % (chidx, chidx, chidx, chidx))
        print("        ro%d_handle_error_p(%d, \"mismatch with shadow pc\");" % (chidx, 100*(1+chidx)+30))
        print("      end")
        print("      if (shadow%d_pc_valid && shadow%d_pc_trap && !ro%d_rvfi_intr) begin" % (chidx, chidx, chidx))
        print("        ro%d_handle_error_p(%d, \"expected intr after trap\");" % (chidx, 100*(1+chidx)+33))
        print("      end")
        print("      shadow_pc_valid <= !ro%d_rvfi_trap;" % (chidx))
        print("      shadow_pc_trap <= ro%d_rvfi_trap;" % (chidx))
        print("      shadow_pc <= ro%d_rvfi_pc_wdata;" % (chidx))
        print("    end")

    print("  end")
    print()

if not noregscheck:
    print("  reg [31:0] shadow_xregs_valid;")
    print("  reg [%d:0] shadow_xregs [0:31];" % (xlen-1))
    print()

    for chidx in range(channels):
        print("  reg shadow%d_rs1_valid;" % (chidx))
        print("  reg shadow%d_rs2_valid;" % (chidx))
        print("  reg [%d:0] shadow%d_rs1_rdata;" % (xlen-1, chidx))
        print("  reg [%d:0] shadow%d_rs2_rdata;" % (xlen-1, chidx))
        print()

        errcodes.append("ro%d_errcode_r" % (chidx))
        print("  reg [15:0] ro%d_errcode_r;" % (chidx))
        print()

        print("  task ro%d_handle_error_r;" % (chidx))
        print("    input [15:0] code;")
        print("    input [511:0] msg;")
        print("    begin")

        if not quiet_mode:
            print("      $display(\"-------- RVFI Monitor error %%0d in reordered channel %d: %%m at time %%0t --------\", code, $time);" % (chidx))
            print("      $display(\"Error message: %0s\", msg);")
            for p in """rvfi_valid rvfi_order rvfi_rs1_addr rvfi_rs2_addr rvfi_rs1_rdata rvfi_rs2_rdata
                        rvfi_rd_addr rvfi_rd_wdata rvfi_pc_rdata rvfi_pc_wdata rvfi_intr rvfi_trap""".split():
                print("      $display(\"%s = %%x\", ro%d_%s);" % (p, chidx, p))
            for p in """rs1_valid rs1_rdata rs2_valid rs2_rdata""".split():
                print("      $display(\"shadow_%s = %%x\", shadow%d_%s);" % (p, chidx, p))
        print("      ro%d_errcode_r <= code;" % (chidx))

        if use_assert:
            print("      assert(0);")

        print("    end")
        print("  endtask")
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
        print("    ro%d_errcode_r <= 0;" % chidx)

    print("    if (reset) begin")
    print("      shadow_xregs_valid <= 1;")
    print("      shadow_xregs[0] <= 0;")
    print("    end")

    for chidx in range(channels):
        print("    if (!reset && ro%d_rvfi_valid) begin" % (chidx))
        for rs in ["rs1", "rs2"]:
            print("      if (shadow%d_%s_valid && shadow%d_%s_rdata != ro%d_rvfi_%s_rdata) begin" % (chidx, rs, chidx, rs, chidx, rs))
            print("        ro%d_handle_error_r(%d, \"mismatch with shadow %s\");" % (chidx, 100*(1+chidx)+(31 if rs == "rs1" else 32), rs))
            print("      end")
        print("      shadow_xregs_valid[ro%d_rvfi_rd_addr] <= 1;" % (chidx))
        print("      shadow_xregs[ro%d_rvfi_rd_addr] <= ro%d_rvfi_rd_wdata;" % (chidx, chidx))
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


if not nopccheck or not noregscheck:
    print()
    print("module %s_rob (" % prefix)
    print("  input clock,")
    print("  input reset,")
    for chidx in range(channels):
        print("    input i%d_valid," % (chidx))
        print("    input [63:0] i%d_order," % (chidx))
        print("    input [%d:0] i%d_data," % (rob_data_width-1, chidx))
        print("    output reg o%d_valid," % (chidx))
        print("    output reg [63:0] o%d_order," % (chidx))
        print("    output reg [%d:0] o%d_data," % (rob_data_width-1, chidx))
    if robdepth == 0:
        print("  output wire [15:0] errcode")
    else:
        print("  output reg [15:0] errcode")
    print(");")

    if robdepth == 0:
        for chidx in range(channels):
            print("  always @* o%d_valid = i%d_valid;" % (chidx, chidx))
            print("  always @* o%d_order = i%d_order;" % (chidx, chidx))
            print("  always @* o%d_data = i%d_data;" % (chidx, chidx))
        print("  assign errcode = 0;")

    else:
        orderbits = ceil(log2(robdepth))

        print("  reg [%d:0] buffer [0:%d];" % (64+rob_data_width-1, robdepth-1))
        print("  reg [%d:0] valid;" % (robdepth-1))
        print("  reg [63:0] cursor;")
        print("  reg continue_flag;")
        print()
        print("  always @(posedge clock) begin")
        for chidx in range(channels):
            print("    o%d_valid <= 0;" % (chidx))
        print("    errcode <= 0;")
        print("    continue_flag = 1;")
        print("    if (reset) begin")
        print("      valid <= 0;")
        print("      cursor = 0;")
        print("    end else begin")

        for chidx in range(channels):
            print("      if (i%d_valid) begin" % (chidx))
            print("        if (valid[i%d_order[%d:0]])" % (chidx, orderbits-1))
            print("          errcode <= 60000 + i%d_order[7:0];" % (chidx))
            print("        buffer[i%d_order[%d:0]] <= {i%d_data, i%d_order};" % (chidx, orderbits-1, chidx, chidx))
            print("        valid[i%d_order[%d:0]] <= 1;" % (chidx, orderbits-1))
            print("      end")

        for chidx in range(channels):
            print("      if (continue_flag && valid[cursor[%d:0]]) begin" % (orderbits-1))
            print("        if (buffer[cursor[%d:0]][63:0] != cursor)" % (orderbits-1))
            print("          errcode <= 61000 + cursor[7:0];")
            print("        o%d_valid <= 1;" % (chidx))
            print("        o%d_order <= buffer[cursor[%d:0]][63:0];" % (chidx, orderbits-1))
            print("        o%d_data <= buffer[cursor[%d:0]][%d:64];" % (chidx, orderbits-1, 64+rob_data_width-1))
            print("        valid[cursor[%d:0]] <= 0;" % (orderbits-1))
            print("        cursor = cursor + 1;")
            print("      end else begin")
            print("        continue_flag = 0;")
            print("      end")

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

expected_flags = {
    "RISCV_FORMAL_COMPRESSED": compressed,
    "RISCV_FORMAL_ALIGNED_MEM": aligned,
}

def print_rewrite_file(filename):
    with open(filename) as f:
        flag_stack = []
        flags = {}

        for line in f:
            if line.startswith("`ifdef "):
                flag_name = line.split()[1]
                assert flag_name not in flags, (filename, flag_name, flags)
                flag_stack.append(flag_name)
                flags[flag_name] = True
                continue

            if line.startswith("`ifndef "):
                flag_name = line.split()[1]
                assert flag_name not in flags
                flag_stack.append(flag_name)
                flags[flag_name] = False
                continue

            if line.startswith("`else"):
                flag_name = flag_stack[-1]
                flags[flag_name] = not flags[flag_name]
                continue

            if line.startswith("`endif"):
                flag_name = flag_stack.pop()
                del flags[flag_name]
                continue

            if any(expected_flags.get(name, False) != val for name, val in flags.items()):
                continue

            for a, b in replace_db:
                line = line.replace(a, b)

            print(line, end="")

print()
print_rewrite_file("../insns/isa_%s.v" % isa)

for insn in insn_list:
    print()
    print_rewrite_file("../insns/insn_%s.v" % insn)

