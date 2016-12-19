// DO NOT EDIT -- auto-generated from generate.py

// I-type instruction format
insn_imm = $signed(insn[31:20]);
insn_rs1 = insn[19:15];
insn_funct3 = insn[14:12];
insn_rd = insn[11:7];
insn_opcode = insn[6:0];

// LHU instruction
if (valid && insn_funct3 == 3'b 101 && insn_opcode == 7'b 0000011) begin
  assert(!ref_valid);
  addr = pre_rs1 + insn_imm;
  ref_valid = 1;
  ref_rs1 = insn_rs1;
  ref_rd = insn_rd;
  if ((addr & (2-1)) == 0) begin
    ref_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);
    ref_mem_rmask = ((1 << 2)-1) << (addr-ref_mem_addr);
    result = mem_rdata >> (8*(addr-ref_mem_addr));
    ref_post_rd = ref_rd ? $unsigned(result[15:0]) : 0;
    ref_post_pc = pre_pc + 4;
    ref_post_trap = 0;
  end else begin
    ref_post_trap = 1;
  end
end
