// DO NOT EDIT -- auto-generated from generate.py

// R-type instruction format
insn_funct7 = insn[31:25];
insn_rs2 = insn[24:20];
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// OR instruction
if (valid && insn_funct7 == 7'b 0000000 && insn_funct3 == 3'b 110 && insn_opcode == 7'b 0110011) begin
  assert(!ref_valid);
  result = pre_rs1 | pre_rs2;
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rs2 = insn_rs2;
  ref_rd = insn_rd;
  ref_post_rd = ref_rd ? result : 0;
  ref_post_pc = pre_pc + 4;
  ref_post_trap = 0;
end
