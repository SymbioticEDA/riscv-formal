// DO NOT EDIT -- auto-generated from generate.py

// I-type instruction format
wire [XLEN-1:0] insn_imm = $signed(insn[31:20]);
wire [4:0] insn_rs1 = insn[19:15];
wire [4:0] insn_funct3 = insn[14:12];
wire [4:0] insn_rd = insn[11:7];
wire [6:0] insn_opcode = insn[6:0];

// JALR instruction
wire [XLEN-1:0] result = pre_rs1 + insn_imm;
always @(posedge clk) begin
  if (valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 1100111) begin
    assert(rs1 == insn_rs1);
    assert(rd == insn_rd);
`ifdef RISCV_FORMAL_COMPRESSED
    if (result[0] == 0) begin
`else
    if (result[1:0] == 0) begin
`endif
      assert(post_rd == (rd ? pre_pc + 4 : 0));
      assert(post_pc == pre_rs1 + insn_imm);
      assert(!post_trap);
    end else begin
      assert(post_trap);
    end
  end
end
