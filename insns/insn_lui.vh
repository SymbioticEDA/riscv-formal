// DO NOT EDIT -- auto-generated from generate.py

// U-type instruction format
insn_imm = $signed({insn[31:12], 12'b0});
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// LUI instruction
if (valid && insn_opcode == 7'b 0110111) begin
  assert(!ref_valid);
  ref_valid = 1;
  ref_rd = insn_rd;
  ref_post_rd = ref_rd ? insn_imm : 0;
  ref_post_pc = pre_pc + 4;
  ref_post_trap = 0;
end
