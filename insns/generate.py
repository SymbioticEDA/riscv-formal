#!/usr/bin/env python3

def header(f, insn):
    print("// DO NOT EDIT -- auto-generated from generate.py", file=f)
    print("", file=f)
    print("module rvfi_insn_%s (" % insn, file=f)

    print("  input                                rvfi_valid,", file=f)
    print("  input [                32   - 1 : 0] rvfi_insn,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,", file=f)
    print("  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,", file=f)

    print("", file=f)
    print("  output                                spec_valid,", file=f)
    print("  output [                       4 : 0] spec_rs1,", file=f)
    print("  output [                       4 : 0] spec_rs2,", file=f)
    print("  output [                       4 : 0] spec_rd,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_rd,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_pc,", file=f)
    print("  output                                spec_post_trap,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr,", file=f)
    print("  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask,", file=f)
    print("  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask,", file=f)
    print("  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata", file=f)

    print(");", file=f)

def footer(f):
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
    print("  wire [6:0] insn_funct7 = rvfi_insn[31:25];", file=f)
    print("  wire [4:0] insn_shamt  = rvfi_insn[24:20];", file=f)
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

def insn_lui(insn = "lui"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_u(f)

        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  assign spec_valid = rvfi_valid && insn_opcode == 7'b 0110111;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? insn_imm : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs1 = 0;", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_post_rd = 0;", file=f)
        print("  assign spec_post_trap = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_auipc(insn = "auipc"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_u(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  assign spec_valid = rvfi_valid && insn_opcode == 7'b 0010111;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? rvfi_pre_pc + insn_imm : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs1 = 0;", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_post_rd = 0;", file=f)
        print("  assign spec_post_pc = 0;", file=f)
        print("  assign spec_post_trap = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_jal(insn = "jal"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_uj(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_pre_pc + insn_imm;", file=f)
        print("  assign spec_valid = rvfi_valid && insn_opcode == 7'b 1101111;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? rvfi_pre_pc + 4 : 0;", file=f)
        print("  assign spec_post_pc = next_pc;", file=f)
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        print("  assign spec_post_trap = next_pc[0] != 0;", file=f)
        print("`else", file=f)
        print("  assign spec_post_trap = next_pc[1:0] != 0;", file=f)
        print("`endif", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs1 = 0;", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_jalr(insn = "jalr"):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_pre_rs1 + insn_imm;", file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 1100111;", file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? rvfi_pre_pc + 4 : 0;", file=f)
        print("  assign spec_post_pc = next_pc;", file=f)
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        print("  assign spec_post_trap = next_pc[0] != 0;", file=f)
        print("`else", file=f)
        print("  assign spec_post_trap = next_pc[1:0] != 0;", file=f)
        print("`endif", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_b(insn, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_sb(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire cond = %s;" % expr, file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = cond ? rvfi_pre_pc + insn_imm : rvfi_pre_pc + 4;", file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 1100011;" % funct3, file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rs2 = insn_rs2;", file=f)
        print("  assign spec_post_pc = next_pc;", file=f)
        print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
        print("  assign spec_post_trap = next_pc[0] != 0;", file=f)
        print("`else", file=f)
        print("  assign spec_post_trap = next_pc[1:0] != 0;", file=f)
        print("`endif", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rd = 0;", file=f)
        print("  assign spec_post_rd = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_l(insn, funct3, numbytes, signext):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_pre_rs1 + insn_imm;", file=f)
        print("  wire [%d:0] result = rvfi_mem_rdata >> (8*(addr-spec_mem_addr));" % (8*numbytes-1), file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0000011;" % funct3, file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);", file=f)
        print("  assign spec_mem_rmask = ((1 << %d)-1) << (addr-spec_mem_addr);" % numbytes, file=f)
        if signext:
            print("  assign spec_post_rd = spec_rd ? $signed(result) : 0;", file=f)
        else:
            print("  assign spec_post_rd = spec_rd ? result : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)
        print("  assign spec_post_trap = (addr & (%d-1)) != 0;" % numbytes, file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_s(insn, funct3, numbytes):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_s(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_pre_rs1 + insn_imm;", file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0100011;" % funct3, file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rs2 = insn_rs2;", file=f)
        print("  assign spec_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);", file=f)
        print("  assign spec_mem_wmask = ((1 << %d)-1) << (addr-spec_mem_addr);" % numbytes, file=f)
        print("  assign spec_mem_wdata = rvfi_pre_rs2 << (8*(addr-spec_mem_addr));", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)
        print("  assign spec_post_trap = (addr & (%d-1)) != 0;" % numbytes, file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rd = 0;", file=f)
        print("  assign spec_post_rd = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)

        footer(f)

def insn_imm(insn, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011;" % funct3, file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? result : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_post_trap = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_shimm(insn, funct7, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_i_shift(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct7 == 7'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011;" % (funct7, funct3), file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? result : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_rs2 = 0;", file=f)
        print("  assign spec_post_trap = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

def insn_alu(insn, funct7, funct3, expr):
    with open("insn_%s.v" % insn, "w") as f:
        header(f, insn)
        format_r(f)
        print("", file=f)
        print("  // %s instruction" % insn.upper(), file=f)
        print("  wire [`RISCV_FORMAL_XLEN-1:0] result = %s;" % expr, file=f)
        print("  assign spec_valid = rvfi_valid && insn_funct7 == 7'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0110011;" % (funct7, funct3), file=f)
        print("  assign spec_rs1 = insn_rs1;", file=f)
        print("  assign spec_rs2 = insn_rs2;", file=f)
        print("  assign spec_rd = insn_rd;", file=f)
        print("  assign spec_post_rd = spec_rd ? result : 0;", file=f)
        print("  assign spec_post_pc = rvfi_pre_pc + 4;", file=f)

        print("", file=f)
        print("  // default assignments", file=f)
        print("  assign spec_post_trap = 0;", file=f)
        print("  assign spec_mem_addr = 0;", file=f)
        print("  assign spec_mem_rmask = 0;", file=f)
        print("  assign spec_mem_wmask = 0;", file=f)
        print("  assign spec_mem_wdata = 0;", file=f)

        footer(f)

insn_lui()
insn_auipc()
insn_jal()
insn_jalr()

insn_b("beq",  "000", "rvfi_pre_rs1 == rvfi_pre_rs2")
insn_b("bne",  "001", "rvfi_pre_rs1 != rvfi_pre_rs2")
insn_b("blt",  "100", "$signed(rvfi_pre_rs1) < $signed(rvfi_pre_rs2)")
insn_b("bge",  "101", "$signed(rvfi_pre_rs1) >= $signed(rvfi_pre_rs2)")
insn_b("bltu", "110", "rvfi_pre_rs1 < rvfi_pre_rs2")
insn_b("bgeu", "111", "rvfi_pre_rs1 >= rvfi_pre_rs2")

insn_l("lb",  "000", 1, True)
insn_l("lh",  "001", 2, True)
insn_l("lw",  "010", 4, True)
insn_l("lbu", "100", 1, False)
insn_l("lhu", "101", 2, False)

insn_s("sb",  "000", 1)
insn_s("sh",  "001", 2)
insn_s("sw",  "010", 4)

insn_imm("addi",  "000", "rvfi_pre_rs1 + insn_imm")
insn_imm("slti",  "010", "$signed(rvfi_pre_rs1) < $signed(insn_imm)")
insn_imm("sltiu", "011", "rvfi_pre_rs1 < insn_imm")
insn_imm("xori",  "100", "rvfi_pre_rs1 ^ insn_imm")
insn_imm("ori",   "110", "rvfi_pre_rs1 | insn_imm")
insn_imm("andi",  "111", "rvfi_pre_rs1 & insn_imm")

insn_shimm("slli", "0000000", "001", "rvfi_pre_rs1 << insn_shamt")
insn_shimm("srli", "0000000", "101", "rvfi_pre_rs1 >> insn_shamt")
insn_shimm("srai", "0100000", "101", "$signed(rvfi_pre_rs1) >>> insn_shamt")

insn_alu("add",  "0000000", "000", "rvfi_pre_rs1 + rvfi_pre_rs2")
insn_alu("sub",  "0100000", "000", "rvfi_pre_rs1 - rvfi_pre_rs2")
insn_alu("sll",  "0000000", "001", "rvfi_pre_rs1 << rvfi_pre_rs2[4:0]")
insn_alu("slt",  "0000000", "010", "$signed(rvfi_pre_rs1) < $signed(rvfi_pre_rs2)")
insn_alu("sltu", "0000000", "011", "rvfi_pre_rs1 < rvfi_pre_rs2")
insn_alu("xor",  "0000000", "100", "rvfi_pre_rs1 ^ rvfi_pre_rs2")
insn_alu("srl",  "0000000", "101", "rvfi_pre_rs1 >> rvfi_pre_rs2[4:0]")
insn_alu("sra",  "0100000", "101", "$signed(rvfi_pre_rs1) >>> rvfi_pre_rs2[4:0]")
insn_alu("or",   "0000000", "110", "rvfi_pre_rs1 | rvfi_pre_rs2")
insn_alu("and",  "0000000", "111", "rvfi_pre_rs1 & rvfi_pre_rs2")

