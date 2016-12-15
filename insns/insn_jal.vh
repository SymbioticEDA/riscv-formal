// DO NOT EDIT -- auto-generated from generate.py

// UJ-type instruction format
insn_imm = $signed({insn[31], insn[19:12], insn[20], insn[30:21], 1'b0});
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// JAL instruction
if (valid && insn_opcode == 7'b 1101111) begin
  assert(!ref_valid);
  result = pre_pc + insn_imm;
  ref_valid = 1;
  ref_rd = insn_rd;
  ref_post_rd = ref_rd ? pre_pc + 4 : 0;
  ref_post_pc = result;
`ifdef RISCV_FORMAL_COMPRESSED
  ref_post_trap = result[0] == 0;
`else
  ref_post_trap = result[1:0] == 0;
`endif
end
