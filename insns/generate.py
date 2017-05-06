#!/usr/bin/env python3

current_isa = []
isa_database = dict()
defaults_cache = None

def header(f, insn):
    global isa_database
    for isa in current_isa:
        if isa not in isa_database:
            isa_database[isa] = set()
        isa_database[isa].add(insn)

    global defaults_cache
    defaults_cache = dict()

    print("// DO NOT EDIT -- auto-generated from generate.py", file=f)
    print("", file=f)
    print("module rvfi_insn_%s (" % insn, file=f)

    print("  input                                rvfi_valid,", file=f)
    print("  input [                32   - 1 : 0] rvfi_insn,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,", file=f)

    print("", file=f)
    print("  output                                spec_valid,", file=f)
    print("  output                                spec_trap,", file=f)
    print("  output [                       4 : 0] spec_rs1_addr,", file=f)
    print("  output [                       4 : 0] spec_rs2_addr,", file=f)
    print("  output [                       4 : 0] spec_rd_addr,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_rd_wdata,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_pc_wdata,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr,", file=f)
    print("  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask,", file=f)
    print("  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata", file=f)

    print(");", file=f)

    defaults_cache["spec_valid"] = "0"
    defaults_cache["spec_rs1_addr"] = "0"
    defaults_cache["spec_rs2_addr"] = "0"
    defaults_cache["spec_rd_addr"] = "0"
    defaults_cache["spec_rd_wdata"] = "0"
    defaults_cache["spec_pc_wdata"] = "0"
    defaults_cache["spec_trap"] = "0"
    defaults_cache["spec_mem_addr"] = "0"
    defaults_cache["spec_mem_rmask"] = "0"
    defaults_cache["spec_mem_wmask"] = "0"
    defaults_cache["spec_mem_wdata"] = "0"

def assign(f, sig, val):
    print("  assign %s = %s;" % (sig, val), file=f)

    if sig in defaults_cache:
        del defaults_cache[sig]

def footer(f):
    def default_assign(sig):
        if sig in defaults_cache:
            print("  assign %s = %s;" % (sig, defaults_cache[sig]), file=f)

    if len(defaults_cache) != 0:
        print("", file=f)
        print("  // default assignments", file=f)

        default_assign("spec_valid")
        default_assign("spec_rs1_addr")
        default_assign("spec_rs2_addr")
        default_assign("spec_rd_addr")
        default_assign("spec_rd_wdata")
        default_assign("spec_pc_wdata")
        default_assign("spec_trap")
        default_assign("spec_mem_addr")
        default_assign("spec_mem_rmask")
        default_assign("spec_mem_wmask")
        default_assign("spec_mem_wdata")

    print("endmodule", file=f)

