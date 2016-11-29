// DO NOT EDIT -- auto-generated from generate.py

// SB-type instruction format
wire [XLEN-1:0] insn_imm = $signed({insn[31], insn[7], insn[30:25], insn[11:8], 1'b0});
wire [4:0] insn_rs2 = insn[24:20];
wire [4:0] insn_rs1 = insn[19:15];
wire [4:0] insn_funct3 = insn[14:12];
wire [6:0] insn_opcode = insn[6:0];

// BGEU instruction
wire cond = pre_rs1 >= pre_rs2;
always @(posedge clk) begin
  if (valid && insn_funct3 == 3'b 111 && insn_opcode == 7'b 1100011) begin
    assert(rs1 == insn_rs1);
    assert(rs2 == insn_rs2);
    assert(rd == 0);
    assert(post_pc == (cond ? pre_pc + insn_imm : pre_pc + 4));
  end
end
