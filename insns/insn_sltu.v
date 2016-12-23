// DO NOT EDIT -- auto-generated from generate.py

module rvfi_insn_sltu (
  input                                rvfi_valid,
  input [                32   - 1 : 0] rvfi_insn,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
  input [`RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
  input [`RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata,

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

  // R-type instruction format
  wire [6:0] insn_funct7 = rvfi_insn[31:25];
  wire [4:0] insn_rs2    = rvfi_insn[24:20];
  wire [4:0] insn_rs1    = rvfi_insn[19:15];
  wire [2:0] insn_funct3 = rvfi_insn[14:12];
  wire [4:0] insn_rd     = rvfi_insn[11: 7];
  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];

  // SLTU instruction
  wire [`RISCV_FORMAL_XLEN-1:0] result = rvfi_pre_rs1 < rvfi_pre_rs2;
  assign spec_valid = rvfi_valid && insn_funct7 == 7'b 0000000 && insn_funct3 == 3'b 011 && insn_opcode == 7'b 0110011;
  assign spec_rs1 = insn_rs1;
  assign spec_rs2 = insn_rs2;
  assign spec_rd = insn_rd;
  assign spec_post_rd = spec_rd ? result : 0;
  assign spec_post_pc = rvfi_pre_pc + 4;

  // default assignments
  assign spec_post_trap = 0;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
