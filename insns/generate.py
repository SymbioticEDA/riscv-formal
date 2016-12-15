#!/usr/bin/env python3

def header(f):
    print("// DO NOT EDIT -- auto-generated from generate.py", file=f)
    print("", file=f)

def format_r(f):
    print("// R-type instruction format", file=f)
    print("insn_funct7 = insn[31:25];", file=f)
    print("insn_rs2 = insn[24:20];", file=f)
    print("insn_rs1 = insn[19:15];", file=f)
    print("insn_funct3 = insn[14:12];", file=f)
    print("insn_rd = insn[11:7];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def format_i(f):
    print("// I-type instruction format", file=f)
    print("insn_imm = $signed(insn[31:20]);", file=f)
    print("insn_rs1 = insn[19:15];", file=f)
    print("insn_funct3 = insn[14:12];", file=f)
    print("insn_rd = insn[11:7];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def format_i_shift(f):
    print("// I-type instruction format (shift variation)", file=f)
    print("insn_funct7 = insn[31:25];", file=f)
    print("insn_shamt = insn[24:20];", file=f)
    print("insn_rs1 = insn[19:15];", file=f)
    print("insn_funct3 = insn[14:12];", file=f)
    print("insn_rd = insn[11:7];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def format_sb(f):
    print("// SB-type instruction format", file=f)
    print("insn_imm = $signed({insn[31], insn[7], insn[30:25], insn[11:8], 1'b0});", file=f)
    print("insn_rs2 = insn[24:20];", file=f)
    print("insn_rs1 = insn[19:15];", file=f)
    print("insn_funct3 = insn[14:12];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def format_u(f):
    print("// U-type instruction format", file=f)
    print("insn_imm = $signed({insn[31:12], 12'b0});", file=f)
    print("insn_rd = insn[11:7];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def format_uj(f):
    print("// UJ-type instruction format", file=f)
    print("insn_imm = $signed({insn[31], insn[19:12], insn[20], insn[30:21], 1'b0});", file=f)
    print("insn_rd = insn[11:7];", file=f)
    print("insn_opcode = insn[6:0];", file=f)
    print("", file=f)

def insn_lui(insn = "lui"):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_u(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_opcode == 7'b 0110111) begin", file=f)
		print("  assert(!ref_valid);", file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? insn_imm : 0;", file=f)
		print("  ref_post_pc = pre_pc + 4;", file=f)
		print("  ref_post_trap = 0;", file=f)
		print("end", file=f)

def insn_auipc(insn = "auipc"):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_u(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_opcode == 7'b 0010111) begin", file=f)
		print("  assert(!ref_valid);", file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? pre_pc + insn_imm : 0;", file=f)
		print("  ref_post_pc = pre_pc + 4;", file=f)
		print("  ref_post_trap = 0;", file=f)
		print("end", file=f)

def insn_jal(insn = "jal"):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_uj(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_opcode == 7'b 1101111) begin", file=f)
		print("  assert(!ref_valid);", file=f)
		print("  result = pre_pc + insn_imm;", file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? pre_pc + 4 : 0;", file=f)
		print("  ref_post_pc = result;", file=f)
		print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
		print("  ref_post_trap = result[0] != 0;", file=f)
		print("`else", file=f)
		print("  ref_post_trap = result[1:0] != 0;", file=f)
		print("`endif", file=f)
		print("end", file=f)

def insn_jalr(insn = "jalr"):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_i(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 1100111) begin", file=f)
		print("  result = pre_rs1 + insn_imm;", file=f)
		print("  assert(!ref_valid);", file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rs1 = insn_rs1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? pre_pc + 4 : 0;", file=f)
		print("  ref_post_pc = result;", file=f)
		print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
		print("  ref_post_trap = result[0] != 0;", file=f)
		print("`else", file=f)
		print("  ref_post_trap = result[1:0] != 0;", file=f)
		print("`endif", file=f)
		print("end", file=f)

def insn_b(insn, funct3, expr):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_sb(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 1100011) begin" % funct3, file=f)
		print("  assert(!ref_valid);", file=f)
		print("  cond = %s;" % expr, file=f)
		print("  result = cond ? pre_pc + insn_imm : pre_pc + 4;", file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rs1 = insn_rs1;", file=f)
		print("  ref_rs2 = insn_rs2;", file=f)
		print("  ref_rd = 0;", file=f)
		print("  ref_post_pc = result;", file=f)
		print("`ifdef RISCV_FORMAL_COMPRESSED", file=f)
		print("  ref_post_trap = result[0] != 0;", file=f)
		print("`else", file=f)
		print("  ref_post_trap = result[1:0] != 0;", file=f)
		print("`endif", file=f)
		print("end", file=f)

def insn_imm(insn, funct3, expr):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_i(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011) begin" % funct3, file=f)
		print("  assert(!ref_valid);", file=f)
		print("  result = %s;" % expr, file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rs1 = insn_rs1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? result : 0;", file=f)
		print("  ref_post_pc = pre_pc + 4;", file=f)
		print("  ref_post_trap = 0;", file=f)
		print("end", file=f)

def insn_shimm(insn, funct7, funct3, expr):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_i_shift(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_funct7 == 7'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0010011) begin" % (funct7, funct3), file=f)
		print("  assert(!ref_valid);", file=f)
		print("  result = %s;" % expr, file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rs1 = insn_rs1;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? result : 0;", file=f)
		print("  ref_post_pc = pre_pc + 4;", file=f)
		print("  ref_post_trap = 0;", file=f)
		print("end", file=f)

def insn_alu(insn, funct7, funct3, expr):
	with open("insn_%s.vh" % insn, "w") as f:
		header(f)
		format_r(f)
		print("// %s instruction" % insn.upper(), file=f)
		print("if (valid && insn_funct7 == 7'b %s && insn_funct3 == 3'b %s && insn_opcode == 7'b 0110011) begin" % (funct7, funct3), file=f)
		print("  assert(!ref_valid);", file=f)
		print("  result = %s;" % expr, file=f)
		print("  ref_valid = 1;", file=f)
		print("  ref_rs1 = insn_rs1;", file=f)
		print("  ref_rs2 = insn_rs2;", file=f)
		print("  ref_rd = insn_rd;", file=f)
		print("  ref_post_rd = ref_rd ? result : 0;", file=f)
		print("  ref_post_pc = pre_pc + 4;", file=f)
		print("  ref_post_trap = 0;", file=f)
		print("end", file=f)

insn_lui()
insn_auipc()
insn_jal()
insn_jalr()

insn_b("beq",  "000", "pre_rs1 == pre_rs2")
insn_b("bne",  "001", "pre_rs1 != pre_rs2")
insn_b("blt",  "100", "$signed(pre_rs1) < $signed(pre_rs2)")
insn_b("bge",  "101", "$signed(pre_rs1) >= $signed(pre_rs2)")
insn_b("bltu", "110", "pre_rs1 < pre_rs2")
insn_b("bgeu", "111", "pre_rs1 >= pre_rs2")

insn_imm("addi",  "000", "pre_rs1 + insn_imm")
insn_imm("slti",  "010", "$signed(pre_rs1) < $signed(insn_imm)")
insn_imm("sltiu", "011", "pre_rs1 < insn_imm")
insn_imm("xori",  "100", "pre_rs1 ^ insn_imm")
insn_imm("ori",   "110", "pre_rs1 | insn_imm")
insn_imm("andi",  "111", "pre_rs1 & insn_imm")

insn_shimm("slli", "0000000", "001", "pre_rs1 << insn_shamt")
insn_shimm("srli", "0000000", "101", "pre_rs1 >> insn_shamt")
insn_shimm("srai", "0100000", "101", "$signed(pre_rs1) >>> insn_shamt")

insn_alu("add",  "0000000", "000", "pre_rs1 + pre_rs2")
insn_alu("sub",  "0100000", "000", "pre_rs1 - pre_rs2")
insn_alu("sll",  "0000000", "001", "pre_rs1 << pre_rs2[4:0]")
insn_alu("slt",  "0000000", "010", "$signed(pre_rs1) < $signed(pre_rs2)")
insn_alu("sltu", "0000000", "011", "pre_rs1 < pre_rs2")
insn_alu("xor",  "0000000", "100", "pre_rs1 ^ pre_rs2")
insn_alu("srl",  "0000000", "101", "pre_rs1 >> pre_rs2[4:0]")
insn_alu("sra",  "0100000", "101", "$signed(pre_rs1) >>> pre_rs2[4:0]")
insn_alu("or",   "0000000", "110", "pre_rs1 | pre_rs2")
insn_alu("and",  "0000000", "111", "pre_rs1 & pre_rs2")

