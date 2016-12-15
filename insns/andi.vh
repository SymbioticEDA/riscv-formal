// DO NOT EDIT -- auto-generated from generate.py

// I-type instruction format
insn_imm = $signed(insn[31:20]);
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// ANDI instruction
if (valid && insn_funct3 == 3'b 111 && insn_opcode == 7'b 0010011) begin
  assert(!ref_valid);
  result = pre_rs1 & insn_imm;
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rd = insn_rd;
  ref_post_rd = ref_rd ? result : 0;
  ref_post_pc = pre_pc + 4;
  ref_post_trap = 0;
end
