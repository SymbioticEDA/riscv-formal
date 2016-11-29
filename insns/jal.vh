// DO NOT EDIT -- auto-generated from generate.py

// UJ-type instruction format
wire [XLEN-1:0] insn_imm = $signed({insn[31], insn[19:12], insn[20], insn[30:21], 1'b0});
wire [4:0] insn_rd = insn[11:7];
wire [6:0] insn_opcode = insn[6:0];

// JAL instruction
always @(posedge clk) begin
  if (valid && insn_opcode == 7'b 1101111) begin
    assert(rd == insn_rd);
    assert(post_rd == (rd ? pre_pc + 4 : 0));
    assert(post_pc == pre_pc + insn_imm);
  end
end
