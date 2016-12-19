// DO NOT EDIT -- auto-generated from generate.py

// S-type instruction format
insn_imm = $signed({insn[31:25], insn[11:7]});
insn_rs2 = insn[24:20];
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_opcode = insn[6:0];

// SW instruction
if (valid && insn_funct3 == 3'b 010 && insn_opcode == 7'b 0100011) begin
  assert(!ref_valid);
  addr = pre_rs1 + insn_imm;
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rs2 = insn_rs2;
  ref_rd = 0;
  if ((addr & (4-1)) == 0) begin
    ref_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);
    ref_mem_wmask = ((1 << 4)-1) << (addr-ref_mem_addr);
    ref_mem_wdata = pre_rs2 << (8*(addr-ref_mem_addr));
    ref_post_rd = 0;
    ref_post_pc = pre_pc + 4;
    ref_post_trap = 0;
  end else begin
    ref_post_trap = 1;
  end
end
