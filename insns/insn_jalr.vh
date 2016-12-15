// DO NOT EDIT -- auto-generated from generate.py

// I-type instruction format
insn_imm = $signed(insn[31:20]);
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// JALR instruction
if (valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 1100111) begin
  result = pre_rs1 + insn_imm;
  assert(!ref_valid);
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rd = insn_rd;
  ref_post_rd = ref_rd ? pre_pc + 4 : 0;
  ref_post_pc = result;
`ifdef RISCV_FORMAL_COMPRESSED
  ref_post_trap = result[0] != 0;
`else
  ref_post_trap = result[1:0] != 0;
`endif
end