def format_r(f):
    print("", file=f)
    print("  // R-type instruction format", file=f)
    print("  wire [6:0] insn_funct7 = rvfi_insn[31:25];", file=f)
    print("  wire [4:0] insn_rs2    = rvfi_insn[24:20];", file=f)
    print("  wire [4:0] insn_rs1    = rvfi_insn[19:15];", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[14:12];", file=f)
    print("  wire [4:0] insn_rd     = rvfi_insn[11: 7];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];", file=f)

def format_i(f):
    print("", file=f)
    print("  // I-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed(rvfi_insn[31:20]);", file=f)
    print("  wire [4:0] insn_rs1    = rvfi_insn[19:15];", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[14:12];", file=f)
    print("  wire [4:0] insn_rd     = rvfi_insn[11: 7];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];", file=f)

def format_i_shift(f):
    print("", file=f)
    print("  // I-type instruction format (shift variation)", file=f)
    print("  wire [6:0] insn_funct6 = rvfi_insn[31:26];", file=f)
    print("  wire [5:0] insn_shamt  = rvfi_insn[25:20];", file=f)
    print("  wire [4:0] insn_rs1    = rvfi_insn[19:15];", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[14:12];", file=f)
    print("  wire [4:0] insn_rd     = rvfi_insn[11: 7];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];", file=f)

def format_s(f):
    print("", file=f)
    print("  // S-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31:25], rvfi_insn[11:7]});", file=f)
    print("  wire [4:0] insn_rs2    = rvfi_insn[24:20];", file=f)
    print("  wire [4:0] insn_rs1    = rvfi_insn[19:15];", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[14:12];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];", file=f)

def format_sb(f):
    print("", file=f)
    print("  // SB-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31], rvfi_insn[7], rvfi_insn[30:25], rvfi_insn[11:8], 1'b0});", file=f)
    print("  wire [4:0] insn_rs2    = rvfi_insn[24:20];", file=f)
    print("  wire [4:0] insn_rs1    = rvfi_insn[19:15];", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[14:12];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];", file=f)

def format_u(f):
    print("", file=f)
    print("  // U-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31:12], 12'b0});", file=f)
    print("  wire [4:0] insn_rd     = rvfi_insn[11:7];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[ 6:0];", file=f)

def format_uj(f):
    print("", file=f)
    print("  // UJ-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31], rvfi_insn[19:12], rvfi_insn[20], rvfi_insn[30:21], 1'b0});", file=f)
    print("  wire [4:0] insn_rd     = rvfi_insn[11:7];", file=f)
    print("  wire [6:0] insn_opcode = rvfi_insn[6:0];", file=f)

def format_cr(f):
    print("", file=f)
    print("  // CI-type instruction format", file=f)
    print("  wire [3:0] insn_funct4 = rvfi_insn[15:12];", file=f)
    print("  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];", file=f)
    print("  wire [4:0] insn_rs2 = rvfi_insn[6:2];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci(f):
    print("", file=f)
    print("  // CI-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[6:2]});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_sp(f):
    print("", file=f)
    print("  // CI-type instruction format (SP variation)", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[4:3], rvfi_insn[5], rvfi_insn[2], rvfi_insn[6], 4'b0});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_lui(f):
    print("", file=f)
    print("  // CI-type instruction format (LUI variation)", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[6:2], 12'b0});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_sri(f):
    print("", file=f)
    print("  // CI-type instruction format (SRI variation)", file=f)
    print("  wire [5:0] insn_shamt = {rvfi_insn[12], rvfi_insn[6:2]};", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [1:0] insn_funct2 = rvfi_insn[11:10];", file=f)
    print("  wire [4:0] insn_rs1_rd = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_sli(f):
    print("", file=f)
    print("  // CI-type instruction format (SLI variation)", file=f)
    print("  wire [5:0] insn_shamt = {rvfi_insn[12], rvfi_insn[6:2]};", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_andi(f):
    print("", file=f)
    print("  // CI-type instruction format (ANDI variation)", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[6:2]});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [1:0] insn_funct2 = rvfi_insn[11:10];", file=f)
    print("  wire [4:0] insn_rs1_rd = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ci_lsp(f, numbytes):
    print("", file=f)
    if numbytes == 4:
        print("  // CI-type instruction format (LSP variation, 32 bit version)", file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[3:2], rvfi_insn[12], rvfi_insn[6:4], 2'b00};", file=f)
    else:
        assert False
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rd = rvfi_insn[11:7];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_cl(f, numbytes):
    print("", file=f)
    if numbytes == 4:
        print("  // CL-type instruction format (32 bit version)", file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[5], rvfi_insn[12:10], rvfi_insn[6], 2'b00};", file=f)
    else:
        assert False
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1 = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [4:0] insn_rd = {1'b1, rvfi_insn[4:2]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_css(f, numbytes):
    print("", file=f)
    if numbytes == 4:
        print("  // CSS-type instruction format (32 bit version)", file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[8:7], rvfi_insn[12:9], 2'b00};", file=f)
    else:
        assert False
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs2 = rvfi_insn[6:2];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_cs(f, numbytes):
    print("", file=f)
    if numbytes == 4:
        print("  // CS-type instruction format (32 bit version)", file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[5], rvfi_insn[12:10], rvfi_insn[6], 2'b00};", file=f)
    else:
        assert False
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1 = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [4:0] insn_rs2 = {1'b1, rvfi_insn[4:2]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_cs_alu(f):
    print("", file=f)
    print("  // CS-type instruction format (ALU version)", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[5], rvfi_insn[12:10], rvfi_insn[6], 2'b00};", file=f)
    print("  wire [5:0] insn_funct6 = rvfi_insn[15:10];", file=f)
    print("  wire [1:0] insn_funct2 = rvfi_insn[6:5];", file=f)
    print("  wire [4:0] insn_rs1_rd = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [4:0] insn_rs2 = {1'b1, rvfi_insn[4:2]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_ciw(f):
    print("", file=f)
    print("  // CIW-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = {rvfi_insn[10:7], rvfi_insn[12:11], rvfi_insn[5], rvfi_insn[6], 2'b00};", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rd = {1'b1, rvfi_insn[4:2]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_cb(f):
    print("", file=f)
    print("  // CB-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[6:5], rvfi_insn[2], rvfi_insn[11:10], rvfi_insn[4:3], 1'b0});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [4:0] insn_rs1 = {1'b1, rvfi_insn[9:7]};", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def format_cj(f):
    print("", file=f)
    print("  // CJ-type instruction format", file=f)
    print("  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[12], rvfi_insn[8], rvfi_insn[10], rvfi_insn[9],", file=f)
    print("      rvfi_insn[6], rvfi_insn[7], rvfi_insn[2], rvfi_insn[11], rvfi_insn[5], rvfi_insn[4], rvfi_insn[3], 1'b0});", file=f)
    print("  wire [2:0] insn_funct3 = rvfi_insn[15:13];", file=f)
    print("  wire [1:0] insn_opcode = rvfi_insn[1:0];", file=f)

def insn_lui(insn = "lui"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_u(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_opcode == 7'b 0110111")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? insn_imm : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")

        footer(f)

def insn_auipc(insn = "auipc"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_u(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_opcode == 7'b 0010111")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? rvfi_pc_rdata + insn_imm : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")

        footer(f)

def insn_jal(insn = "jal"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_uj(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_pc_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_opcode == 7'b 1101111")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? rvfi_pc_rdata + 4 : 0")
        assign(f, "spec_pc_wdata", "next_pc")
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        assign(f, "spec_trap", "next_pc[0] != 0")
        print("`else", file=f)
        assign(f, "spec_trap", "next_pc[1:0] != 0")
        print("`endif", file=f)

        footer(f)

def insn_jalr(insn = "jalr"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 1100111")
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? rvfi_pc_rdata + 4 : 0")
        assign(f, "spec_pc_wdata", "next_pc")
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        assign(f, "spec_trap", "next_pc[0] != 0")
        print("`else", file=f)
        assign(f, "spec_trap", "next_pc[1:0] != 0")
        print("`endif", file=f)

        footer(f)

def insn_b(insn, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_sb(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire cond = %s;" % expr, file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = cond ? rvfi_pc_rdata + insn_imm : rvfi_pc_rdata + 4;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 1100011" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_pc_wdata", "next_pc")
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        assign(f, "spec_trap", "next_pc[0] != 0")
        print("`else", file=f)
        assign(f, "spec_trap", "next_pc[1:0] != 0")
        print("`endif", file=f)

        footer(f)

def insn_l(insn, funct3, numbytes, signext):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        print("  wire [%d:0] result = rvfi_mem_rdata >> (8*(addr-spec_mem_addr));" % (8*numbytes-1), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0000011" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_rmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        if signext:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? $signed(result) : 0")
        else:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_s(insn, funct3, numbytes):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_s(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0100011" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_wmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        assign(f, "spec_mem_wdata", "rvfi_rs2_rdata << (8*(addr-spec_mem_addr))")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_imm(insn, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")

        footer(f)

def insn_shimm(insn, funct6, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i_shift(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct6 == 6'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011 && (!insn_shamt[5] || `RISCV_FORMAL_XLEN == 64)" % (funct6, funct3))
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")

        footer(f)

def insn_alu(insn, funct7, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_r(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct7 == 7'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0110011" % (funct7, funct3))
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 4")

        footer(f)

def insn_c_addi4spn(insn="c_addi4spn"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ciw(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 2'b 00 && insn_imm")
        assign(f, "spec_rs1_addr", "2")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_l(insn, funct3, numbytes, signext):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cl(f, numbytes)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        print("  wire [%d:0] result = rvfi_mem_rdata >> (8*(addr-spec_mem_addr));" % (8*numbytes-1), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 00" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_rmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        if signext:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? $signed(result) : 0")
        else:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_c_s(insn, funct3, numbytes):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cs(f, numbytes)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 00" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_wmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        assign(f, "spec_mem_wdata", "rvfi_rs2_rdata << (8*(addr-spec_mem_addr))")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_c_nop(insn="c_nop"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 2'b 01 && !insn_rs1_rd && !insn_imm")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_addi(insn="c_addi"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 2'b 01 && insn_rs1_rd && insn_imm")
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_jal(insn, funct3, link):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cj(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_pc_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 01" % (funct3))
        if link:
            assign(f, "spec_rd_addr", "5'd 1")
            assign(f, "spec_rd_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_pc_wdata", "next_pc")

        footer(f)

def insn_c_li(insn="c_li"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 010 && insn_opcode == 2'b 01 && insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_addi16sp(insn="c_addi16sp"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_sp(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 011 && insn_opcode == 2'b 01 && insn_rs1_rd == 5'd 2 && insn_imm")
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_lui(insn="c_lui"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_lui(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 011 && insn_opcode == 2'b 01 && insn_rs1_rd != 5'd 0 && insn_rs1_rd != 5'd 2 && insn_imm")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_sri(insn, funct2, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_sri(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 100 && insn_funct2 == 2'b %s && insn_opcode == 2'b 01 && insn_shamt && (!insn_shamt[5] || `RISCV_FORMAL_XLEN == 64)" % funct2)
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_andi(insn="c_andi"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_andi(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs1_rdata & insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 100 && insn_funct2 == 2'b 10 && insn_opcode == 2'b 01 && insn_imm")
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_alu(insn, funct6, funct2, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cs_alu(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct6 == 6'b %s && insn_funct2 == 2'b %s && insn_opcode == 2'b 01" % (funct6, funct2))
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_b(insn, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cb(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire cond = %s;" % expr, file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = cond ? rvfi_pc_rdata + insn_imm : rvfi_pc_rdata + 2;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 01" % funct3)
        assign(f, "spec_rs1_addr", "insn_rs1")
        assign(f, "spec_pc_wdata", "next_pc")
        assign(f, "spec_trap", "next_pc[0] != 0")

        footer(f)

def insn_c_sli(insn, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_sli(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 2'b 10 && insn_shamt && (!insn_shamt[5] || `RISCV_FORMAL_XLEN == 64)")
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

def insn_c_lsp(insn, funct3, numbytes, signext):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_ci_lsp(f, numbytes)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        print("  wire [%d:0] result = rvfi_mem_rdata >> (8*(addr-spec_mem_addr));" % (8*numbytes-1), file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 10" % funct3)
        assign(f, "spec_rs1_addr", "2")
        assign(f, "spec_rd_addr", "insn_rd")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_rmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        if signext:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? $signed(result) : 0")
        else:
            assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_c_ssp(insn, funct3, numbytes):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_css(f, numbytes)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 2'b 10" % funct3)
        assign(f, "spec_rs1_addr", "2")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_mem_addr", "addr & ~(`RISCV_FORMAL_XLEN/8-1)")
        assign(f, "spec_mem_wmask", "((1 << %d)-1) << (addr-spec_mem_addr)" % numbytes)
        assign(f, "spec_mem_wdata", "rvfi_rs2_rdata << (8*(addr-spec_mem_addr))")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_trap", "(addr & (%d-1)) != 0" % numbytes)

        footer(f)

def insn_c_jalr(insn, funct4, link):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cr(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_rs1_rdata;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct4 == 4'b %s && insn_rs1_rd && !insn_rs2 && insn_opcode == 2'b 10" % funct4)
        assign(f, "spec_rs1_addr", "insn_rs1_rd")
        if link:
            assign(f, "spec_rd_addr", "5'd 1")
            assign(f, "spec_rd_wdata", "rvfi_pc_rdata + 2")
        assign(f, "spec_pc_wdata", "next_pc")
        assign(f, "spec_trap", "next_pc[0] != 0")

        footer(f)

def insn_c_mvadd(insn, funct4, add):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_cr(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        if add:
            print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs1_rdata + rvfi_rs2_rdata;", file=f)
        else:
            print("  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_rs2_rdata;", file=f)
        assign(f, "spec_valid", "rvfi_valid && insn_funct4 == 4'b %s && insn_rs1_rd && insn_rs2 && insn_opcode == 2'b 10" % funct4)
        if add:
            assign(f, "spec_rs1_addr", "insn_rs1_rd")
        assign(f, "spec_rs2_addr", "insn_rs2")
        assign(f, "spec_rd_addr", "insn_rs1_rd")
        assign(f, "spec_rd_wdata", "spec_rd_addr ? result : 0")
        assign(f, "spec_pc_wdata", "rvfi_pc_rdata + 2")

        footer(f)

## Base Integer ISA (I)

current_isa = ["rv32i"]

insn_lui()
insn_auipc()
insn_jal()
insn_jalr()

insn_b("beq",  "000", "rvfi_rs1_rdata == rvfi_rs2_rdata")
insn_b("bne",  "001", "rvfi_rs1_rdata != rvfi_rs2_rdata")
insn_b("blt",  "100", "$signed(rvfi_rs1_rdata) < $signed(rvfi_rs2_rdata)")
insn_b("bge",  "101", "$signed(rvfi_rs1_rdata) >= $signed(rvfi_rs2_rdata)")
insn_b("bltu", "110", "rvfi_rs1_rdata < rvfi_rs2_rdata")
insn_b("bgeu", "111", "rvfi_rs1_rdata >= rvfi_rs2_rdata")

insn_l("lb",  "000", 1, True)
insn_l("lh",  "001", 2, True)
insn_l("lw",  "010", 4, True)
insn_l("lbu", "100", 1, False)
insn_l("lhu", "101", 2, False)

insn_s("sb",  "000", 1)
insn_s("sh",  "001", 2)
insn_s("sw",  "010", 4)

insn_imm("addi",  "000", "rvfi_rs1_rdata + insn_imm")
insn_imm("slti",  "010", "$signed(rvfi_rs1_rdata) < $signed(insn_imm)")
insn_imm("sltiu", "011", "rvfi_rs1_rdata < insn_imm")
insn_imm("xori",  "100", "rvfi_rs1_rdata ^ insn_imm")
insn_imm("ori",   "110", "rvfi_rs1_rdata | insn_imm")
insn_imm("andi",  "111", "rvfi_rs1_rdata & insn_imm")

insn_shimm("slli", "000000", "001", "rvfi_rs1_rdata << insn_shamt")
insn_shimm("srli", "000000", "101", "rvfi_rs1_rdata >> insn_shamt")
insn_shimm("srai", "010000", "101", "$signed(rvfi_rs1_rdata) >>> insn_shamt")

insn_alu("add",  "0000000", "000", "rvfi_rs1_rdata + rvfi_rs2_rdata")
insn_alu("sub",  "0100000", "000", "rvfi_rs1_rdata - rvfi_rs2_rdata")
insn_alu("sll",  "0000000", "001", "rvfi_rs1_rdata << rvfi_rs2_rdata[4:0]")
insn_alu("slt",  "0000000", "010", "$signed(rvfi_rs1_rdata) < $signed(rvfi_rs2_rdata)")
insn_alu("sltu", "0000000", "011", "rvfi_rs1_rdata < rvfi_rs2_rdata")
insn_alu("xor",  "0000000", "100", "rvfi_rs1_rdata ^ rvfi_rs2_rdata")
insn_alu("srl",  "0000000", "101", "rvfi_rs1_rdata >> rvfi_rs2_rdata[4:0]")
insn_alu("sra",  "0100000", "101", "$signed(rvfi_rs1_rdata) >>> rvfi_rs2_rdata[4:0]")
insn_alu("or",   "0000000", "110", "rvfi_rs1_rdata | rvfi_rs2_rdata")
insn_alu("and",  "0000000", "111", "rvfi_rs1_rdata & rvfi_rs2_rdata")

## Compressed Integer ISA (IC)

current_isa = ["rv32ic"]

insn_c_addi4spn()
insn_c_l("c_lw", "010", 4, True)
insn_c_s("c_sw", "110", 4)
insn_c_nop()
insn_c_addi()
insn_c_jal("c_jal", "001", True)
insn_c_li()
insn_c_addi16sp()
insn_c_lui()
insn_c_sri("c_srli", "00", "rvfi_rs1_rdata >> insn_shamt")
insn_c_sri("c_srai", "01", "$signed(rvfi_rs1_rdata) >>> insn_shamt")
insn_c_andi()
insn_c_alu("c_sub", "100011", "00", "rvfi_rs1_rdata - rvfi_rs2_rdata")
insn_c_alu("c_xor", "100011", "01", "rvfi_rs1_rdata ^ rvfi_rs2_rdata")
insn_c_alu("c_or",  "100011", "10", "rvfi_rs1_rdata | rvfi_rs2_rdata")
insn_c_alu("c_and", "100011", "11", "rvfi_rs1_rdata & rvfi_rs2_rdata")
insn_c_jal("c_j", "101", False)
insn_c_b("c_beqz", "110", "rvfi_rs1_rdata == 0")
insn_c_b("c_bnez", "111", "rvfi_rs1_rdata != 0")
insn_c_sli("c_slli", "rvfi_rs1_rdata << insn_shamt")
insn_c_lsp("c_lwsp", "010", 4, True)
insn_c_jalr("c_jr", "1000", False)
insn_c_mvadd("c_mv", "1000", False)
insn_c_jalr("c_jalr", "1001", True)
insn_c_mvadd("c_add", "1001", True)
insn_c_ssp("c_swsp", "110", 4)

## ISA Propagate

for insn in isa_database["rv32i"]:
    isa_database["rv32ic"].add(insn)

## ISA Listings

for isa, insns in isa_database.items():
    with open("isa_%s.txt" % isa, "w") as f:
        for insn in sorted(insns):
            print(insn, file=f)

