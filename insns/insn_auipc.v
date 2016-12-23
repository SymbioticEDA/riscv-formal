// DO NOT EDIT -- auto-generated from generate.py

module rvfi_insn_auipc (
  input                                rvfi_valid,
  input [                32   - 1 : 0] rvfi_insn,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,

  output                                spec_valid,
  output [                       4 : 0] spec_rs1,
  output [                       4 : 0] spec_rs2,
  output [                       4 : 0] spec_rd,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_rd,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_pc,
  output                                spec_post_trap,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata
);

  // U-type instruction format
  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31:12], 12'b0});
  wire [4:0] insn_rd     = rvfi_insn[11:7];
  wire [6:0] insn_opcode = rvfi_insn[ 6:0];

  // AUIPC instruction
  assign spec_valid = rvfi_valid && insn_opcode == 7'b 0010111;
  assign spec_rd = insn_rd;
  assign spec_post_rd = spec_rd ? rvfi_pre_pc + insn_imm : 0;
  assign spec_post_pc = rvfi_pre_pc + 4;

  // default assignments
  assign spec_rs1 = 0;
  assign spec_rs2 = 0;
  assign spec_post_rd = 0;
  assign spec_post_pc = 0;
  assign spec_post_trap = 0;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
