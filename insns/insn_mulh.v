// DO NOT EDIT -- auto-generated from riscv-formal/insns/generate.py

module rvfi_insn_mulh (
  input                                rvfi_valid,
  input [`RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
  input [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,

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

  // R-type instruction format
  wire [`RISCV_FORMAL_ILEN-1:0] insn_padding = rvfi_insn >> 32;
  wire [6:0] insn_funct7 = rvfi_insn[31:25];
  wire [4:0] insn_rs2    = rvfi_insn[24:20];
  wire [4:0] insn_rs1    = rvfi_insn[19:15];
  wire [2:0] insn_funct3 = rvfi_insn[14:12];
  wire [4:0] insn_rd     = rvfi_insn[11: 7];
  wire [6:0] insn_opcode = rvfi_insn[ 6: 0];

  // MULH instruction
`ifdef RISCV_FORMAL_ALTOPS
  wire [`RISCV_FORMAL_XLEN:0] rs1 = {{`RISCV_FORMAL_XLEN{rvfi_rs1_rdata[`RISCV_FORMAL_XLEN-1]}}, rvfi_rs1_rdata};
  wire [`RISCV_FORMAL_XLEN:0] rs2 = {{`RISCV_FORMAL_XLEN{rvfi_rs2_rdata[`RISCV_FORMAL_XLEN-1]}}, rvfi_rs2_rdata};
  wire [`RISCV_FORMAL_XLEN-1:0] result = ($signed({rs1, rs1}) + $signed({rs2, rs2})) >> `RISCV_FORMAL_XLEN;
`else
  wire [`RISCV_FORMAL_XLEN-1:0] result = ({{`RISCV_FORMAL_XLEN{rvfi_rs1_rdata[`RISCV_FORMAL_XLEN-1]}}, rvfi_rs1_rdata} *
		{{`RISCV_FORMAL_XLEN{rvfi_rs2_rdata[`RISCV_FORMAL_XLEN-1]}}, rvfi_rs2_rdata}) >> `RISCV_FORMAL_XLEN;
`endif
  assign spec_valid = rvfi_valid && !insn_padding && insn_funct7 == 7'b 0000001 && insn_funct3 == 3'b 001 && insn_opcode == 7'b 0110011;
  assign spec_rs1_addr = insn_rs1;
  assign spec_rs2_addr = insn_rs2;
  assign spec_rd_addr = insn_rd;
  assign spec_rd_wdata = spec_rd_addr ? result : 0;
  assign spec_pc_wdata = rvfi_pc_rdata + 4;

  // default assignments
  assign spec_trap = 0;
  assign spec_mem_addr = 0;
  assign spec_mem_rmask = 0;
  assign spec_mem_wmask = 0;
  assign spec_mem_wdata = 0;
endmodule
