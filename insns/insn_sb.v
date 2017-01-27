// DO NOT EDIT -- auto-generated from generate.py

module rvfi_insn_sb (
  input                                rvfi_valid,
  input [                32   - 1 : 0] rvfi_insn,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,

  output                                spec_valid,
  output [                       4 : 0] spec_rs1_addr,
  output [                       4 : 0] spec_rs2_addr,
  output [                       4 : 0] spec_rd,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_rd,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_pc,
  output                                spec_post_trap,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata
);

  // S-type instruction format
  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31:25], rvfi_insn[11:7]});
  wire [4:0] insn_rs2    = rvfi_insn[24:20];
  wire [4:0] insn_rs1    = rvfi_insn[19:15];
  wire [2:0] insn_funct3 = rvfi_insn[14:12];
  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];

  // SB instruction
  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_pre_rs1 + insn_imm;
  assign spec_valid = rvfi_valid && insn_funct3 == 3'b 000 && insn_opcode == 7'b 0100011;
  assign spec_rs1_addr = insn_rs1;
  assign spec_rs2_addr = insn_rs2;
  assign spec_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);
  assign spec_mem_wmask = ((1 << 1)-1) << (addr-spec_mem_addr);
  assign spec_mem_wdata = rvfi_pre_rs2 << (8*(addr-spec_mem_addr));
  assign spec_post_pc = rvfi_pre_pc + 4;
  assign spec_post_trap = (addr & (1-1)) != 0;

  // default assignments
  assign spec_rd = 0;
  assign spec_post_rd = 0;
  assign spec_mem_rmask = 0;
endmodule
