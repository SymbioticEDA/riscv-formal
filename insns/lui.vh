// DO NOT EDIT -- auto-generated from generate.py

// U-type instruction format
wire [XLEN-1:0] insn_imm = $signed({insn[31:12], 12'b0});
wire [4:0] insn_rd = insn[11:7];
wire [6:0] insn_opcode = insn[6:0];

// LUI instruction
always @(posedge clk) begin
  if (valid && insn_opcode == 7'b 0110111) begin
    assert(rd == insn_rd);
    assert(post_rd == (rd ? insn_imm : 0));
    assert(post_pc == pre_pc + 4);
  end
end
