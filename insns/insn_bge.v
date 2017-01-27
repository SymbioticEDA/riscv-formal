// DO NOT EDIT -- auto-generated from generate.py

module rvfi_insn_bge (
  input                                rvfi_valid,
  input [                32   - 1 : 0] rvfi_insn,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
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

  // SB-type instruction format
  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed({rvfi_insn[31], rvfi_insn[7], rvfi_insn[30:25], rvfi_insn[11:8], 1'b0});
  wire [4:0] insn_rs2    = rvfi_insn[24:20];
  wire [4:0] insn_rs1    = rvfi_insn[19:15];
  wire [2:0] insn_funct3 = rvfi_insn[14:12];
  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];

  // BGE instruction
  wire cond = $signed(rvfi_rs1_rdata) >= $signed(rvfi_rs2_rdata);
  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = cond ? rvfi_pre_pc + insn_imm : rvfi_pre_pc + 4;
  assign spec_valid = rvfi_valid && insn_funct3 == 3'b 101 && insn_opcode == 7'b 1100011;
  assign spec_rs1_addr = insn_rs1;
  assign spec_rs2_addr = insn_rs2;
  assign spec_post_pc = next_pc;
`ifdef RISCV_FORMAL_COMPRESSED
  assign spec_post_trap = next_pc[0] != 0;
`else
  assign spec_post_trap = next_pc[1:0] != 0;
`endif

  // default assignments
  assign spec_rd = 0;
  assign spec_post_rd = 0;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
