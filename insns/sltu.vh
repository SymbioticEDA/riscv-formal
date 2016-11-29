// DO NOT EDIT -- auto-generated from generate.py

// R-type instruction format
wire [6:0] insn_funct7 = insn[31:25];
wire [4:0] insn_rs2 = insn[24:20];
wire [4:0] insn_rs1 = insn[19:15];
wire [4:0] insn_funct3 = insn[14:12];
wire [4:0] insn_rd = insn[11:7];
wire [6:0] insn_opcode = insn[6:0];

// SLTU instruction
wire [XLEN-1:0] result = pre_rs1 < pre_rs2;
always @(posedge clk) begin
  if (valid && insn_funct7 == 7'b 0000000 && insn_funct3 == 3'b 011 && insn_opcode == 7'b 0110011) begin
    assert(rs1 == insn_rs1);
    assert(rs2 == insn_rs2);
    assert(rd == insn_rd);
    assert(post_pc == pre_pc + 4);
    assert(post_rd == (rd ? result : 0));
  end
end
