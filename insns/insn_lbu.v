// DO NOT EDIT -- auto-generated from riscv-formal/insns/generate.py

module rvfi_insn_lbu (
  input                                 rvfi_valid,
  input  [`RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,
  input  [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,
  input  [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
  input  [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
  input  [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
`ifdef RISCV_FORMAL_CSR_MISA
  input  [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_csr_misa_rdata,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_csr_misa_rmask,
`endif

  output                                spec_valid,
  output                                spec_trap,
  output [                       4 : 0] spec_rs1_addr,
  output [                       4 : 0] spec_rs2_addr,
  output [                       4 : 0] spec_rd_addr,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_rd_wdata,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_pc_wdata,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask,
  output [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask,
  output [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata
);

  // I-type instruction format
  wire [`RISCV_FORMAL_ILEN-1:0] insn_padding = rvfi_insn >> 32;
  wire [`RISCV_FORMAL_XLEN-1:0] insn_imm = $signed(rvfi_insn[31:20]);
  wire [4:0] insn_rs1    = rvfi_insn[19:15];
  wire [2:0] insn_funct3 = rvfi_insn[14:12];
  wire [4:0] insn_rd     = rvfi_insn[11: 7];
  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];

`ifdef RISCV_FORMAL_CSR_MISA
  wire misa_ok = (rvfi_csr_misa_rdata & `RISCV_FORMAL_XLEN'h 0) == `RISCV_FORMAL_XLEN'h 0;
  assign spec_csr_misa_rmask = `RISCV_FORMAL_XLEN'h 0;
`else
  wire misa_ok = 1;
`endif

  // LBU instruction
`ifdef RISCV_FORMAL_ALIGNED_MEM
  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;
  wire [7:0] result = rvfi_mem_rdata >> (8*(addr-spec_mem_addr));
  assign spec_valid = rvfi_valid && !insn_padding && insn_funct3 == 3'b 100 && insn_opcode == 7'b 0000011;
  assign spec_rs1_addr = insn_rs1;
  assign spec_rd_addr = insn_rd;
  assign spec_mem_addr = addr & ~(`RISCV_FORMAL_XLEN/8-1);
  assign spec_mem_rmask = ((1 << 1)-1) << (addr-spec_mem_addr);
  assign spec_rd_wdata = spec_rd_addr ? result : 0;
  assign spec_pc_wdata = rvfi_pc_rdata + 4;
  assign spec_trap = ((addr & (1-1)) != 0) || !misa_ok;
`else
  wire [`RISCV_FORMAL_XLEN-1:0] addr = rvfi_rs1_rdata + insn_imm;
  wire [7:0] result = rvfi_mem_rdata;
  assign spec_valid = rvfi_valid && insn_funct3 == 3'b 100 && insn_opcode == 7'b 0000011;
  assign spec_rs1_addr = insn_rs1;
  assign spec_rd_addr = insn_rd;
  assign spec_mem_addr = addr;
  assign spec_mem_rmask = ((1 << 1)-1);
  assign spec_rd_wdata = spec_rd_addr ? result : 0;
  assign spec_pc_wdata = rvfi_pc_rdata + 4;
  assign spec_trap = !misa_ok;
`endif

  // default assignments
  assign spec_rs2_addr = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
