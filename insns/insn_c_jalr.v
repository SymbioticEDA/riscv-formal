// DO NOT EDIT -- auto-generated from riscv-formal/insns/generate.py

module rvfi_insn_c_jalr (
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

  // CI-type instruction format
  wire [`RISCV_FORMAL_ILEN-1:0] insn_padding = rvfi_insn >> 16;
  wire [3:0] insn_funct4 = rvfi_insn[15:12];
  wire [4:0] insn_rs1_rd = rvfi_insn[11:7];
  wire [4:0] insn_rs2 = rvfi_insn[6:2];
  wire [1:0] insn_opcode = rvfi_insn[1:0];

`ifdef RISCV_FORMAL_CSR_MISA
  wire misa_ok = (rvfi_csr_misa_rdata & `RISCV_FORMAL_XLEN'h 4) == `RISCV_FORMAL_XLEN'h 4;
  assign spec_csr_misa_rmask = `RISCV_FORMAL_XLEN'h 4;
`else
  wire misa_ok = 1;
`endif

  // C_JALR instruction
  wire [`RISCV_FORMAL_XLEN-1:0] next_pc = rvfi_rs1_rdata & ~1;
  assign spec_valid = rvfi_valid && !insn_padding && insn_funct4 == 4'b 1001 && insn_rs1_rd && !insn_rs2 && insn_opcode == 2'b 10;
  assign spec_rs1_addr = insn_rs1_rd;
  assign spec_rd_addr = 5'd 1;
  assign spec_rd_wdata = rvfi_pc_rdata + 2;
  assign spec_pc_wdata = next_pc;
  assign spec_trap = (next_pc[0] != 0) || !misa_ok;

  // default assignments
  assign spec_rs2_addr = 0;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
