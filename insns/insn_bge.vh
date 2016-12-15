// DO NOT EDIT -- auto-generated from generate.py

// SB-type instruction format
insn_imm = $signed({insn[31], insn[7], insn[30:25], insn[11:8], 1'b0});
insn_rs2 = insn[24:20];
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_opcode = insn[6:0];

// BGE instruction
if (valid && insn_funct3 == 3'b 101 && insn_opcode == 7'b 1100011) begin
  assert(!ref_valid);
  cond = $signed(pre_rs1) >= $signed(pre_rs2);
  result = cond ? pre_pc + insn_imm : pre_pc + 4;
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rs2 = insn_rs2;
  ref_rd = 0;
  ref_post_pc = result;
`ifdef RISCV_FORMAL_COMPRESSED
  ref_post_trap = result[0] != 0;
`else
  ref_post_trap = result[1:0] != 0;
`endif
end
