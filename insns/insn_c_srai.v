// DO NOT EDIT -- auto-generated from riscv-formal/insns/generate.py

module rvfi_insn_c_srai (
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

  // CI-type instruction format (SRI variation)
  wire [`RISCV_FORMAL_ILEN-1:0] insn_padding = rvfi_insn >> 16;
  wire [5:0] insn_shamt = {rvfi_insn[12], rvfi_insn[6:2]};
  wire [2:0] insn_funct3 = rvfi_insn[15:13];
  wire [1:0] insn_funct2 = rvfi_insn[11:10];
  wire [4:0] insn_rs1_rd = {1'b1, rvfi_insn[9:7]};
  wire [1:0] insn_opcode = rvfi_insn[1:0];

`ifdef RISCV_FORMAL_CSR_MISA
  wire misa_ok = (rvfi_csr_misa_rdata & `RISCV_FORMAL_XLEN'h 4) == `RISCV_FORMAL_XLEN'h 4;
  assign spec_csr_misa_rmask = `RISCV_FORMAL_XLEN'h 4;
`else
  wire misa_ok = 1;
`endif

  // C_SRAI instruction
  wire [`RISCV_FORMAL_XLEN-1:0] result = $signed(rvfi_rs1_rdata) >>> insn_shamt;
  assign spec_valid = rvfi_valid && !insn_padding && insn_funct3 == 3'b 100 && insn_funct2 == 2'b 01 && insn_opcode == 2'b 01 && (!insn_shamt[5] || `RISCV_FORMAL_XLEN == 64);
  assign spec_rs1_addr = insn_rs1_rd;
  assign spec_rd_addr = insn_rs1_rd;
  assign spec_rd_wdata = spec_rd_addr ? result : 0;
  assign spec_pc_wdata = rvfi_pc_rdata + 2;

  // default assignments
  assign spec_rs2_addr = 0;
  assign spec_trap = !misa_ok;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
