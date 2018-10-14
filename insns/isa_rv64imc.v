// DO NOT EDIT -- auto-generated from riscv-formal/insns/generate.py

module rvfi_isa_rv64imc (
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
  wire                                spec_insn_add_valid;
  wire                                spec_insn_add_trap;
  wire [                       4 : 0] spec_insn_add_rs1_addr;
  wire [                       4 : 0] spec_insn_add_rs2_addr;
  wire [                       4 : 0] spec_insn_add_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_add_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_add_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_add_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_add_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_add_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_add_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_add_csr_misa_rmask;
`endif

  rvfi_insn_add insn_add (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_add_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_add_valid),
    .spec_trap(spec_insn_add_trap),
    .spec_rs1_addr(spec_insn_add_rs1_addr),
    .spec_rs2_addr(spec_insn_add_rs2_addr),
    .spec_rd_addr(spec_insn_add_rd_addr),
    .spec_rd_wdata(spec_insn_add_rd_wdata),
    .spec_pc_wdata(spec_insn_add_pc_wdata),
    .spec_mem_addr(spec_insn_add_mem_addr),
    .spec_mem_rmask(spec_insn_add_mem_rmask),
    .spec_mem_wmask(spec_insn_add_mem_wmask),
    .spec_mem_wdata(spec_insn_add_mem_wdata)
  );

  wire                                spec_insn_addi_valid;
  wire                                spec_insn_addi_trap;
  wire [                       4 : 0] spec_insn_addi_rs1_addr;
  wire [                       4 : 0] spec_insn_addi_rs2_addr;
  wire [                       4 : 0] spec_insn_addi_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addi_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addi_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addi_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addi_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addi_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addi_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addi_csr_misa_rmask;
`endif

  rvfi_insn_addi insn_addi (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_addi_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_addi_valid),
    .spec_trap(spec_insn_addi_trap),
    .spec_rs1_addr(spec_insn_addi_rs1_addr),
    .spec_rs2_addr(spec_insn_addi_rs2_addr),
    .spec_rd_addr(spec_insn_addi_rd_addr),
    .spec_rd_wdata(spec_insn_addi_rd_wdata),
    .spec_pc_wdata(spec_insn_addi_pc_wdata),
    .spec_mem_addr(spec_insn_addi_mem_addr),
    .spec_mem_rmask(spec_insn_addi_mem_rmask),
    .spec_mem_wmask(spec_insn_addi_mem_wmask),
    .spec_mem_wdata(spec_insn_addi_mem_wdata)
  );

  wire                                spec_insn_addiw_valid;
  wire                                spec_insn_addiw_trap;
  wire [                       4 : 0] spec_insn_addiw_rs1_addr;
  wire [                       4 : 0] spec_insn_addiw_rs2_addr;
  wire [                       4 : 0] spec_insn_addiw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addiw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addiw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addiw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addiw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addiw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addiw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addiw_csr_misa_rmask;
`endif

  rvfi_insn_addiw insn_addiw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_addiw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_addiw_valid),
    .spec_trap(spec_insn_addiw_trap),
    .spec_rs1_addr(spec_insn_addiw_rs1_addr),
    .spec_rs2_addr(spec_insn_addiw_rs2_addr),
    .spec_rd_addr(spec_insn_addiw_rd_addr),
    .spec_rd_wdata(spec_insn_addiw_rd_wdata),
    .spec_pc_wdata(spec_insn_addiw_pc_wdata),
    .spec_mem_addr(spec_insn_addiw_mem_addr),
    .spec_mem_rmask(spec_insn_addiw_mem_rmask),
    .spec_mem_wmask(spec_insn_addiw_mem_wmask),
    .spec_mem_wdata(spec_insn_addiw_mem_wdata)
  );

  wire                                spec_insn_addw_valid;
  wire                                spec_insn_addw_trap;
  wire [                       4 : 0] spec_insn_addw_rs1_addr;
  wire [                       4 : 0] spec_insn_addw_rs2_addr;
  wire [                       4 : 0] spec_insn_addw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_addw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_addw_csr_misa_rmask;
`endif

  rvfi_insn_addw insn_addw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_addw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_addw_valid),
    .spec_trap(spec_insn_addw_trap),
    .spec_rs1_addr(spec_insn_addw_rs1_addr),
    .spec_rs2_addr(spec_insn_addw_rs2_addr),
    .spec_rd_addr(spec_insn_addw_rd_addr),
    .spec_rd_wdata(spec_insn_addw_rd_wdata),
    .spec_pc_wdata(spec_insn_addw_pc_wdata),
    .spec_mem_addr(spec_insn_addw_mem_addr),
    .spec_mem_rmask(spec_insn_addw_mem_rmask),
    .spec_mem_wmask(spec_insn_addw_mem_wmask),
    .spec_mem_wdata(spec_insn_addw_mem_wdata)
  );

  wire                                spec_insn_and_valid;
  wire                                spec_insn_and_trap;
  wire [                       4 : 0] spec_insn_and_rs1_addr;
  wire [                       4 : 0] spec_insn_and_rs2_addr;
  wire [                       4 : 0] spec_insn_and_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_and_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_and_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_and_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_and_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_and_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_and_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_and_csr_misa_rmask;
`endif

  rvfi_insn_and insn_and (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_and_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_and_valid),
    .spec_trap(spec_insn_and_trap),
    .spec_rs1_addr(spec_insn_and_rs1_addr),
    .spec_rs2_addr(spec_insn_and_rs2_addr),
    .spec_rd_addr(spec_insn_and_rd_addr),
    .spec_rd_wdata(spec_insn_and_rd_wdata),
    .spec_pc_wdata(spec_insn_and_pc_wdata),
    .spec_mem_addr(spec_insn_and_mem_addr),
    .spec_mem_rmask(spec_insn_and_mem_rmask),
    .spec_mem_wmask(spec_insn_and_mem_wmask),
    .spec_mem_wdata(spec_insn_and_mem_wdata)
  );

  wire                                spec_insn_andi_valid;
  wire                                spec_insn_andi_trap;
  wire [                       4 : 0] spec_insn_andi_rs1_addr;
  wire [                       4 : 0] spec_insn_andi_rs2_addr;
  wire [                       4 : 0] spec_insn_andi_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_andi_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_andi_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_andi_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_andi_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_andi_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_andi_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_andi_csr_misa_rmask;
`endif

  rvfi_insn_andi insn_andi (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_andi_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_andi_valid),
    .spec_trap(spec_insn_andi_trap),
    .spec_rs1_addr(spec_insn_andi_rs1_addr),
    .spec_rs2_addr(spec_insn_andi_rs2_addr),
    .spec_rd_addr(spec_insn_andi_rd_addr),
    .spec_rd_wdata(spec_insn_andi_rd_wdata),
    .spec_pc_wdata(spec_insn_andi_pc_wdata),
    .spec_mem_addr(spec_insn_andi_mem_addr),
    .spec_mem_rmask(spec_insn_andi_mem_rmask),
    .spec_mem_wmask(spec_insn_andi_mem_wmask),
    .spec_mem_wdata(spec_insn_andi_mem_wdata)
  );

  wire                                spec_insn_auipc_valid;
  wire                                spec_insn_auipc_trap;
  wire [                       4 : 0] spec_insn_auipc_rs1_addr;
  wire [                       4 : 0] spec_insn_auipc_rs2_addr;
  wire [                       4 : 0] spec_insn_auipc_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_auipc_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_auipc_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_auipc_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_auipc_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_auipc_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_auipc_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_auipc_csr_misa_rmask;
`endif

  rvfi_insn_auipc insn_auipc (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_auipc_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_auipc_valid),
    .spec_trap(spec_insn_auipc_trap),
    .spec_rs1_addr(spec_insn_auipc_rs1_addr),
    .spec_rs2_addr(spec_insn_auipc_rs2_addr),
    .spec_rd_addr(spec_insn_auipc_rd_addr),
    .spec_rd_wdata(spec_insn_auipc_rd_wdata),
    .spec_pc_wdata(spec_insn_auipc_pc_wdata),
    .spec_mem_addr(spec_insn_auipc_mem_addr),
    .spec_mem_rmask(spec_insn_auipc_mem_rmask),
    .spec_mem_wmask(spec_insn_auipc_mem_wmask),
    .spec_mem_wdata(spec_insn_auipc_mem_wdata)
  );

  wire                                spec_insn_beq_valid;
  wire                                spec_insn_beq_trap;
  wire [                       4 : 0] spec_insn_beq_rs1_addr;
  wire [                       4 : 0] spec_insn_beq_rs2_addr;
  wire [                       4 : 0] spec_insn_beq_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_beq_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_beq_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_beq_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_beq_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_beq_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_beq_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_beq_csr_misa_rmask;
`endif

  rvfi_insn_beq insn_beq (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_beq_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_beq_valid),
    .spec_trap(spec_insn_beq_trap),
    .spec_rs1_addr(spec_insn_beq_rs1_addr),
    .spec_rs2_addr(spec_insn_beq_rs2_addr),
    .spec_rd_addr(spec_insn_beq_rd_addr),
    .spec_rd_wdata(spec_insn_beq_rd_wdata),
    .spec_pc_wdata(spec_insn_beq_pc_wdata),
    .spec_mem_addr(spec_insn_beq_mem_addr),
    .spec_mem_rmask(spec_insn_beq_mem_rmask),
    .spec_mem_wmask(spec_insn_beq_mem_wmask),
    .spec_mem_wdata(spec_insn_beq_mem_wdata)
  );

  wire                                spec_insn_bge_valid;
  wire                                spec_insn_bge_trap;
  wire [                       4 : 0] spec_insn_bge_rs1_addr;
  wire [                       4 : 0] spec_insn_bge_rs2_addr;
  wire [                       4 : 0] spec_insn_bge_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bge_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bge_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bge_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bge_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bge_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bge_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bge_csr_misa_rmask;
`endif

  rvfi_insn_bge insn_bge (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_bge_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_bge_valid),
    .spec_trap(spec_insn_bge_trap),
    .spec_rs1_addr(spec_insn_bge_rs1_addr),
    .spec_rs2_addr(spec_insn_bge_rs2_addr),
    .spec_rd_addr(spec_insn_bge_rd_addr),
    .spec_rd_wdata(spec_insn_bge_rd_wdata),
    .spec_pc_wdata(spec_insn_bge_pc_wdata),
    .spec_mem_addr(spec_insn_bge_mem_addr),
    .spec_mem_rmask(spec_insn_bge_mem_rmask),
    .spec_mem_wmask(spec_insn_bge_mem_wmask),
    .spec_mem_wdata(spec_insn_bge_mem_wdata)
  );

  wire                                spec_insn_bgeu_valid;
  wire                                spec_insn_bgeu_trap;
  wire [                       4 : 0] spec_insn_bgeu_rs1_addr;
  wire [                       4 : 0] spec_insn_bgeu_rs2_addr;
  wire [                       4 : 0] spec_insn_bgeu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bgeu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bgeu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bgeu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bgeu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bgeu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bgeu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bgeu_csr_misa_rmask;
`endif

  rvfi_insn_bgeu insn_bgeu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_bgeu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_bgeu_valid),
    .spec_trap(spec_insn_bgeu_trap),
    .spec_rs1_addr(spec_insn_bgeu_rs1_addr),
    .spec_rs2_addr(spec_insn_bgeu_rs2_addr),
    .spec_rd_addr(spec_insn_bgeu_rd_addr),
    .spec_rd_wdata(spec_insn_bgeu_rd_wdata),
    .spec_pc_wdata(spec_insn_bgeu_pc_wdata),
    .spec_mem_addr(spec_insn_bgeu_mem_addr),
    .spec_mem_rmask(spec_insn_bgeu_mem_rmask),
    .spec_mem_wmask(spec_insn_bgeu_mem_wmask),
    .spec_mem_wdata(spec_insn_bgeu_mem_wdata)
  );

  wire                                spec_insn_blt_valid;
  wire                                spec_insn_blt_trap;
  wire [                       4 : 0] spec_insn_blt_rs1_addr;
  wire [                       4 : 0] spec_insn_blt_rs2_addr;
  wire [                       4 : 0] spec_insn_blt_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_blt_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_blt_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_blt_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_blt_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_blt_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_blt_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_blt_csr_misa_rmask;
`endif

  rvfi_insn_blt insn_blt (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_blt_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_blt_valid),
    .spec_trap(spec_insn_blt_trap),
    .spec_rs1_addr(spec_insn_blt_rs1_addr),
    .spec_rs2_addr(spec_insn_blt_rs2_addr),
    .spec_rd_addr(spec_insn_blt_rd_addr),
    .spec_rd_wdata(spec_insn_blt_rd_wdata),
    .spec_pc_wdata(spec_insn_blt_pc_wdata),
    .spec_mem_addr(spec_insn_blt_mem_addr),
    .spec_mem_rmask(spec_insn_blt_mem_rmask),
    .spec_mem_wmask(spec_insn_blt_mem_wmask),
    .spec_mem_wdata(spec_insn_blt_mem_wdata)
  );

  wire                                spec_insn_bltu_valid;
  wire                                spec_insn_bltu_trap;
  wire [                       4 : 0] spec_insn_bltu_rs1_addr;
  wire [                       4 : 0] spec_insn_bltu_rs2_addr;
  wire [                       4 : 0] spec_insn_bltu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bltu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bltu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bltu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bltu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bltu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bltu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bltu_csr_misa_rmask;
`endif

  rvfi_insn_bltu insn_bltu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_bltu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_bltu_valid),
    .spec_trap(spec_insn_bltu_trap),
    .spec_rs1_addr(spec_insn_bltu_rs1_addr),
    .spec_rs2_addr(spec_insn_bltu_rs2_addr),
    .spec_rd_addr(spec_insn_bltu_rd_addr),
    .spec_rd_wdata(spec_insn_bltu_rd_wdata),
    .spec_pc_wdata(spec_insn_bltu_pc_wdata),
    .spec_mem_addr(spec_insn_bltu_mem_addr),
    .spec_mem_rmask(spec_insn_bltu_mem_rmask),
    .spec_mem_wmask(spec_insn_bltu_mem_wmask),
    .spec_mem_wdata(spec_insn_bltu_mem_wdata)
  );

  wire                                spec_insn_bne_valid;
  wire                                spec_insn_bne_trap;
  wire [                       4 : 0] spec_insn_bne_rs1_addr;
  wire [                       4 : 0] spec_insn_bne_rs2_addr;
  wire [                       4 : 0] spec_insn_bne_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bne_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bne_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bne_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bne_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_bne_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bne_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_bne_csr_misa_rmask;
`endif

  rvfi_insn_bne insn_bne (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_bne_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_bne_valid),
    .spec_trap(spec_insn_bne_trap),
    .spec_rs1_addr(spec_insn_bne_rs1_addr),
    .spec_rs2_addr(spec_insn_bne_rs2_addr),
    .spec_rd_addr(spec_insn_bne_rd_addr),
    .spec_rd_wdata(spec_insn_bne_rd_wdata),
    .spec_pc_wdata(spec_insn_bne_pc_wdata),
    .spec_mem_addr(spec_insn_bne_mem_addr),
    .spec_mem_rmask(spec_insn_bne_mem_rmask),
    .spec_mem_wmask(spec_insn_bne_mem_wmask),
    .spec_mem_wdata(spec_insn_bne_mem_wdata)
  );

  wire                                spec_insn_c_add_valid;
  wire                                spec_insn_c_add_trap;
  wire [                       4 : 0] spec_insn_c_add_rs1_addr;
  wire [                       4 : 0] spec_insn_c_add_rs2_addr;
  wire [                       4 : 0] spec_insn_c_add_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_add_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_add_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_add_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_add_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_add_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_add_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_add_csr_misa_rmask;
`endif

  rvfi_insn_c_add insn_c_add (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_add_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_add_valid),
    .spec_trap(spec_insn_c_add_trap),
    .spec_rs1_addr(spec_insn_c_add_rs1_addr),
    .spec_rs2_addr(spec_insn_c_add_rs2_addr),
    .spec_rd_addr(spec_insn_c_add_rd_addr),
    .spec_rd_wdata(spec_insn_c_add_rd_wdata),
    .spec_pc_wdata(spec_insn_c_add_pc_wdata),
    .spec_mem_addr(spec_insn_c_add_mem_addr),
    .spec_mem_rmask(spec_insn_c_add_mem_rmask),
    .spec_mem_wmask(spec_insn_c_add_mem_wmask),
    .spec_mem_wdata(spec_insn_c_add_mem_wdata)
  );

  wire                                spec_insn_c_addi_valid;
  wire                                spec_insn_c_addi_trap;
  wire [                       4 : 0] spec_insn_c_addi_rs1_addr;
  wire [                       4 : 0] spec_insn_c_addi_rs2_addr;
  wire [                       4 : 0] spec_insn_c_addi_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi_csr_misa_rmask;
`endif

  rvfi_insn_c_addi insn_c_addi (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_addi_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_addi_valid),
    .spec_trap(spec_insn_c_addi_trap),
    .spec_rs1_addr(spec_insn_c_addi_rs1_addr),
    .spec_rs2_addr(spec_insn_c_addi_rs2_addr),
    .spec_rd_addr(spec_insn_c_addi_rd_addr),
    .spec_rd_wdata(spec_insn_c_addi_rd_wdata),
    .spec_pc_wdata(spec_insn_c_addi_pc_wdata),
    .spec_mem_addr(spec_insn_c_addi_mem_addr),
    .spec_mem_rmask(spec_insn_c_addi_mem_rmask),
    .spec_mem_wmask(spec_insn_c_addi_mem_wmask),
    .spec_mem_wdata(spec_insn_c_addi_mem_wdata)
  );

  wire                                spec_insn_c_addi16sp_valid;
  wire                                spec_insn_c_addi16sp_trap;
  wire [                       4 : 0] spec_insn_c_addi16sp_rs1_addr;
  wire [                       4 : 0] spec_insn_c_addi16sp_rs2_addr;
  wire [                       4 : 0] spec_insn_c_addi16sp_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi16sp_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi16sp_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi16sp_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi16sp_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi16sp_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi16sp_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi16sp_csr_misa_rmask;
`endif

  rvfi_insn_c_addi16sp insn_c_addi16sp (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_addi16sp_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_addi16sp_valid),
    .spec_trap(spec_insn_c_addi16sp_trap),
    .spec_rs1_addr(spec_insn_c_addi16sp_rs1_addr),
    .spec_rs2_addr(spec_insn_c_addi16sp_rs2_addr),
    .spec_rd_addr(spec_insn_c_addi16sp_rd_addr),
    .spec_rd_wdata(spec_insn_c_addi16sp_rd_wdata),
    .spec_pc_wdata(spec_insn_c_addi16sp_pc_wdata),
    .spec_mem_addr(spec_insn_c_addi16sp_mem_addr),
    .spec_mem_rmask(spec_insn_c_addi16sp_mem_rmask),
    .spec_mem_wmask(spec_insn_c_addi16sp_mem_wmask),
    .spec_mem_wdata(spec_insn_c_addi16sp_mem_wdata)
  );

  wire                                spec_insn_c_addi4spn_valid;
  wire                                spec_insn_c_addi4spn_trap;
  wire [                       4 : 0] spec_insn_c_addi4spn_rs1_addr;
  wire [                       4 : 0] spec_insn_c_addi4spn_rs2_addr;
  wire [                       4 : 0] spec_insn_c_addi4spn_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi4spn_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi4spn_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi4spn_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi4spn_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addi4spn_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi4spn_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addi4spn_csr_misa_rmask;
`endif

  rvfi_insn_c_addi4spn insn_c_addi4spn (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_addi4spn_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_addi4spn_valid),
    .spec_trap(spec_insn_c_addi4spn_trap),
    .spec_rs1_addr(spec_insn_c_addi4spn_rs1_addr),
    .spec_rs2_addr(spec_insn_c_addi4spn_rs2_addr),
    .spec_rd_addr(spec_insn_c_addi4spn_rd_addr),
    .spec_rd_wdata(spec_insn_c_addi4spn_rd_wdata),
    .spec_pc_wdata(spec_insn_c_addi4spn_pc_wdata),
    .spec_mem_addr(spec_insn_c_addi4spn_mem_addr),
    .spec_mem_rmask(spec_insn_c_addi4spn_mem_rmask),
    .spec_mem_wmask(spec_insn_c_addi4spn_mem_wmask),
    .spec_mem_wdata(spec_insn_c_addi4spn_mem_wdata)
  );

  wire                                spec_insn_c_addiw_valid;
  wire                                spec_insn_c_addiw_trap;
  wire [                       4 : 0] spec_insn_c_addiw_rs1_addr;
  wire [                       4 : 0] spec_insn_c_addiw_rs2_addr;
  wire [                       4 : 0] spec_insn_c_addiw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addiw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addiw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addiw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addiw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addiw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addiw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addiw_csr_misa_rmask;
`endif

  rvfi_insn_c_addiw insn_c_addiw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_addiw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_addiw_valid),
    .spec_trap(spec_insn_c_addiw_trap),
    .spec_rs1_addr(spec_insn_c_addiw_rs1_addr),
    .spec_rs2_addr(spec_insn_c_addiw_rs2_addr),
    .spec_rd_addr(spec_insn_c_addiw_rd_addr),
    .spec_rd_wdata(spec_insn_c_addiw_rd_wdata),
    .spec_pc_wdata(spec_insn_c_addiw_pc_wdata),
    .spec_mem_addr(spec_insn_c_addiw_mem_addr),
    .spec_mem_rmask(spec_insn_c_addiw_mem_rmask),
    .spec_mem_wmask(spec_insn_c_addiw_mem_wmask),
    .spec_mem_wdata(spec_insn_c_addiw_mem_wdata)
  );

  wire                                spec_insn_c_addw_valid;
  wire                                spec_insn_c_addw_trap;
  wire [                       4 : 0] spec_insn_c_addw_rs1_addr;
  wire [                       4 : 0] spec_insn_c_addw_rs2_addr;
  wire [                       4 : 0] spec_insn_c_addw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_addw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_addw_csr_misa_rmask;
`endif

  rvfi_insn_c_addw insn_c_addw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_addw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_addw_valid),
    .spec_trap(spec_insn_c_addw_trap),
    .spec_rs1_addr(spec_insn_c_addw_rs1_addr),
    .spec_rs2_addr(spec_insn_c_addw_rs2_addr),
    .spec_rd_addr(spec_insn_c_addw_rd_addr),
    .spec_rd_wdata(spec_insn_c_addw_rd_wdata),
    .spec_pc_wdata(spec_insn_c_addw_pc_wdata),
    .spec_mem_addr(spec_insn_c_addw_mem_addr),
    .spec_mem_rmask(spec_insn_c_addw_mem_rmask),
    .spec_mem_wmask(spec_insn_c_addw_mem_wmask),
    .spec_mem_wdata(spec_insn_c_addw_mem_wdata)
  );

  wire                                spec_insn_c_and_valid;
  wire                                spec_insn_c_and_trap;
  wire [                       4 : 0] spec_insn_c_and_rs1_addr;
  wire [                       4 : 0] spec_insn_c_and_rs2_addr;
  wire [                       4 : 0] spec_insn_c_and_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_and_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_and_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_and_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_and_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_and_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_and_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_and_csr_misa_rmask;
`endif

  rvfi_insn_c_and insn_c_and (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_and_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_and_valid),
    .spec_trap(spec_insn_c_and_trap),
    .spec_rs1_addr(spec_insn_c_and_rs1_addr),
    .spec_rs2_addr(spec_insn_c_and_rs2_addr),
    .spec_rd_addr(spec_insn_c_and_rd_addr),
    .spec_rd_wdata(spec_insn_c_and_rd_wdata),
    .spec_pc_wdata(spec_insn_c_and_pc_wdata),
    .spec_mem_addr(spec_insn_c_and_mem_addr),
    .spec_mem_rmask(spec_insn_c_and_mem_rmask),
    .spec_mem_wmask(spec_insn_c_and_mem_wmask),
    .spec_mem_wdata(spec_insn_c_and_mem_wdata)
  );

  wire                                spec_insn_c_andi_valid;
  wire                                spec_insn_c_andi_trap;
  wire [                       4 : 0] spec_insn_c_andi_rs1_addr;
  wire [                       4 : 0] spec_insn_c_andi_rs2_addr;
  wire [                       4 : 0] spec_insn_c_andi_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_andi_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_andi_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_andi_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_andi_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_andi_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_andi_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_andi_csr_misa_rmask;
`endif

  rvfi_insn_c_andi insn_c_andi (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_andi_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_andi_valid),
    .spec_trap(spec_insn_c_andi_trap),
    .spec_rs1_addr(spec_insn_c_andi_rs1_addr),
    .spec_rs2_addr(spec_insn_c_andi_rs2_addr),
    .spec_rd_addr(spec_insn_c_andi_rd_addr),
    .spec_rd_wdata(spec_insn_c_andi_rd_wdata),
    .spec_pc_wdata(spec_insn_c_andi_pc_wdata),
    .spec_mem_addr(spec_insn_c_andi_mem_addr),
    .spec_mem_rmask(spec_insn_c_andi_mem_rmask),
    .spec_mem_wmask(spec_insn_c_andi_mem_wmask),
    .spec_mem_wdata(spec_insn_c_andi_mem_wdata)
  );

  wire                                spec_insn_c_beqz_valid;
  wire                                spec_insn_c_beqz_trap;
  wire [                       4 : 0] spec_insn_c_beqz_rs1_addr;
  wire [                       4 : 0] spec_insn_c_beqz_rs2_addr;
  wire [                       4 : 0] spec_insn_c_beqz_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_beqz_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_beqz_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_beqz_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_beqz_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_beqz_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_beqz_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_beqz_csr_misa_rmask;
`endif

  rvfi_insn_c_beqz insn_c_beqz (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_beqz_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_beqz_valid),
    .spec_trap(spec_insn_c_beqz_trap),
    .spec_rs1_addr(spec_insn_c_beqz_rs1_addr),
    .spec_rs2_addr(spec_insn_c_beqz_rs2_addr),
    .spec_rd_addr(spec_insn_c_beqz_rd_addr),
    .spec_rd_wdata(spec_insn_c_beqz_rd_wdata),
    .spec_pc_wdata(spec_insn_c_beqz_pc_wdata),
    .spec_mem_addr(spec_insn_c_beqz_mem_addr),
    .spec_mem_rmask(spec_insn_c_beqz_mem_rmask),
    .spec_mem_wmask(spec_insn_c_beqz_mem_wmask),
    .spec_mem_wdata(spec_insn_c_beqz_mem_wdata)
  );

  wire                                spec_insn_c_bnez_valid;
  wire                                spec_insn_c_bnez_trap;
  wire [                       4 : 0] spec_insn_c_bnez_rs1_addr;
  wire [                       4 : 0] spec_insn_c_bnez_rs2_addr;
  wire [                       4 : 0] spec_insn_c_bnez_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_bnez_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_bnez_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_bnez_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_bnez_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_bnez_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_bnez_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_bnez_csr_misa_rmask;
`endif

  rvfi_insn_c_bnez insn_c_bnez (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_bnez_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_bnez_valid),
    .spec_trap(spec_insn_c_bnez_trap),
    .spec_rs1_addr(spec_insn_c_bnez_rs1_addr),
    .spec_rs2_addr(spec_insn_c_bnez_rs2_addr),
    .spec_rd_addr(spec_insn_c_bnez_rd_addr),
    .spec_rd_wdata(spec_insn_c_bnez_rd_wdata),
    .spec_pc_wdata(spec_insn_c_bnez_pc_wdata),
    .spec_mem_addr(spec_insn_c_bnez_mem_addr),
    .spec_mem_rmask(spec_insn_c_bnez_mem_rmask),
    .spec_mem_wmask(spec_insn_c_bnez_mem_wmask),
    .spec_mem_wdata(spec_insn_c_bnez_mem_wdata)
  );

  wire                                spec_insn_c_j_valid;
  wire                                spec_insn_c_j_trap;
  wire [                       4 : 0] spec_insn_c_j_rs1_addr;
  wire [                       4 : 0] spec_insn_c_j_rs2_addr;
  wire [                       4 : 0] spec_insn_c_j_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_j_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_j_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_j_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_j_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_j_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_j_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_j_csr_misa_rmask;
`endif

  rvfi_insn_c_j insn_c_j (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_j_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_j_valid),
    .spec_trap(spec_insn_c_j_trap),
    .spec_rs1_addr(spec_insn_c_j_rs1_addr),
    .spec_rs2_addr(spec_insn_c_j_rs2_addr),
    .spec_rd_addr(spec_insn_c_j_rd_addr),
    .spec_rd_wdata(spec_insn_c_j_rd_wdata),
    .spec_pc_wdata(spec_insn_c_j_pc_wdata),
    .spec_mem_addr(spec_insn_c_j_mem_addr),
    .spec_mem_rmask(spec_insn_c_j_mem_rmask),
    .spec_mem_wmask(spec_insn_c_j_mem_wmask),
    .spec_mem_wdata(spec_insn_c_j_mem_wdata)
  );

  wire                                spec_insn_c_jalr_valid;
  wire                                spec_insn_c_jalr_trap;
  wire [                       4 : 0] spec_insn_c_jalr_rs1_addr;
  wire [                       4 : 0] spec_insn_c_jalr_rs2_addr;
  wire [                       4 : 0] spec_insn_c_jalr_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jalr_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jalr_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jalr_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_jalr_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_jalr_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jalr_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jalr_csr_misa_rmask;
`endif

  rvfi_insn_c_jalr insn_c_jalr (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_jalr_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_jalr_valid),
    .spec_trap(spec_insn_c_jalr_trap),
    .spec_rs1_addr(spec_insn_c_jalr_rs1_addr),
    .spec_rs2_addr(spec_insn_c_jalr_rs2_addr),
    .spec_rd_addr(spec_insn_c_jalr_rd_addr),
    .spec_rd_wdata(spec_insn_c_jalr_rd_wdata),
    .spec_pc_wdata(spec_insn_c_jalr_pc_wdata),
    .spec_mem_addr(spec_insn_c_jalr_mem_addr),
    .spec_mem_rmask(spec_insn_c_jalr_mem_rmask),
    .spec_mem_wmask(spec_insn_c_jalr_mem_wmask),
    .spec_mem_wdata(spec_insn_c_jalr_mem_wdata)
  );

  wire                                spec_insn_c_jr_valid;
  wire                                spec_insn_c_jr_trap;
  wire [                       4 : 0] spec_insn_c_jr_rs1_addr;
  wire [                       4 : 0] spec_insn_c_jr_rs2_addr;
  wire [                       4 : 0] spec_insn_c_jr_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jr_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jr_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jr_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_jr_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_jr_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jr_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_jr_csr_misa_rmask;
`endif

  rvfi_insn_c_jr insn_c_jr (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_jr_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_jr_valid),
    .spec_trap(spec_insn_c_jr_trap),
    .spec_rs1_addr(spec_insn_c_jr_rs1_addr),
    .spec_rs2_addr(spec_insn_c_jr_rs2_addr),
    .spec_rd_addr(spec_insn_c_jr_rd_addr),
    .spec_rd_wdata(spec_insn_c_jr_rd_wdata),
    .spec_pc_wdata(spec_insn_c_jr_pc_wdata),
    .spec_mem_addr(spec_insn_c_jr_mem_addr),
    .spec_mem_rmask(spec_insn_c_jr_mem_rmask),
    .spec_mem_wmask(spec_insn_c_jr_mem_wmask),
    .spec_mem_wdata(spec_insn_c_jr_mem_wdata)
  );

  wire                                spec_insn_c_ld_valid;
  wire                                spec_insn_c_ld_trap;
  wire [                       4 : 0] spec_insn_c_ld_rs1_addr;
  wire [                       4 : 0] spec_insn_c_ld_rs2_addr;
  wire [                       4 : 0] spec_insn_c_ld_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ld_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ld_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ld_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_ld_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_ld_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ld_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ld_csr_misa_rmask;
`endif

  rvfi_insn_c_ld insn_c_ld (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_ld_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_ld_valid),
    .spec_trap(spec_insn_c_ld_trap),
    .spec_rs1_addr(spec_insn_c_ld_rs1_addr),
    .spec_rs2_addr(spec_insn_c_ld_rs2_addr),
    .spec_rd_addr(spec_insn_c_ld_rd_addr),
    .spec_rd_wdata(spec_insn_c_ld_rd_wdata),
    .spec_pc_wdata(spec_insn_c_ld_pc_wdata),
    .spec_mem_addr(spec_insn_c_ld_mem_addr),
    .spec_mem_rmask(spec_insn_c_ld_mem_rmask),
    .spec_mem_wmask(spec_insn_c_ld_mem_wmask),
    .spec_mem_wdata(spec_insn_c_ld_mem_wdata)
  );

  wire                                spec_insn_c_ldsp_valid;
  wire                                spec_insn_c_ldsp_trap;
  wire [                       4 : 0] spec_insn_c_ldsp_rs1_addr;
  wire [                       4 : 0] spec_insn_c_ldsp_rs2_addr;
  wire [                       4 : 0] spec_insn_c_ldsp_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ldsp_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ldsp_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ldsp_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_ldsp_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_ldsp_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ldsp_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_ldsp_csr_misa_rmask;
`endif

  rvfi_insn_c_ldsp insn_c_ldsp (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_ldsp_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_ldsp_valid),
    .spec_trap(spec_insn_c_ldsp_trap),
    .spec_rs1_addr(spec_insn_c_ldsp_rs1_addr),
    .spec_rs2_addr(spec_insn_c_ldsp_rs2_addr),
    .spec_rd_addr(spec_insn_c_ldsp_rd_addr),
    .spec_rd_wdata(spec_insn_c_ldsp_rd_wdata),
    .spec_pc_wdata(spec_insn_c_ldsp_pc_wdata),
    .spec_mem_addr(spec_insn_c_ldsp_mem_addr),
    .spec_mem_rmask(spec_insn_c_ldsp_mem_rmask),
    .spec_mem_wmask(spec_insn_c_ldsp_mem_wmask),
    .spec_mem_wdata(spec_insn_c_ldsp_mem_wdata)
  );

  wire                                spec_insn_c_li_valid;
  wire                                spec_insn_c_li_trap;
  wire [                       4 : 0] spec_insn_c_li_rs1_addr;
  wire [                       4 : 0] spec_insn_c_li_rs2_addr;
  wire [                       4 : 0] spec_insn_c_li_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_li_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_li_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_li_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_li_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_li_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_li_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_li_csr_misa_rmask;
`endif

  rvfi_insn_c_li insn_c_li (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_li_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_li_valid),
    .spec_trap(spec_insn_c_li_trap),
    .spec_rs1_addr(spec_insn_c_li_rs1_addr),
    .spec_rs2_addr(spec_insn_c_li_rs2_addr),
    .spec_rd_addr(spec_insn_c_li_rd_addr),
    .spec_rd_wdata(spec_insn_c_li_rd_wdata),
    .spec_pc_wdata(spec_insn_c_li_pc_wdata),
    .spec_mem_addr(spec_insn_c_li_mem_addr),
    .spec_mem_rmask(spec_insn_c_li_mem_rmask),
    .spec_mem_wmask(spec_insn_c_li_mem_wmask),
    .spec_mem_wdata(spec_insn_c_li_mem_wdata)
  );

  wire                                spec_insn_c_lui_valid;
  wire                                spec_insn_c_lui_trap;
  wire [                       4 : 0] spec_insn_c_lui_rs1_addr;
  wire [                       4 : 0] spec_insn_c_lui_rs2_addr;
  wire [                       4 : 0] spec_insn_c_lui_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lui_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lui_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lui_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lui_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lui_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lui_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lui_csr_misa_rmask;
`endif

  rvfi_insn_c_lui insn_c_lui (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_lui_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_lui_valid),
    .spec_trap(spec_insn_c_lui_trap),
    .spec_rs1_addr(spec_insn_c_lui_rs1_addr),
    .spec_rs2_addr(spec_insn_c_lui_rs2_addr),
    .spec_rd_addr(spec_insn_c_lui_rd_addr),
    .spec_rd_wdata(spec_insn_c_lui_rd_wdata),
    .spec_pc_wdata(spec_insn_c_lui_pc_wdata),
    .spec_mem_addr(spec_insn_c_lui_mem_addr),
    .spec_mem_rmask(spec_insn_c_lui_mem_rmask),
    .spec_mem_wmask(spec_insn_c_lui_mem_wmask),
    .spec_mem_wdata(spec_insn_c_lui_mem_wdata)
  );

  wire                                spec_insn_c_lw_valid;
  wire                                spec_insn_c_lw_trap;
  wire [                       4 : 0] spec_insn_c_lw_rs1_addr;
  wire [                       4 : 0] spec_insn_c_lw_rs2_addr;
  wire [                       4 : 0] spec_insn_c_lw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lw_csr_misa_rmask;
`endif

  rvfi_insn_c_lw insn_c_lw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_lw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_lw_valid),
    .spec_trap(spec_insn_c_lw_trap),
    .spec_rs1_addr(spec_insn_c_lw_rs1_addr),
    .spec_rs2_addr(spec_insn_c_lw_rs2_addr),
    .spec_rd_addr(spec_insn_c_lw_rd_addr),
    .spec_rd_wdata(spec_insn_c_lw_rd_wdata),
    .spec_pc_wdata(spec_insn_c_lw_pc_wdata),
    .spec_mem_addr(spec_insn_c_lw_mem_addr),
    .spec_mem_rmask(spec_insn_c_lw_mem_rmask),
    .spec_mem_wmask(spec_insn_c_lw_mem_wmask),
    .spec_mem_wdata(spec_insn_c_lw_mem_wdata)
  );

  wire                                spec_insn_c_lwsp_valid;
  wire                                spec_insn_c_lwsp_trap;
  wire [                       4 : 0] spec_insn_c_lwsp_rs1_addr;
  wire [                       4 : 0] spec_insn_c_lwsp_rs2_addr;
  wire [                       4 : 0] spec_insn_c_lwsp_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lwsp_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lwsp_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lwsp_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lwsp_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_lwsp_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lwsp_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_lwsp_csr_misa_rmask;
`endif

  rvfi_insn_c_lwsp insn_c_lwsp (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_lwsp_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_lwsp_valid),
    .spec_trap(spec_insn_c_lwsp_trap),
    .spec_rs1_addr(spec_insn_c_lwsp_rs1_addr),
    .spec_rs2_addr(spec_insn_c_lwsp_rs2_addr),
    .spec_rd_addr(spec_insn_c_lwsp_rd_addr),
    .spec_rd_wdata(spec_insn_c_lwsp_rd_wdata),
    .spec_pc_wdata(spec_insn_c_lwsp_pc_wdata),
    .spec_mem_addr(spec_insn_c_lwsp_mem_addr),
    .spec_mem_rmask(spec_insn_c_lwsp_mem_rmask),
    .spec_mem_wmask(spec_insn_c_lwsp_mem_wmask),
    .spec_mem_wdata(spec_insn_c_lwsp_mem_wdata)
  );

  wire                                spec_insn_c_mv_valid;
  wire                                spec_insn_c_mv_trap;
  wire [                       4 : 0] spec_insn_c_mv_rs1_addr;
  wire [                       4 : 0] spec_insn_c_mv_rs2_addr;
  wire [                       4 : 0] spec_insn_c_mv_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_mv_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_mv_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_mv_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_mv_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_mv_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_mv_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_mv_csr_misa_rmask;
`endif

  rvfi_insn_c_mv insn_c_mv (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_mv_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_mv_valid),
    .spec_trap(spec_insn_c_mv_trap),
    .spec_rs1_addr(spec_insn_c_mv_rs1_addr),
    .spec_rs2_addr(spec_insn_c_mv_rs2_addr),
    .spec_rd_addr(spec_insn_c_mv_rd_addr),
    .spec_rd_wdata(spec_insn_c_mv_rd_wdata),
    .spec_pc_wdata(spec_insn_c_mv_pc_wdata),
    .spec_mem_addr(spec_insn_c_mv_mem_addr),
    .spec_mem_rmask(spec_insn_c_mv_mem_rmask),
    .spec_mem_wmask(spec_insn_c_mv_mem_wmask),
    .spec_mem_wdata(spec_insn_c_mv_mem_wdata)
  );

  wire                                spec_insn_c_or_valid;
  wire                                spec_insn_c_or_trap;
  wire [                       4 : 0] spec_insn_c_or_rs1_addr;
  wire [                       4 : 0] spec_insn_c_or_rs2_addr;
  wire [                       4 : 0] spec_insn_c_or_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_or_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_or_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_or_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_or_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_or_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_or_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_or_csr_misa_rmask;
`endif

  rvfi_insn_c_or insn_c_or (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_or_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_or_valid),
    .spec_trap(spec_insn_c_or_trap),
    .spec_rs1_addr(spec_insn_c_or_rs1_addr),
    .spec_rs2_addr(spec_insn_c_or_rs2_addr),
    .spec_rd_addr(spec_insn_c_or_rd_addr),
    .spec_rd_wdata(spec_insn_c_or_rd_wdata),
    .spec_pc_wdata(spec_insn_c_or_pc_wdata),
    .spec_mem_addr(spec_insn_c_or_mem_addr),
    .spec_mem_rmask(spec_insn_c_or_mem_rmask),
    .spec_mem_wmask(spec_insn_c_or_mem_wmask),
    .spec_mem_wdata(spec_insn_c_or_mem_wdata)
  );

  wire                                spec_insn_c_sd_valid;
  wire                                spec_insn_c_sd_trap;
  wire [                       4 : 0] spec_insn_c_sd_rs1_addr;
  wire [                       4 : 0] spec_insn_c_sd_rs2_addr;
  wire [                       4 : 0] spec_insn_c_sd_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sd_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sd_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sd_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sd_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sd_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sd_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sd_csr_misa_rmask;
`endif

  rvfi_insn_c_sd insn_c_sd (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_sd_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_sd_valid),
    .spec_trap(spec_insn_c_sd_trap),
    .spec_rs1_addr(spec_insn_c_sd_rs1_addr),
    .spec_rs2_addr(spec_insn_c_sd_rs2_addr),
    .spec_rd_addr(spec_insn_c_sd_rd_addr),
    .spec_rd_wdata(spec_insn_c_sd_rd_wdata),
    .spec_pc_wdata(spec_insn_c_sd_pc_wdata),
    .spec_mem_addr(spec_insn_c_sd_mem_addr),
    .spec_mem_rmask(spec_insn_c_sd_mem_rmask),
    .spec_mem_wmask(spec_insn_c_sd_mem_wmask),
    .spec_mem_wdata(spec_insn_c_sd_mem_wdata)
  );

  wire                                spec_insn_c_sdsp_valid;
  wire                                spec_insn_c_sdsp_trap;
  wire [                       4 : 0] spec_insn_c_sdsp_rs1_addr;
  wire [                       4 : 0] spec_insn_c_sdsp_rs2_addr;
  wire [                       4 : 0] spec_insn_c_sdsp_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sdsp_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sdsp_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sdsp_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sdsp_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sdsp_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sdsp_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sdsp_csr_misa_rmask;
`endif

  rvfi_insn_c_sdsp insn_c_sdsp (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_sdsp_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_sdsp_valid),
    .spec_trap(spec_insn_c_sdsp_trap),
    .spec_rs1_addr(spec_insn_c_sdsp_rs1_addr),
    .spec_rs2_addr(spec_insn_c_sdsp_rs2_addr),
    .spec_rd_addr(spec_insn_c_sdsp_rd_addr),
    .spec_rd_wdata(spec_insn_c_sdsp_rd_wdata),
    .spec_pc_wdata(spec_insn_c_sdsp_pc_wdata),
    .spec_mem_addr(spec_insn_c_sdsp_mem_addr),
    .spec_mem_rmask(spec_insn_c_sdsp_mem_rmask),
    .spec_mem_wmask(spec_insn_c_sdsp_mem_wmask),
    .spec_mem_wdata(spec_insn_c_sdsp_mem_wdata)
  );

  wire                                spec_insn_c_slli_valid;
  wire                                spec_insn_c_slli_trap;
  wire [                       4 : 0] spec_insn_c_slli_rs1_addr;
  wire [                       4 : 0] spec_insn_c_slli_rs2_addr;
  wire [                       4 : 0] spec_insn_c_slli_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_slli_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_slli_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_slli_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_slli_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_slli_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_slli_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_slli_csr_misa_rmask;
`endif

  rvfi_insn_c_slli insn_c_slli (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_slli_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_slli_valid),
    .spec_trap(spec_insn_c_slli_trap),
    .spec_rs1_addr(spec_insn_c_slli_rs1_addr),
    .spec_rs2_addr(spec_insn_c_slli_rs2_addr),
    .spec_rd_addr(spec_insn_c_slli_rd_addr),
    .spec_rd_wdata(spec_insn_c_slli_rd_wdata),
    .spec_pc_wdata(spec_insn_c_slli_pc_wdata),
    .spec_mem_addr(spec_insn_c_slli_mem_addr),
    .spec_mem_rmask(spec_insn_c_slli_mem_rmask),
    .spec_mem_wmask(spec_insn_c_slli_mem_wmask),
    .spec_mem_wdata(spec_insn_c_slli_mem_wdata)
  );

  wire                                spec_insn_c_srai_valid;
  wire                                spec_insn_c_srai_trap;
  wire [                       4 : 0] spec_insn_c_srai_rs1_addr;
  wire [                       4 : 0] spec_insn_c_srai_rs2_addr;
  wire [                       4 : 0] spec_insn_c_srai_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srai_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srai_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srai_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_srai_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_srai_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srai_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srai_csr_misa_rmask;
`endif

  rvfi_insn_c_srai insn_c_srai (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_srai_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_srai_valid),
    .spec_trap(spec_insn_c_srai_trap),
    .spec_rs1_addr(spec_insn_c_srai_rs1_addr),
    .spec_rs2_addr(spec_insn_c_srai_rs2_addr),
    .spec_rd_addr(spec_insn_c_srai_rd_addr),
    .spec_rd_wdata(spec_insn_c_srai_rd_wdata),
    .spec_pc_wdata(spec_insn_c_srai_pc_wdata),
    .spec_mem_addr(spec_insn_c_srai_mem_addr),
    .spec_mem_rmask(spec_insn_c_srai_mem_rmask),
    .spec_mem_wmask(spec_insn_c_srai_mem_wmask),
    .spec_mem_wdata(spec_insn_c_srai_mem_wdata)
  );

  wire                                spec_insn_c_srli_valid;
  wire                                spec_insn_c_srli_trap;
  wire [                       4 : 0] spec_insn_c_srli_rs1_addr;
  wire [                       4 : 0] spec_insn_c_srli_rs2_addr;
  wire [                       4 : 0] spec_insn_c_srli_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srli_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srli_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srli_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_srli_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_srli_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srli_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_srli_csr_misa_rmask;
`endif

  rvfi_insn_c_srli insn_c_srli (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_srli_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_srli_valid),
    .spec_trap(spec_insn_c_srli_trap),
    .spec_rs1_addr(spec_insn_c_srli_rs1_addr),
    .spec_rs2_addr(spec_insn_c_srli_rs2_addr),
    .spec_rd_addr(spec_insn_c_srli_rd_addr),
    .spec_rd_wdata(spec_insn_c_srli_rd_wdata),
    .spec_pc_wdata(spec_insn_c_srli_pc_wdata),
    .spec_mem_addr(spec_insn_c_srli_mem_addr),
    .spec_mem_rmask(spec_insn_c_srli_mem_rmask),
    .spec_mem_wmask(spec_insn_c_srli_mem_wmask),
    .spec_mem_wdata(spec_insn_c_srli_mem_wdata)
  );

  wire                                spec_insn_c_sub_valid;
  wire                                spec_insn_c_sub_trap;
  wire [                       4 : 0] spec_insn_c_sub_rs1_addr;
  wire [                       4 : 0] spec_insn_c_sub_rs2_addr;
  wire [                       4 : 0] spec_insn_c_sub_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sub_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sub_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sub_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sub_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sub_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sub_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sub_csr_misa_rmask;
`endif

  rvfi_insn_c_sub insn_c_sub (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_sub_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_sub_valid),
    .spec_trap(spec_insn_c_sub_trap),
    .spec_rs1_addr(spec_insn_c_sub_rs1_addr),
    .spec_rs2_addr(spec_insn_c_sub_rs2_addr),
    .spec_rd_addr(spec_insn_c_sub_rd_addr),
    .spec_rd_wdata(spec_insn_c_sub_rd_wdata),
    .spec_pc_wdata(spec_insn_c_sub_pc_wdata),
    .spec_mem_addr(spec_insn_c_sub_mem_addr),
    .spec_mem_rmask(spec_insn_c_sub_mem_rmask),
    .spec_mem_wmask(spec_insn_c_sub_mem_wmask),
    .spec_mem_wdata(spec_insn_c_sub_mem_wdata)
  );

  wire                                spec_insn_c_subw_valid;
  wire                                spec_insn_c_subw_trap;
  wire [                       4 : 0] spec_insn_c_subw_rs1_addr;
  wire [                       4 : 0] spec_insn_c_subw_rs2_addr;
  wire [                       4 : 0] spec_insn_c_subw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_subw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_subw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_subw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_subw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_subw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_subw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_subw_csr_misa_rmask;
`endif

  rvfi_insn_c_subw insn_c_subw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_subw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_subw_valid),
    .spec_trap(spec_insn_c_subw_trap),
    .spec_rs1_addr(spec_insn_c_subw_rs1_addr),
    .spec_rs2_addr(spec_insn_c_subw_rs2_addr),
    .spec_rd_addr(spec_insn_c_subw_rd_addr),
    .spec_rd_wdata(spec_insn_c_subw_rd_wdata),
    .spec_pc_wdata(spec_insn_c_subw_pc_wdata),
    .spec_mem_addr(spec_insn_c_subw_mem_addr),
    .spec_mem_rmask(spec_insn_c_subw_mem_rmask),
    .spec_mem_wmask(spec_insn_c_subw_mem_wmask),
    .spec_mem_wdata(spec_insn_c_subw_mem_wdata)
  );

  wire                                spec_insn_c_sw_valid;
  wire                                spec_insn_c_sw_trap;
  wire [                       4 : 0] spec_insn_c_sw_rs1_addr;
  wire [                       4 : 0] spec_insn_c_sw_rs2_addr;
  wire [                       4 : 0] spec_insn_c_sw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_sw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_sw_csr_misa_rmask;
`endif

  rvfi_insn_c_sw insn_c_sw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_sw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_sw_valid),
    .spec_trap(spec_insn_c_sw_trap),
    .spec_rs1_addr(spec_insn_c_sw_rs1_addr),
    .spec_rs2_addr(spec_insn_c_sw_rs2_addr),
    .spec_rd_addr(spec_insn_c_sw_rd_addr),
    .spec_rd_wdata(spec_insn_c_sw_rd_wdata),
    .spec_pc_wdata(spec_insn_c_sw_pc_wdata),
    .spec_mem_addr(spec_insn_c_sw_mem_addr),
    .spec_mem_rmask(spec_insn_c_sw_mem_rmask),
    .spec_mem_wmask(spec_insn_c_sw_mem_wmask),
    .spec_mem_wdata(spec_insn_c_sw_mem_wdata)
  );

  wire                                spec_insn_c_swsp_valid;
  wire                                spec_insn_c_swsp_trap;
  wire [                       4 : 0] spec_insn_c_swsp_rs1_addr;
  wire [                       4 : 0] spec_insn_c_swsp_rs2_addr;
  wire [                       4 : 0] spec_insn_c_swsp_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_swsp_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_swsp_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_swsp_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_swsp_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_swsp_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_swsp_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_swsp_csr_misa_rmask;
`endif

  rvfi_insn_c_swsp insn_c_swsp (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_swsp_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_swsp_valid),
    .spec_trap(spec_insn_c_swsp_trap),
    .spec_rs1_addr(spec_insn_c_swsp_rs1_addr),
    .spec_rs2_addr(spec_insn_c_swsp_rs2_addr),
    .spec_rd_addr(spec_insn_c_swsp_rd_addr),
    .spec_rd_wdata(spec_insn_c_swsp_rd_wdata),
    .spec_pc_wdata(spec_insn_c_swsp_pc_wdata),
    .spec_mem_addr(spec_insn_c_swsp_mem_addr),
    .spec_mem_rmask(spec_insn_c_swsp_mem_rmask),
    .spec_mem_wmask(spec_insn_c_swsp_mem_wmask),
    .spec_mem_wdata(spec_insn_c_swsp_mem_wdata)
  );

  wire                                spec_insn_c_xor_valid;
  wire                                spec_insn_c_xor_trap;
  wire [                       4 : 0] spec_insn_c_xor_rs1_addr;
  wire [                       4 : 0] spec_insn_c_xor_rs2_addr;
  wire [                       4 : 0] spec_insn_c_xor_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_xor_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_xor_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_xor_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_xor_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_c_xor_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_xor_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_c_xor_csr_misa_rmask;
`endif

  rvfi_insn_c_xor insn_c_xor (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_c_xor_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_c_xor_valid),
    .spec_trap(spec_insn_c_xor_trap),
    .spec_rs1_addr(spec_insn_c_xor_rs1_addr),
    .spec_rs2_addr(spec_insn_c_xor_rs2_addr),
    .spec_rd_addr(spec_insn_c_xor_rd_addr),
    .spec_rd_wdata(spec_insn_c_xor_rd_wdata),
    .spec_pc_wdata(spec_insn_c_xor_pc_wdata),
    .spec_mem_addr(spec_insn_c_xor_mem_addr),
    .spec_mem_rmask(spec_insn_c_xor_mem_rmask),
    .spec_mem_wmask(spec_insn_c_xor_mem_wmask),
    .spec_mem_wdata(spec_insn_c_xor_mem_wdata)
  );

  wire                                spec_insn_div_valid;
  wire                                spec_insn_div_trap;
  wire [                       4 : 0] spec_insn_div_rs1_addr;
  wire [                       4 : 0] spec_insn_div_rs2_addr;
  wire [                       4 : 0] spec_insn_div_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_div_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_div_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_div_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_div_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_div_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_div_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_div_csr_misa_rmask;
`endif

  rvfi_insn_div insn_div (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_div_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_div_valid),
    .spec_trap(spec_insn_div_trap),
    .spec_rs1_addr(spec_insn_div_rs1_addr),
    .spec_rs2_addr(spec_insn_div_rs2_addr),
    .spec_rd_addr(spec_insn_div_rd_addr),
    .spec_rd_wdata(spec_insn_div_rd_wdata),
    .spec_pc_wdata(spec_insn_div_pc_wdata),
    .spec_mem_addr(spec_insn_div_mem_addr),
    .spec_mem_rmask(spec_insn_div_mem_rmask),
    .spec_mem_wmask(spec_insn_div_mem_wmask),
    .spec_mem_wdata(spec_insn_div_mem_wdata)
  );

  wire                                spec_insn_divu_valid;
  wire                                spec_insn_divu_trap;
  wire [                       4 : 0] spec_insn_divu_rs1_addr;
  wire [                       4 : 0] spec_insn_divu_rs2_addr;
  wire [                       4 : 0] spec_insn_divu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divu_csr_misa_rmask;
`endif

  rvfi_insn_divu insn_divu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_divu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_divu_valid),
    .spec_trap(spec_insn_divu_trap),
    .spec_rs1_addr(spec_insn_divu_rs1_addr),
    .spec_rs2_addr(spec_insn_divu_rs2_addr),
    .spec_rd_addr(spec_insn_divu_rd_addr),
    .spec_rd_wdata(spec_insn_divu_rd_wdata),
    .spec_pc_wdata(spec_insn_divu_pc_wdata),
    .spec_mem_addr(spec_insn_divu_mem_addr),
    .spec_mem_rmask(spec_insn_divu_mem_rmask),
    .spec_mem_wmask(spec_insn_divu_mem_wmask),
    .spec_mem_wdata(spec_insn_divu_mem_wdata)
  );

  wire                                spec_insn_divuw_valid;
  wire                                spec_insn_divuw_trap;
  wire [                       4 : 0] spec_insn_divuw_rs1_addr;
  wire [                       4 : 0] spec_insn_divuw_rs2_addr;
  wire [                       4 : 0] spec_insn_divuw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divuw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divuw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divuw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divuw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divuw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divuw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divuw_csr_misa_rmask;
`endif

  rvfi_insn_divuw insn_divuw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_divuw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_divuw_valid),
    .spec_trap(spec_insn_divuw_trap),
    .spec_rs1_addr(spec_insn_divuw_rs1_addr),
    .spec_rs2_addr(spec_insn_divuw_rs2_addr),
    .spec_rd_addr(spec_insn_divuw_rd_addr),
    .spec_rd_wdata(spec_insn_divuw_rd_wdata),
    .spec_pc_wdata(spec_insn_divuw_pc_wdata),
    .spec_mem_addr(spec_insn_divuw_mem_addr),
    .spec_mem_rmask(spec_insn_divuw_mem_rmask),
    .spec_mem_wmask(spec_insn_divuw_mem_wmask),
    .spec_mem_wdata(spec_insn_divuw_mem_wdata)
  );

  wire                                spec_insn_divw_valid;
  wire                                spec_insn_divw_trap;
  wire [                       4 : 0] spec_insn_divw_rs1_addr;
  wire [                       4 : 0] spec_insn_divw_rs2_addr;
  wire [                       4 : 0] spec_insn_divw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_divw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_divw_csr_misa_rmask;
`endif

  rvfi_insn_divw insn_divw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_divw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_divw_valid),
    .spec_trap(spec_insn_divw_trap),
    .spec_rs1_addr(spec_insn_divw_rs1_addr),
    .spec_rs2_addr(spec_insn_divw_rs2_addr),
    .spec_rd_addr(spec_insn_divw_rd_addr),
    .spec_rd_wdata(spec_insn_divw_rd_wdata),
    .spec_pc_wdata(spec_insn_divw_pc_wdata),
    .spec_mem_addr(spec_insn_divw_mem_addr),
    .spec_mem_rmask(spec_insn_divw_mem_rmask),
    .spec_mem_wmask(spec_insn_divw_mem_wmask),
    .spec_mem_wdata(spec_insn_divw_mem_wdata)
  );

  wire                                spec_insn_jal_valid;
  wire                                spec_insn_jal_trap;
  wire [                       4 : 0] spec_insn_jal_rs1_addr;
  wire [                       4 : 0] spec_insn_jal_rs2_addr;
  wire [                       4 : 0] spec_insn_jal_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jal_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jal_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jal_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_jal_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_jal_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jal_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jal_csr_misa_rmask;
`endif

  rvfi_insn_jal insn_jal (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_jal_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_jal_valid),
    .spec_trap(spec_insn_jal_trap),
    .spec_rs1_addr(spec_insn_jal_rs1_addr),
    .spec_rs2_addr(spec_insn_jal_rs2_addr),
    .spec_rd_addr(spec_insn_jal_rd_addr),
    .spec_rd_wdata(spec_insn_jal_rd_wdata),
    .spec_pc_wdata(spec_insn_jal_pc_wdata),
    .spec_mem_addr(spec_insn_jal_mem_addr),
    .spec_mem_rmask(spec_insn_jal_mem_rmask),
    .spec_mem_wmask(spec_insn_jal_mem_wmask),
    .spec_mem_wdata(spec_insn_jal_mem_wdata)
  );

  wire                                spec_insn_jalr_valid;
  wire                                spec_insn_jalr_trap;
  wire [                       4 : 0] spec_insn_jalr_rs1_addr;
  wire [                       4 : 0] spec_insn_jalr_rs2_addr;
  wire [                       4 : 0] spec_insn_jalr_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jalr_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jalr_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jalr_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_jalr_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_jalr_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jalr_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_jalr_csr_misa_rmask;
`endif

  rvfi_insn_jalr insn_jalr (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_jalr_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_jalr_valid),
    .spec_trap(spec_insn_jalr_trap),
    .spec_rs1_addr(spec_insn_jalr_rs1_addr),
    .spec_rs2_addr(spec_insn_jalr_rs2_addr),
    .spec_rd_addr(spec_insn_jalr_rd_addr),
    .spec_rd_wdata(spec_insn_jalr_rd_wdata),
    .spec_pc_wdata(spec_insn_jalr_pc_wdata),
    .spec_mem_addr(spec_insn_jalr_mem_addr),
    .spec_mem_rmask(spec_insn_jalr_mem_rmask),
    .spec_mem_wmask(spec_insn_jalr_mem_wmask),
    .spec_mem_wdata(spec_insn_jalr_mem_wdata)
  );

  wire                                spec_insn_lb_valid;
  wire                                spec_insn_lb_trap;
  wire [                       4 : 0] spec_insn_lb_rs1_addr;
  wire [                       4 : 0] spec_insn_lb_rs2_addr;
  wire [                       4 : 0] spec_insn_lb_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lb_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lb_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lb_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lb_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lb_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lb_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lb_csr_misa_rmask;
`endif

  rvfi_insn_lb insn_lb (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lb_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lb_valid),
    .spec_trap(spec_insn_lb_trap),
    .spec_rs1_addr(spec_insn_lb_rs1_addr),
    .spec_rs2_addr(spec_insn_lb_rs2_addr),
    .spec_rd_addr(spec_insn_lb_rd_addr),
    .spec_rd_wdata(spec_insn_lb_rd_wdata),
    .spec_pc_wdata(spec_insn_lb_pc_wdata),
    .spec_mem_addr(spec_insn_lb_mem_addr),
    .spec_mem_rmask(spec_insn_lb_mem_rmask),
    .spec_mem_wmask(spec_insn_lb_mem_wmask),
    .spec_mem_wdata(spec_insn_lb_mem_wdata)
  );

  wire                                spec_insn_lbu_valid;
  wire                                spec_insn_lbu_trap;
  wire [                       4 : 0] spec_insn_lbu_rs1_addr;
  wire [                       4 : 0] spec_insn_lbu_rs2_addr;
  wire [                       4 : 0] spec_insn_lbu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lbu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lbu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lbu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lbu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lbu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lbu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lbu_csr_misa_rmask;
`endif

  rvfi_insn_lbu insn_lbu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lbu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lbu_valid),
    .spec_trap(spec_insn_lbu_trap),
    .spec_rs1_addr(spec_insn_lbu_rs1_addr),
    .spec_rs2_addr(spec_insn_lbu_rs2_addr),
    .spec_rd_addr(spec_insn_lbu_rd_addr),
    .spec_rd_wdata(spec_insn_lbu_rd_wdata),
    .spec_pc_wdata(spec_insn_lbu_pc_wdata),
    .spec_mem_addr(spec_insn_lbu_mem_addr),
    .spec_mem_rmask(spec_insn_lbu_mem_rmask),
    .spec_mem_wmask(spec_insn_lbu_mem_wmask),
    .spec_mem_wdata(spec_insn_lbu_mem_wdata)
  );

  wire                                spec_insn_ld_valid;
  wire                                spec_insn_ld_trap;
  wire [                       4 : 0] spec_insn_ld_rs1_addr;
  wire [                       4 : 0] spec_insn_ld_rs2_addr;
  wire [                       4 : 0] spec_insn_ld_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ld_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ld_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ld_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_ld_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_ld_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ld_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ld_csr_misa_rmask;
`endif

  rvfi_insn_ld insn_ld (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_ld_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_ld_valid),
    .spec_trap(spec_insn_ld_trap),
    .spec_rs1_addr(spec_insn_ld_rs1_addr),
    .spec_rs2_addr(spec_insn_ld_rs2_addr),
    .spec_rd_addr(spec_insn_ld_rd_addr),
    .spec_rd_wdata(spec_insn_ld_rd_wdata),
    .spec_pc_wdata(spec_insn_ld_pc_wdata),
    .spec_mem_addr(spec_insn_ld_mem_addr),
    .spec_mem_rmask(spec_insn_ld_mem_rmask),
    .spec_mem_wmask(spec_insn_ld_mem_wmask),
    .spec_mem_wdata(spec_insn_ld_mem_wdata)
  );

  wire                                spec_insn_lh_valid;
  wire                                spec_insn_lh_trap;
  wire [                       4 : 0] spec_insn_lh_rs1_addr;
  wire [                       4 : 0] spec_insn_lh_rs2_addr;
  wire [                       4 : 0] spec_insn_lh_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lh_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lh_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lh_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lh_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lh_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lh_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lh_csr_misa_rmask;
`endif

  rvfi_insn_lh insn_lh (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lh_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lh_valid),
    .spec_trap(spec_insn_lh_trap),
    .spec_rs1_addr(spec_insn_lh_rs1_addr),
    .spec_rs2_addr(spec_insn_lh_rs2_addr),
    .spec_rd_addr(spec_insn_lh_rd_addr),
    .spec_rd_wdata(spec_insn_lh_rd_wdata),
    .spec_pc_wdata(spec_insn_lh_pc_wdata),
    .spec_mem_addr(spec_insn_lh_mem_addr),
    .spec_mem_rmask(spec_insn_lh_mem_rmask),
    .spec_mem_wmask(spec_insn_lh_mem_wmask),
    .spec_mem_wdata(spec_insn_lh_mem_wdata)
  );

  wire                                spec_insn_lhu_valid;
  wire                                spec_insn_lhu_trap;
  wire [                       4 : 0] spec_insn_lhu_rs1_addr;
  wire [                       4 : 0] spec_insn_lhu_rs2_addr;
  wire [                       4 : 0] spec_insn_lhu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lhu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lhu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lhu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lhu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lhu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lhu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lhu_csr_misa_rmask;
`endif

  rvfi_insn_lhu insn_lhu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lhu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lhu_valid),
    .spec_trap(spec_insn_lhu_trap),
    .spec_rs1_addr(spec_insn_lhu_rs1_addr),
    .spec_rs2_addr(spec_insn_lhu_rs2_addr),
    .spec_rd_addr(spec_insn_lhu_rd_addr),
    .spec_rd_wdata(spec_insn_lhu_rd_wdata),
    .spec_pc_wdata(spec_insn_lhu_pc_wdata),
    .spec_mem_addr(spec_insn_lhu_mem_addr),
    .spec_mem_rmask(spec_insn_lhu_mem_rmask),
    .spec_mem_wmask(spec_insn_lhu_mem_wmask),
    .spec_mem_wdata(spec_insn_lhu_mem_wdata)
  );

  wire                                spec_insn_lui_valid;
  wire                                spec_insn_lui_trap;
  wire [                       4 : 0] spec_insn_lui_rs1_addr;
  wire [                       4 : 0] spec_insn_lui_rs2_addr;
  wire [                       4 : 0] spec_insn_lui_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lui_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lui_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lui_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lui_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lui_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lui_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lui_csr_misa_rmask;
`endif

  rvfi_insn_lui insn_lui (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lui_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lui_valid),
    .spec_trap(spec_insn_lui_trap),
    .spec_rs1_addr(spec_insn_lui_rs1_addr),
    .spec_rs2_addr(spec_insn_lui_rs2_addr),
    .spec_rd_addr(spec_insn_lui_rd_addr),
    .spec_rd_wdata(spec_insn_lui_rd_wdata),
    .spec_pc_wdata(spec_insn_lui_pc_wdata),
    .spec_mem_addr(spec_insn_lui_mem_addr),
    .spec_mem_rmask(spec_insn_lui_mem_rmask),
    .spec_mem_wmask(spec_insn_lui_mem_wmask),
    .spec_mem_wdata(spec_insn_lui_mem_wdata)
  );

  wire                                spec_insn_lw_valid;
  wire                                spec_insn_lw_trap;
  wire [                       4 : 0] spec_insn_lw_rs1_addr;
  wire [                       4 : 0] spec_insn_lw_rs2_addr;
  wire [                       4 : 0] spec_insn_lw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lw_csr_misa_rmask;
`endif

  rvfi_insn_lw insn_lw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lw_valid),
    .spec_trap(spec_insn_lw_trap),
    .spec_rs1_addr(spec_insn_lw_rs1_addr),
    .spec_rs2_addr(spec_insn_lw_rs2_addr),
    .spec_rd_addr(spec_insn_lw_rd_addr),
    .spec_rd_wdata(spec_insn_lw_rd_wdata),
    .spec_pc_wdata(spec_insn_lw_pc_wdata),
    .spec_mem_addr(spec_insn_lw_mem_addr),
    .spec_mem_rmask(spec_insn_lw_mem_rmask),
    .spec_mem_wmask(spec_insn_lw_mem_wmask),
    .spec_mem_wdata(spec_insn_lw_mem_wdata)
  );

  wire                                spec_insn_lwu_valid;
  wire                                spec_insn_lwu_trap;
  wire [                       4 : 0] spec_insn_lwu_rs1_addr;
  wire [                       4 : 0] spec_insn_lwu_rs2_addr;
  wire [                       4 : 0] spec_insn_lwu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lwu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lwu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lwu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lwu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_lwu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lwu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_lwu_csr_misa_rmask;
`endif

  rvfi_insn_lwu insn_lwu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_lwu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_lwu_valid),
    .spec_trap(spec_insn_lwu_trap),
    .spec_rs1_addr(spec_insn_lwu_rs1_addr),
    .spec_rs2_addr(spec_insn_lwu_rs2_addr),
    .spec_rd_addr(spec_insn_lwu_rd_addr),
    .spec_rd_wdata(spec_insn_lwu_rd_wdata),
    .spec_pc_wdata(spec_insn_lwu_pc_wdata),
    .spec_mem_addr(spec_insn_lwu_mem_addr),
    .spec_mem_rmask(spec_insn_lwu_mem_rmask),
    .spec_mem_wmask(spec_insn_lwu_mem_wmask),
    .spec_mem_wdata(spec_insn_lwu_mem_wdata)
  );

  wire                                spec_insn_mul_valid;
  wire                                spec_insn_mul_trap;
  wire [                       4 : 0] spec_insn_mul_rs1_addr;
  wire [                       4 : 0] spec_insn_mul_rs2_addr;
  wire [                       4 : 0] spec_insn_mul_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mul_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mul_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mul_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mul_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mul_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mul_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mul_csr_misa_rmask;
`endif

  rvfi_insn_mul insn_mul (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_mul_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_mul_valid),
    .spec_trap(spec_insn_mul_trap),
    .spec_rs1_addr(spec_insn_mul_rs1_addr),
    .spec_rs2_addr(spec_insn_mul_rs2_addr),
    .spec_rd_addr(spec_insn_mul_rd_addr),
    .spec_rd_wdata(spec_insn_mul_rd_wdata),
    .spec_pc_wdata(spec_insn_mul_pc_wdata),
    .spec_mem_addr(spec_insn_mul_mem_addr),
    .spec_mem_rmask(spec_insn_mul_mem_rmask),
    .spec_mem_wmask(spec_insn_mul_mem_wmask),
    .spec_mem_wdata(spec_insn_mul_mem_wdata)
  );

  wire                                spec_insn_mulh_valid;
  wire                                spec_insn_mulh_trap;
  wire [                       4 : 0] spec_insn_mulh_rs1_addr;
  wire [                       4 : 0] spec_insn_mulh_rs2_addr;
  wire [                       4 : 0] spec_insn_mulh_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulh_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulh_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulh_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulh_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulh_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulh_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulh_csr_misa_rmask;
`endif

  rvfi_insn_mulh insn_mulh (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_mulh_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_mulh_valid),
    .spec_trap(spec_insn_mulh_trap),
    .spec_rs1_addr(spec_insn_mulh_rs1_addr),
    .spec_rs2_addr(spec_insn_mulh_rs2_addr),
    .spec_rd_addr(spec_insn_mulh_rd_addr),
    .spec_rd_wdata(spec_insn_mulh_rd_wdata),
    .spec_pc_wdata(spec_insn_mulh_pc_wdata),
    .spec_mem_addr(spec_insn_mulh_mem_addr),
    .spec_mem_rmask(spec_insn_mulh_mem_rmask),
    .spec_mem_wmask(spec_insn_mulh_mem_wmask),
    .spec_mem_wdata(spec_insn_mulh_mem_wdata)
  );

  wire                                spec_insn_mulhsu_valid;
  wire                                spec_insn_mulhsu_trap;
  wire [                       4 : 0] spec_insn_mulhsu_rs1_addr;
  wire [                       4 : 0] spec_insn_mulhsu_rs2_addr;
  wire [                       4 : 0] spec_insn_mulhsu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhsu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhsu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhsu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulhsu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulhsu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhsu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhsu_csr_misa_rmask;
`endif

  rvfi_insn_mulhsu insn_mulhsu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_mulhsu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_mulhsu_valid),
    .spec_trap(spec_insn_mulhsu_trap),
    .spec_rs1_addr(spec_insn_mulhsu_rs1_addr),
    .spec_rs2_addr(spec_insn_mulhsu_rs2_addr),
    .spec_rd_addr(spec_insn_mulhsu_rd_addr),
    .spec_rd_wdata(spec_insn_mulhsu_rd_wdata),
    .spec_pc_wdata(spec_insn_mulhsu_pc_wdata),
    .spec_mem_addr(spec_insn_mulhsu_mem_addr),
    .spec_mem_rmask(spec_insn_mulhsu_mem_rmask),
    .spec_mem_wmask(spec_insn_mulhsu_mem_wmask),
    .spec_mem_wdata(spec_insn_mulhsu_mem_wdata)
  );

  wire                                spec_insn_mulhu_valid;
  wire                                spec_insn_mulhu_trap;
  wire [                       4 : 0] spec_insn_mulhu_rs1_addr;
  wire [                       4 : 0] spec_insn_mulhu_rs2_addr;
  wire [                       4 : 0] spec_insn_mulhu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulhu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulhu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulhu_csr_misa_rmask;
`endif

  rvfi_insn_mulhu insn_mulhu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_mulhu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_mulhu_valid),
    .spec_trap(spec_insn_mulhu_trap),
    .spec_rs1_addr(spec_insn_mulhu_rs1_addr),
    .spec_rs2_addr(spec_insn_mulhu_rs2_addr),
    .spec_rd_addr(spec_insn_mulhu_rd_addr),
    .spec_rd_wdata(spec_insn_mulhu_rd_wdata),
    .spec_pc_wdata(spec_insn_mulhu_pc_wdata),
    .spec_mem_addr(spec_insn_mulhu_mem_addr),
    .spec_mem_rmask(spec_insn_mulhu_mem_rmask),
    .spec_mem_wmask(spec_insn_mulhu_mem_wmask),
    .spec_mem_wdata(spec_insn_mulhu_mem_wdata)
  );

  wire                                spec_insn_mulw_valid;
  wire                                spec_insn_mulw_trap;
  wire [                       4 : 0] spec_insn_mulw_rs1_addr;
  wire [                       4 : 0] spec_insn_mulw_rs2_addr;
  wire [                       4 : 0] spec_insn_mulw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_mulw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_mulw_csr_misa_rmask;
`endif

  rvfi_insn_mulw insn_mulw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_mulw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_mulw_valid),
    .spec_trap(spec_insn_mulw_trap),
    .spec_rs1_addr(spec_insn_mulw_rs1_addr),
    .spec_rs2_addr(spec_insn_mulw_rs2_addr),
    .spec_rd_addr(spec_insn_mulw_rd_addr),
    .spec_rd_wdata(spec_insn_mulw_rd_wdata),
    .spec_pc_wdata(spec_insn_mulw_pc_wdata),
    .spec_mem_addr(spec_insn_mulw_mem_addr),
    .spec_mem_rmask(spec_insn_mulw_mem_rmask),
    .spec_mem_wmask(spec_insn_mulw_mem_wmask),
    .spec_mem_wdata(spec_insn_mulw_mem_wdata)
  );

  wire                                spec_insn_or_valid;
  wire                                spec_insn_or_trap;
  wire [                       4 : 0] spec_insn_or_rs1_addr;
  wire [                       4 : 0] spec_insn_or_rs2_addr;
  wire [                       4 : 0] spec_insn_or_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_or_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_or_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_or_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_or_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_or_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_or_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_or_csr_misa_rmask;
`endif

  rvfi_insn_or insn_or (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_or_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_or_valid),
    .spec_trap(spec_insn_or_trap),
    .spec_rs1_addr(spec_insn_or_rs1_addr),
    .spec_rs2_addr(spec_insn_or_rs2_addr),
    .spec_rd_addr(spec_insn_or_rd_addr),
    .spec_rd_wdata(spec_insn_or_rd_wdata),
    .spec_pc_wdata(spec_insn_or_pc_wdata),
    .spec_mem_addr(spec_insn_or_mem_addr),
    .spec_mem_rmask(spec_insn_or_mem_rmask),
    .spec_mem_wmask(spec_insn_or_mem_wmask),
    .spec_mem_wdata(spec_insn_or_mem_wdata)
  );

  wire                                spec_insn_ori_valid;
  wire                                spec_insn_ori_trap;
  wire [                       4 : 0] spec_insn_ori_rs1_addr;
  wire [                       4 : 0] spec_insn_ori_rs2_addr;
  wire [                       4 : 0] spec_insn_ori_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ori_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ori_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ori_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_ori_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_ori_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ori_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_ori_csr_misa_rmask;
`endif

  rvfi_insn_ori insn_ori (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_ori_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_ori_valid),
    .spec_trap(spec_insn_ori_trap),
    .spec_rs1_addr(spec_insn_ori_rs1_addr),
    .spec_rs2_addr(spec_insn_ori_rs2_addr),
    .spec_rd_addr(spec_insn_ori_rd_addr),
    .spec_rd_wdata(spec_insn_ori_rd_wdata),
    .spec_pc_wdata(spec_insn_ori_pc_wdata),
    .spec_mem_addr(spec_insn_ori_mem_addr),
    .spec_mem_rmask(spec_insn_ori_mem_rmask),
    .spec_mem_wmask(spec_insn_ori_mem_wmask),
    .spec_mem_wdata(spec_insn_ori_mem_wdata)
  );

  wire                                spec_insn_rem_valid;
  wire                                spec_insn_rem_trap;
  wire [                       4 : 0] spec_insn_rem_rs1_addr;
  wire [                       4 : 0] spec_insn_rem_rs2_addr;
  wire [                       4 : 0] spec_insn_rem_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_rem_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_rem_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_rem_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_rem_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_rem_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_rem_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_rem_csr_misa_rmask;
`endif

  rvfi_insn_rem insn_rem (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_rem_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_rem_valid),
    .spec_trap(spec_insn_rem_trap),
    .spec_rs1_addr(spec_insn_rem_rs1_addr),
    .spec_rs2_addr(spec_insn_rem_rs2_addr),
    .spec_rd_addr(spec_insn_rem_rd_addr),
    .spec_rd_wdata(spec_insn_rem_rd_wdata),
    .spec_pc_wdata(spec_insn_rem_pc_wdata),
    .spec_mem_addr(spec_insn_rem_mem_addr),
    .spec_mem_rmask(spec_insn_rem_mem_rmask),
    .spec_mem_wmask(spec_insn_rem_mem_wmask),
    .spec_mem_wdata(spec_insn_rem_mem_wdata)
  );

  wire                                spec_insn_remu_valid;
  wire                                spec_insn_remu_trap;
  wire [                       4 : 0] spec_insn_remu_rs1_addr;
  wire [                       4 : 0] spec_insn_remu_rs2_addr;
  wire [                       4 : 0] spec_insn_remu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remu_csr_misa_rmask;
`endif

  rvfi_insn_remu insn_remu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_remu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_remu_valid),
    .spec_trap(spec_insn_remu_trap),
    .spec_rs1_addr(spec_insn_remu_rs1_addr),
    .spec_rs2_addr(spec_insn_remu_rs2_addr),
    .spec_rd_addr(spec_insn_remu_rd_addr),
    .spec_rd_wdata(spec_insn_remu_rd_wdata),
    .spec_pc_wdata(spec_insn_remu_pc_wdata),
    .spec_mem_addr(spec_insn_remu_mem_addr),
    .spec_mem_rmask(spec_insn_remu_mem_rmask),
    .spec_mem_wmask(spec_insn_remu_mem_wmask),
    .spec_mem_wdata(spec_insn_remu_mem_wdata)
  );

  wire                                spec_insn_remuw_valid;
  wire                                spec_insn_remuw_trap;
  wire [                       4 : 0] spec_insn_remuw_rs1_addr;
  wire [                       4 : 0] spec_insn_remuw_rs2_addr;
  wire [                       4 : 0] spec_insn_remuw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remuw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remuw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remuw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remuw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remuw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remuw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remuw_csr_misa_rmask;
`endif

  rvfi_insn_remuw insn_remuw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_remuw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_remuw_valid),
    .spec_trap(spec_insn_remuw_trap),
    .spec_rs1_addr(spec_insn_remuw_rs1_addr),
    .spec_rs2_addr(spec_insn_remuw_rs2_addr),
    .spec_rd_addr(spec_insn_remuw_rd_addr),
    .spec_rd_wdata(spec_insn_remuw_rd_wdata),
    .spec_pc_wdata(spec_insn_remuw_pc_wdata),
    .spec_mem_addr(spec_insn_remuw_mem_addr),
    .spec_mem_rmask(spec_insn_remuw_mem_rmask),
    .spec_mem_wmask(spec_insn_remuw_mem_wmask),
    .spec_mem_wdata(spec_insn_remuw_mem_wdata)
  );

  wire                                spec_insn_remw_valid;
  wire                                spec_insn_remw_trap;
  wire [                       4 : 0] spec_insn_remw_rs1_addr;
  wire [                       4 : 0] spec_insn_remw_rs2_addr;
  wire [                       4 : 0] spec_insn_remw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_remw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_remw_csr_misa_rmask;
`endif

  rvfi_insn_remw insn_remw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_remw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_remw_valid),
    .spec_trap(spec_insn_remw_trap),
    .spec_rs1_addr(spec_insn_remw_rs1_addr),
    .spec_rs2_addr(spec_insn_remw_rs2_addr),
    .spec_rd_addr(spec_insn_remw_rd_addr),
    .spec_rd_wdata(spec_insn_remw_rd_wdata),
    .spec_pc_wdata(spec_insn_remw_pc_wdata),
    .spec_mem_addr(spec_insn_remw_mem_addr),
    .spec_mem_rmask(spec_insn_remw_mem_rmask),
    .spec_mem_wmask(spec_insn_remw_mem_wmask),
    .spec_mem_wdata(spec_insn_remw_mem_wdata)
  );

  wire                                spec_insn_sb_valid;
  wire                                spec_insn_sb_trap;
  wire [                       4 : 0] spec_insn_sb_rs1_addr;
  wire [                       4 : 0] spec_insn_sb_rs2_addr;
  wire [                       4 : 0] spec_insn_sb_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sb_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sb_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sb_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sb_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sb_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sb_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sb_csr_misa_rmask;
`endif

  rvfi_insn_sb insn_sb (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sb_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sb_valid),
    .spec_trap(spec_insn_sb_trap),
    .spec_rs1_addr(spec_insn_sb_rs1_addr),
    .spec_rs2_addr(spec_insn_sb_rs2_addr),
    .spec_rd_addr(spec_insn_sb_rd_addr),
    .spec_rd_wdata(spec_insn_sb_rd_wdata),
    .spec_pc_wdata(spec_insn_sb_pc_wdata),
    .spec_mem_addr(spec_insn_sb_mem_addr),
    .spec_mem_rmask(spec_insn_sb_mem_rmask),
    .spec_mem_wmask(spec_insn_sb_mem_wmask),
    .spec_mem_wdata(spec_insn_sb_mem_wdata)
  );

  wire                                spec_insn_sd_valid;
  wire                                spec_insn_sd_trap;
  wire [                       4 : 0] spec_insn_sd_rs1_addr;
  wire [                       4 : 0] spec_insn_sd_rs2_addr;
  wire [                       4 : 0] spec_insn_sd_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sd_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sd_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sd_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sd_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sd_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sd_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sd_csr_misa_rmask;
`endif

  rvfi_insn_sd insn_sd (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sd_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sd_valid),
    .spec_trap(spec_insn_sd_trap),
    .spec_rs1_addr(spec_insn_sd_rs1_addr),
    .spec_rs2_addr(spec_insn_sd_rs2_addr),
    .spec_rd_addr(spec_insn_sd_rd_addr),
    .spec_rd_wdata(spec_insn_sd_rd_wdata),
    .spec_pc_wdata(spec_insn_sd_pc_wdata),
    .spec_mem_addr(spec_insn_sd_mem_addr),
    .spec_mem_rmask(spec_insn_sd_mem_rmask),
    .spec_mem_wmask(spec_insn_sd_mem_wmask),
    .spec_mem_wdata(spec_insn_sd_mem_wdata)
  );

  wire                                spec_insn_sh_valid;
  wire                                spec_insn_sh_trap;
  wire [                       4 : 0] spec_insn_sh_rs1_addr;
  wire [                       4 : 0] spec_insn_sh_rs2_addr;
  wire [                       4 : 0] spec_insn_sh_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sh_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sh_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sh_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sh_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sh_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sh_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sh_csr_misa_rmask;
`endif

  rvfi_insn_sh insn_sh (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sh_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sh_valid),
    .spec_trap(spec_insn_sh_trap),
    .spec_rs1_addr(spec_insn_sh_rs1_addr),
    .spec_rs2_addr(spec_insn_sh_rs2_addr),
    .spec_rd_addr(spec_insn_sh_rd_addr),
    .spec_rd_wdata(spec_insn_sh_rd_wdata),
    .spec_pc_wdata(spec_insn_sh_pc_wdata),
    .spec_mem_addr(spec_insn_sh_mem_addr),
    .spec_mem_rmask(spec_insn_sh_mem_rmask),
    .spec_mem_wmask(spec_insn_sh_mem_wmask),
    .spec_mem_wdata(spec_insn_sh_mem_wdata)
  );

  wire                                spec_insn_sll_valid;
  wire                                spec_insn_sll_trap;
  wire [                       4 : 0] spec_insn_sll_rs1_addr;
  wire [                       4 : 0] spec_insn_sll_rs2_addr;
  wire [                       4 : 0] spec_insn_sll_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sll_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sll_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sll_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sll_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sll_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sll_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sll_csr_misa_rmask;
`endif

  rvfi_insn_sll insn_sll (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sll_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sll_valid),
    .spec_trap(spec_insn_sll_trap),
    .spec_rs1_addr(spec_insn_sll_rs1_addr),
    .spec_rs2_addr(spec_insn_sll_rs2_addr),
    .spec_rd_addr(spec_insn_sll_rd_addr),
    .spec_rd_wdata(spec_insn_sll_rd_wdata),
    .spec_pc_wdata(spec_insn_sll_pc_wdata),
    .spec_mem_addr(spec_insn_sll_mem_addr),
    .spec_mem_rmask(spec_insn_sll_mem_rmask),
    .spec_mem_wmask(spec_insn_sll_mem_wmask),
    .spec_mem_wdata(spec_insn_sll_mem_wdata)
  );

  wire                                spec_insn_slli_valid;
  wire                                spec_insn_slli_trap;
  wire [                       4 : 0] spec_insn_slli_rs1_addr;
  wire [                       4 : 0] spec_insn_slli_rs2_addr;
  wire [                       4 : 0] spec_insn_slli_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slli_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slli_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slli_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slli_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slli_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slli_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slli_csr_misa_rmask;
`endif

  rvfi_insn_slli insn_slli (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_slli_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_slli_valid),
    .spec_trap(spec_insn_slli_trap),
    .spec_rs1_addr(spec_insn_slli_rs1_addr),
    .spec_rs2_addr(spec_insn_slli_rs2_addr),
    .spec_rd_addr(spec_insn_slli_rd_addr),
    .spec_rd_wdata(spec_insn_slli_rd_wdata),
    .spec_pc_wdata(spec_insn_slli_pc_wdata),
    .spec_mem_addr(spec_insn_slli_mem_addr),
    .spec_mem_rmask(spec_insn_slli_mem_rmask),
    .spec_mem_wmask(spec_insn_slli_mem_wmask),
    .spec_mem_wdata(spec_insn_slli_mem_wdata)
  );

  wire                                spec_insn_slliw_valid;
  wire                                spec_insn_slliw_trap;
  wire [                       4 : 0] spec_insn_slliw_rs1_addr;
  wire [                       4 : 0] spec_insn_slliw_rs2_addr;
  wire [                       4 : 0] spec_insn_slliw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slliw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slliw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slliw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slliw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slliw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slliw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slliw_csr_misa_rmask;
`endif

  rvfi_insn_slliw insn_slliw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_slliw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_slliw_valid),
    .spec_trap(spec_insn_slliw_trap),
    .spec_rs1_addr(spec_insn_slliw_rs1_addr),
    .spec_rs2_addr(spec_insn_slliw_rs2_addr),
    .spec_rd_addr(spec_insn_slliw_rd_addr),
    .spec_rd_wdata(spec_insn_slliw_rd_wdata),
    .spec_pc_wdata(spec_insn_slliw_pc_wdata),
    .spec_mem_addr(spec_insn_slliw_mem_addr),
    .spec_mem_rmask(spec_insn_slliw_mem_rmask),
    .spec_mem_wmask(spec_insn_slliw_mem_wmask),
    .spec_mem_wdata(spec_insn_slliw_mem_wdata)
  );

  wire                                spec_insn_sllw_valid;
  wire                                spec_insn_sllw_trap;
  wire [                       4 : 0] spec_insn_sllw_rs1_addr;
  wire [                       4 : 0] spec_insn_sllw_rs2_addr;
  wire [                       4 : 0] spec_insn_sllw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sllw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sllw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sllw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sllw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sllw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sllw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sllw_csr_misa_rmask;
`endif

  rvfi_insn_sllw insn_sllw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sllw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sllw_valid),
    .spec_trap(spec_insn_sllw_trap),
    .spec_rs1_addr(spec_insn_sllw_rs1_addr),
    .spec_rs2_addr(spec_insn_sllw_rs2_addr),
    .spec_rd_addr(spec_insn_sllw_rd_addr),
    .spec_rd_wdata(spec_insn_sllw_rd_wdata),
    .spec_pc_wdata(spec_insn_sllw_pc_wdata),
    .spec_mem_addr(spec_insn_sllw_mem_addr),
    .spec_mem_rmask(spec_insn_sllw_mem_rmask),
    .spec_mem_wmask(spec_insn_sllw_mem_wmask),
    .spec_mem_wdata(spec_insn_sllw_mem_wdata)
  );

  wire                                spec_insn_slt_valid;
  wire                                spec_insn_slt_trap;
  wire [                       4 : 0] spec_insn_slt_rs1_addr;
  wire [                       4 : 0] spec_insn_slt_rs2_addr;
  wire [                       4 : 0] spec_insn_slt_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slt_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slt_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slt_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slt_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slt_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slt_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slt_csr_misa_rmask;
`endif

  rvfi_insn_slt insn_slt (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_slt_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_slt_valid),
    .spec_trap(spec_insn_slt_trap),
    .spec_rs1_addr(spec_insn_slt_rs1_addr),
    .spec_rs2_addr(spec_insn_slt_rs2_addr),
    .spec_rd_addr(spec_insn_slt_rd_addr),
    .spec_rd_wdata(spec_insn_slt_rd_wdata),
    .spec_pc_wdata(spec_insn_slt_pc_wdata),
    .spec_mem_addr(spec_insn_slt_mem_addr),
    .spec_mem_rmask(spec_insn_slt_mem_rmask),
    .spec_mem_wmask(spec_insn_slt_mem_wmask),
    .spec_mem_wdata(spec_insn_slt_mem_wdata)
  );

  wire                                spec_insn_slti_valid;
  wire                                spec_insn_slti_trap;
  wire [                       4 : 0] spec_insn_slti_rs1_addr;
  wire [                       4 : 0] spec_insn_slti_rs2_addr;
  wire [                       4 : 0] spec_insn_slti_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slti_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slti_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slti_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slti_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_slti_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slti_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_slti_csr_misa_rmask;
`endif

  rvfi_insn_slti insn_slti (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_slti_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_slti_valid),
    .spec_trap(spec_insn_slti_trap),
    .spec_rs1_addr(spec_insn_slti_rs1_addr),
    .spec_rs2_addr(spec_insn_slti_rs2_addr),
    .spec_rd_addr(spec_insn_slti_rd_addr),
    .spec_rd_wdata(spec_insn_slti_rd_wdata),
    .spec_pc_wdata(spec_insn_slti_pc_wdata),
    .spec_mem_addr(spec_insn_slti_mem_addr),
    .spec_mem_rmask(spec_insn_slti_mem_rmask),
    .spec_mem_wmask(spec_insn_slti_mem_wmask),
    .spec_mem_wdata(spec_insn_slti_mem_wdata)
  );

  wire                                spec_insn_sltiu_valid;
  wire                                spec_insn_sltiu_trap;
  wire [                       4 : 0] spec_insn_sltiu_rs1_addr;
  wire [                       4 : 0] spec_insn_sltiu_rs2_addr;
  wire [                       4 : 0] spec_insn_sltiu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltiu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltiu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltiu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sltiu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sltiu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltiu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltiu_csr_misa_rmask;
`endif

  rvfi_insn_sltiu insn_sltiu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sltiu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sltiu_valid),
    .spec_trap(spec_insn_sltiu_trap),
    .spec_rs1_addr(spec_insn_sltiu_rs1_addr),
    .spec_rs2_addr(spec_insn_sltiu_rs2_addr),
    .spec_rd_addr(spec_insn_sltiu_rd_addr),
    .spec_rd_wdata(spec_insn_sltiu_rd_wdata),
    .spec_pc_wdata(spec_insn_sltiu_pc_wdata),
    .spec_mem_addr(spec_insn_sltiu_mem_addr),
    .spec_mem_rmask(spec_insn_sltiu_mem_rmask),
    .spec_mem_wmask(spec_insn_sltiu_mem_wmask),
    .spec_mem_wdata(spec_insn_sltiu_mem_wdata)
  );

  wire                                spec_insn_sltu_valid;
  wire                                spec_insn_sltu_trap;
  wire [                       4 : 0] spec_insn_sltu_rs1_addr;
  wire [                       4 : 0] spec_insn_sltu_rs2_addr;
  wire [                       4 : 0] spec_insn_sltu_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltu_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltu_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltu_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sltu_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sltu_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltu_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sltu_csr_misa_rmask;
`endif

  rvfi_insn_sltu insn_sltu (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sltu_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sltu_valid),
    .spec_trap(spec_insn_sltu_trap),
    .spec_rs1_addr(spec_insn_sltu_rs1_addr),
    .spec_rs2_addr(spec_insn_sltu_rs2_addr),
    .spec_rd_addr(spec_insn_sltu_rd_addr),
    .spec_rd_wdata(spec_insn_sltu_rd_wdata),
    .spec_pc_wdata(spec_insn_sltu_pc_wdata),
    .spec_mem_addr(spec_insn_sltu_mem_addr),
    .spec_mem_rmask(spec_insn_sltu_mem_rmask),
    .spec_mem_wmask(spec_insn_sltu_mem_wmask),
    .spec_mem_wdata(spec_insn_sltu_mem_wdata)
  );

  wire                                spec_insn_sra_valid;
  wire                                spec_insn_sra_trap;
  wire [                       4 : 0] spec_insn_sra_rs1_addr;
  wire [                       4 : 0] spec_insn_sra_rs2_addr;
  wire [                       4 : 0] spec_insn_sra_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sra_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sra_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sra_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sra_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sra_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sra_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sra_csr_misa_rmask;
`endif

  rvfi_insn_sra insn_sra (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sra_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sra_valid),
    .spec_trap(spec_insn_sra_trap),
    .spec_rs1_addr(spec_insn_sra_rs1_addr),
    .spec_rs2_addr(spec_insn_sra_rs2_addr),
    .spec_rd_addr(spec_insn_sra_rd_addr),
    .spec_rd_wdata(spec_insn_sra_rd_wdata),
    .spec_pc_wdata(spec_insn_sra_pc_wdata),
    .spec_mem_addr(spec_insn_sra_mem_addr),
    .spec_mem_rmask(spec_insn_sra_mem_rmask),
    .spec_mem_wmask(spec_insn_sra_mem_wmask),
    .spec_mem_wdata(spec_insn_sra_mem_wdata)
  );

  wire                                spec_insn_srai_valid;
  wire                                spec_insn_srai_trap;
  wire [                       4 : 0] spec_insn_srai_rs1_addr;
  wire [                       4 : 0] spec_insn_srai_rs2_addr;
  wire [                       4 : 0] spec_insn_srai_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srai_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srai_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srai_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srai_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srai_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srai_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srai_csr_misa_rmask;
`endif

  rvfi_insn_srai insn_srai (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_srai_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_srai_valid),
    .spec_trap(spec_insn_srai_trap),
    .spec_rs1_addr(spec_insn_srai_rs1_addr),
    .spec_rs2_addr(spec_insn_srai_rs2_addr),
    .spec_rd_addr(spec_insn_srai_rd_addr),
    .spec_rd_wdata(spec_insn_srai_rd_wdata),
    .spec_pc_wdata(spec_insn_srai_pc_wdata),
    .spec_mem_addr(spec_insn_srai_mem_addr),
    .spec_mem_rmask(spec_insn_srai_mem_rmask),
    .spec_mem_wmask(spec_insn_srai_mem_wmask),
    .spec_mem_wdata(spec_insn_srai_mem_wdata)
  );

  wire                                spec_insn_sraiw_valid;
  wire                                spec_insn_sraiw_trap;
  wire [                       4 : 0] spec_insn_sraiw_rs1_addr;
  wire [                       4 : 0] spec_insn_sraiw_rs2_addr;
  wire [                       4 : 0] spec_insn_sraiw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraiw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraiw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraiw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sraiw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sraiw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraiw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraiw_csr_misa_rmask;
`endif

  rvfi_insn_sraiw insn_sraiw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sraiw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sraiw_valid),
    .spec_trap(spec_insn_sraiw_trap),
    .spec_rs1_addr(spec_insn_sraiw_rs1_addr),
    .spec_rs2_addr(spec_insn_sraiw_rs2_addr),
    .spec_rd_addr(spec_insn_sraiw_rd_addr),
    .spec_rd_wdata(spec_insn_sraiw_rd_wdata),
    .spec_pc_wdata(spec_insn_sraiw_pc_wdata),
    .spec_mem_addr(spec_insn_sraiw_mem_addr),
    .spec_mem_rmask(spec_insn_sraiw_mem_rmask),
    .spec_mem_wmask(spec_insn_sraiw_mem_wmask),
    .spec_mem_wdata(spec_insn_sraiw_mem_wdata)
  );

  wire                                spec_insn_sraw_valid;
  wire                                spec_insn_sraw_trap;
  wire [                       4 : 0] spec_insn_sraw_rs1_addr;
  wire [                       4 : 0] spec_insn_sraw_rs2_addr;
  wire [                       4 : 0] spec_insn_sraw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sraw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sraw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sraw_csr_misa_rmask;
`endif

  rvfi_insn_sraw insn_sraw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sraw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sraw_valid),
    .spec_trap(spec_insn_sraw_trap),
    .spec_rs1_addr(spec_insn_sraw_rs1_addr),
    .spec_rs2_addr(spec_insn_sraw_rs2_addr),
    .spec_rd_addr(spec_insn_sraw_rd_addr),
    .spec_rd_wdata(spec_insn_sraw_rd_wdata),
    .spec_pc_wdata(spec_insn_sraw_pc_wdata),
    .spec_mem_addr(spec_insn_sraw_mem_addr),
    .spec_mem_rmask(spec_insn_sraw_mem_rmask),
    .spec_mem_wmask(spec_insn_sraw_mem_wmask),
    .spec_mem_wdata(spec_insn_sraw_mem_wdata)
  );

  wire                                spec_insn_srl_valid;
  wire                                spec_insn_srl_trap;
  wire [                       4 : 0] spec_insn_srl_rs1_addr;
  wire [                       4 : 0] spec_insn_srl_rs2_addr;
  wire [                       4 : 0] spec_insn_srl_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srl_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srl_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srl_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srl_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srl_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srl_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srl_csr_misa_rmask;
`endif

  rvfi_insn_srl insn_srl (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_srl_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_srl_valid),
    .spec_trap(spec_insn_srl_trap),
    .spec_rs1_addr(spec_insn_srl_rs1_addr),
    .spec_rs2_addr(spec_insn_srl_rs2_addr),
    .spec_rd_addr(spec_insn_srl_rd_addr),
    .spec_rd_wdata(spec_insn_srl_rd_wdata),
    .spec_pc_wdata(spec_insn_srl_pc_wdata),
    .spec_mem_addr(spec_insn_srl_mem_addr),
    .spec_mem_rmask(spec_insn_srl_mem_rmask),
    .spec_mem_wmask(spec_insn_srl_mem_wmask),
    .spec_mem_wdata(spec_insn_srl_mem_wdata)
  );

  wire                                spec_insn_srli_valid;
  wire                                spec_insn_srli_trap;
  wire [                       4 : 0] spec_insn_srli_rs1_addr;
  wire [                       4 : 0] spec_insn_srli_rs2_addr;
  wire [                       4 : 0] spec_insn_srli_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srli_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srli_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srli_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srli_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srli_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srli_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srli_csr_misa_rmask;
`endif

  rvfi_insn_srli insn_srli (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_srli_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_srli_valid),
    .spec_trap(spec_insn_srli_trap),
    .spec_rs1_addr(spec_insn_srli_rs1_addr),
    .spec_rs2_addr(spec_insn_srli_rs2_addr),
    .spec_rd_addr(spec_insn_srli_rd_addr),
    .spec_rd_wdata(spec_insn_srli_rd_wdata),
    .spec_pc_wdata(spec_insn_srli_pc_wdata),
    .spec_mem_addr(spec_insn_srli_mem_addr),
    .spec_mem_rmask(spec_insn_srli_mem_rmask),
    .spec_mem_wmask(spec_insn_srli_mem_wmask),
    .spec_mem_wdata(spec_insn_srli_mem_wdata)
  );

  wire                                spec_insn_srliw_valid;
  wire                                spec_insn_srliw_trap;
  wire [                       4 : 0] spec_insn_srliw_rs1_addr;
  wire [                       4 : 0] spec_insn_srliw_rs2_addr;
  wire [                       4 : 0] spec_insn_srliw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srliw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srliw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srliw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srliw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srliw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srliw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srliw_csr_misa_rmask;
`endif

  rvfi_insn_srliw insn_srliw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_srliw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_srliw_valid),
    .spec_trap(spec_insn_srliw_trap),
    .spec_rs1_addr(spec_insn_srliw_rs1_addr),
    .spec_rs2_addr(spec_insn_srliw_rs2_addr),
    .spec_rd_addr(spec_insn_srliw_rd_addr),
    .spec_rd_wdata(spec_insn_srliw_rd_wdata),
    .spec_pc_wdata(spec_insn_srliw_pc_wdata),
    .spec_mem_addr(spec_insn_srliw_mem_addr),
    .spec_mem_rmask(spec_insn_srliw_mem_rmask),
    .spec_mem_wmask(spec_insn_srliw_mem_wmask),
    .spec_mem_wdata(spec_insn_srliw_mem_wdata)
  );

  wire                                spec_insn_srlw_valid;
  wire                                spec_insn_srlw_trap;
  wire [                       4 : 0] spec_insn_srlw_rs1_addr;
  wire [                       4 : 0] spec_insn_srlw_rs2_addr;
  wire [                       4 : 0] spec_insn_srlw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srlw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srlw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srlw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srlw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_srlw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srlw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_srlw_csr_misa_rmask;
`endif

  rvfi_insn_srlw insn_srlw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_srlw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_srlw_valid),
    .spec_trap(spec_insn_srlw_trap),
    .spec_rs1_addr(spec_insn_srlw_rs1_addr),
    .spec_rs2_addr(spec_insn_srlw_rs2_addr),
    .spec_rd_addr(spec_insn_srlw_rd_addr),
    .spec_rd_wdata(spec_insn_srlw_rd_wdata),
    .spec_pc_wdata(spec_insn_srlw_pc_wdata),
    .spec_mem_addr(spec_insn_srlw_mem_addr),
    .spec_mem_rmask(spec_insn_srlw_mem_rmask),
    .spec_mem_wmask(spec_insn_srlw_mem_wmask),
    .spec_mem_wdata(spec_insn_srlw_mem_wdata)
  );

  wire                                spec_insn_sub_valid;
  wire                                spec_insn_sub_trap;
  wire [                       4 : 0] spec_insn_sub_rs1_addr;
  wire [                       4 : 0] spec_insn_sub_rs2_addr;
  wire [                       4 : 0] spec_insn_sub_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sub_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sub_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sub_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sub_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sub_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sub_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sub_csr_misa_rmask;
`endif

  rvfi_insn_sub insn_sub (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sub_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sub_valid),
    .spec_trap(spec_insn_sub_trap),
    .spec_rs1_addr(spec_insn_sub_rs1_addr),
    .spec_rs2_addr(spec_insn_sub_rs2_addr),
    .spec_rd_addr(spec_insn_sub_rd_addr),
    .spec_rd_wdata(spec_insn_sub_rd_wdata),
    .spec_pc_wdata(spec_insn_sub_pc_wdata),
    .spec_mem_addr(spec_insn_sub_mem_addr),
    .spec_mem_rmask(spec_insn_sub_mem_rmask),
    .spec_mem_wmask(spec_insn_sub_mem_wmask),
    .spec_mem_wdata(spec_insn_sub_mem_wdata)
  );

  wire                                spec_insn_subw_valid;
  wire                                spec_insn_subw_trap;
  wire [                       4 : 0] spec_insn_subw_rs1_addr;
  wire [                       4 : 0] spec_insn_subw_rs2_addr;
  wire [                       4 : 0] spec_insn_subw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_subw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_subw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_subw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_subw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_subw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_subw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_subw_csr_misa_rmask;
`endif

  rvfi_insn_subw insn_subw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_subw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_subw_valid),
    .spec_trap(spec_insn_subw_trap),
    .spec_rs1_addr(spec_insn_subw_rs1_addr),
    .spec_rs2_addr(spec_insn_subw_rs2_addr),
    .spec_rd_addr(spec_insn_subw_rd_addr),
    .spec_rd_wdata(spec_insn_subw_rd_wdata),
    .spec_pc_wdata(spec_insn_subw_pc_wdata),
    .spec_mem_addr(spec_insn_subw_mem_addr),
    .spec_mem_rmask(spec_insn_subw_mem_rmask),
    .spec_mem_wmask(spec_insn_subw_mem_wmask),
    .spec_mem_wdata(spec_insn_subw_mem_wdata)
  );

  wire                                spec_insn_sw_valid;
  wire                                spec_insn_sw_trap;
  wire [                       4 : 0] spec_insn_sw_rs1_addr;
  wire [                       4 : 0] spec_insn_sw_rs2_addr;
  wire [                       4 : 0] spec_insn_sw_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sw_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sw_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sw_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sw_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_sw_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sw_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_sw_csr_misa_rmask;
`endif

  rvfi_insn_sw insn_sw (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_sw_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_sw_valid),
    .spec_trap(spec_insn_sw_trap),
    .spec_rs1_addr(spec_insn_sw_rs1_addr),
    .spec_rs2_addr(spec_insn_sw_rs2_addr),
    .spec_rd_addr(spec_insn_sw_rd_addr),
    .spec_rd_wdata(spec_insn_sw_rd_wdata),
    .spec_pc_wdata(spec_insn_sw_pc_wdata),
    .spec_mem_addr(spec_insn_sw_mem_addr),
    .spec_mem_rmask(spec_insn_sw_mem_rmask),
    .spec_mem_wmask(spec_insn_sw_mem_wmask),
    .spec_mem_wdata(spec_insn_sw_mem_wdata)
  );

  wire                                spec_insn_xor_valid;
  wire                                spec_insn_xor_trap;
  wire [                       4 : 0] spec_insn_xor_rs1_addr;
  wire [                       4 : 0] spec_insn_xor_rs2_addr;
  wire [                       4 : 0] spec_insn_xor_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xor_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xor_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xor_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_xor_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_xor_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xor_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xor_csr_misa_rmask;
`endif

  rvfi_insn_xor insn_xor (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_xor_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_xor_valid),
    .spec_trap(spec_insn_xor_trap),
    .spec_rs1_addr(spec_insn_xor_rs1_addr),
    .spec_rs2_addr(spec_insn_xor_rs2_addr),
    .spec_rd_addr(spec_insn_xor_rd_addr),
    .spec_rd_wdata(spec_insn_xor_rd_wdata),
    .spec_pc_wdata(spec_insn_xor_pc_wdata),
    .spec_mem_addr(spec_insn_xor_mem_addr),
    .spec_mem_rmask(spec_insn_xor_mem_rmask),
    .spec_mem_wmask(spec_insn_xor_mem_wmask),
    .spec_mem_wdata(spec_insn_xor_mem_wdata)
  );

  wire                                spec_insn_xori_valid;
  wire                                spec_insn_xori_trap;
  wire [                       4 : 0] spec_insn_xori_rs1_addr;
  wire [                       4 : 0] spec_insn_xori_rs2_addr;
  wire [                       4 : 0] spec_insn_xori_rd_addr;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xori_rd_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xori_pc_wdata;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xori_mem_addr;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_xori_mem_rmask;
  wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_insn_xori_mem_wmask;
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xori_mem_wdata;
`ifdef RISCV_FORMAL_CSR_MISA
  wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_insn_xori_csr_misa_rmask;
`endif

  rvfi_insn_xori insn_xori (
    .rvfi_valid(rvfi_valid),
    .rvfi_insn(rvfi_insn),
    .rvfi_pc_rdata(rvfi_pc_rdata),
    .rvfi_rs1_rdata(rvfi_rs1_rdata),
    .rvfi_rs2_rdata(rvfi_rs2_rdata),
    .rvfi_mem_rdata(rvfi_mem_rdata),
`ifdef RISCV_FORMAL_CSR_MISA
    .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
    .spec_csr_misa_rmask(spec_insn_xori_csr_misa_rmask),
`endif
    .spec_valid(spec_insn_xori_valid),
    .spec_trap(spec_insn_xori_trap),
    .spec_rs1_addr(spec_insn_xori_rs1_addr),
    .spec_rs2_addr(spec_insn_xori_rs2_addr),
    .spec_rd_addr(spec_insn_xori_rd_addr),
    .spec_rd_wdata(spec_insn_xori_rd_wdata),
    .spec_pc_wdata(spec_insn_xori_pc_wdata),
    .spec_mem_addr(spec_insn_xori_mem_addr),
    .spec_mem_rmask(spec_insn_xori_mem_rmask),
    .spec_mem_wmask(spec_insn_xori_mem_wmask),
    .spec_mem_wdata(spec_insn_xori_mem_wdata)
  );

  assign spec_valid =
		spec_insn_add_valid ? spec_insn_add_valid :
		spec_insn_addi_valid ? spec_insn_addi_valid :
		spec_insn_addiw_valid ? spec_insn_addiw_valid :
		spec_insn_addw_valid ? spec_insn_addw_valid :
		spec_insn_and_valid ? spec_insn_and_valid :
		spec_insn_andi_valid ? spec_insn_andi_valid :
		spec_insn_auipc_valid ? spec_insn_auipc_valid :
		spec_insn_beq_valid ? spec_insn_beq_valid :
		spec_insn_bge_valid ? spec_insn_bge_valid :
		spec_insn_bgeu_valid ? spec_insn_bgeu_valid :
		spec_insn_blt_valid ? spec_insn_blt_valid :
		spec_insn_bltu_valid ? spec_insn_bltu_valid :
		spec_insn_bne_valid ? spec_insn_bne_valid :
		spec_insn_c_add_valid ? spec_insn_c_add_valid :
		spec_insn_c_addi_valid ? spec_insn_c_addi_valid :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_valid :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_valid :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_valid :
		spec_insn_c_addw_valid ? spec_insn_c_addw_valid :
		spec_insn_c_and_valid ? spec_insn_c_and_valid :
		spec_insn_c_andi_valid ? spec_insn_c_andi_valid :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_valid :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_valid :
		spec_insn_c_j_valid ? spec_insn_c_j_valid :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_valid :
		spec_insn_c_jr_valid ? spec_insn_c_jr_valid :
		spec_insn_c_ld_valid ? spec_insn_c_ld_valid :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_valid :
		spec_insn_c_li_valid ? spec_insn_c_li_valid :
		spec_insn_c_lui_valid ? spec_insn_c_lui_valid :
		spec_insn_c_lw_valid ? spec_insn_c_lw_valid :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_valid :
		spec_insn_c_mv_valid ? spec_insn_c_mv_valid :
		spec_insn_c_or_valid ? spec_insn_c_or_valid :
		spec_insn_c_sd_valid ? spec_insn_c_sd_valid :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_valid :
		spec_insn_c_slli_valid ? spec_insn_c_slli_valid :
		spec_insn_c_srai_valid ? spec_insn_c_srai_valid :
		spec_insn_c_srli_valid ? spec_insn_c_srli_valid :
		spec_insn_c_sub_valid ? spec_insn_c_sub_valid :
		spec_insn_c_subw_valid ? spec_insn_c_subw_valid :
		spec_insn_c_sw_valid ? spec_insn_c_sw_valid :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_valid :
		spec_insn_c_xor_valid ? spec_insn_c_xor_valid :
		spec_insn_div_valid ? spec_insn_div_valid :
		spec_insn_divu_valid ? spec_insn_divu_valid :
		spec_insn_divuw_valid ? spec_insn_divuw_valid :
		spec_insn_divw_valid ? spec_insn_divw_valid :
		spec_insn_jal_valid ? spec_insn_jal_valid :
		spec_insn_jalr_valid ? spec_insn_jalr_valid :
		spec_insn_lb_valid ? spec_insn_lb_valid :
		spec_insn_lbu_valid ? spec_insn_lbu_valid :
		spec_insn_ld_valid ? spec_insn_ld_valid :
		spec_insn_lh_valid ? spec_insn_lh_valid :
		spec_insn_lhu_valid ? spec_insn_lhu_valid :
		spec_insn_lui_valid ? spec_insn_lui_valid :
		spec_insn_lw_valid ? spec_insn_lw_valid :
		spec_insn_lwu_valid ? spec_insn_lwu_valid :
		spec_insn_mul_valid ? spec_insn_mul_valid :
		spec_insn_mulh_valid ? spec_insn_mulh_valid :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_valid :
		spec_insn_mulhu_valid ? spec_insn_mulhu_valid :
		spec_insn_mulw_valid ? spec_insn_mulw_valid :
		spec_insn_or_valid ? spec_insn_or_valid :
		spec_insn_ori_valid ? spec_insn_ori_valid :
		spec_insn_rem_valid ? spec_insn_rem_valid :
		spec_insn_remu_valid ? spec_insn_remu_valid :
		spec_insn_remuw_valid ? spec_insn_remuw_valid :
		spec_insn_remw_valid ? spec_insn_remw_valid :
		spec_insn_sb_valid ? spec_insn_sb_valid :
		spec_insn_sd_valid ? spec_insn_sd_valid :
		spec_insn_sh_valid ? spec_insn_sh_valid :
		spec_insn_sll_valid ? spec_insn_sll_valid :
		spec_insn_slli_valid ? spec_insn_slli_valid :
		spec_insn_slliw_valid ? spec_insn_slliw_valid :
		spec_insn_sllw_valid ? spec_insn_sllw_valid :
		spec_insn_slt_valid ? spec_insn_slt_valid :
		spec_insn_slti_valid ? spec_insn_slti_valid :
		spec_insn_sltiu_valid ? spec_insn_sltiu_valid :
		spec_insn_sltu_valid ? spec_insn_sltu_valid :
		spec_insn_sra_valid ? spec_insn_sra_valid :
		spec_insn_srai_valid ? spec_insn_srai_valid :
		spec_insn_sraiw_valid ? spec_insn_sraiw_valid :
		spec_insn_sraw_valid ? spec_insn_sraw_valid :
		spec_insn_srl_valid ? spec_insn_srl_valid :
		spec_insn_srli_valid ? spec_insn_srli_valid :
		spec_insn_srliw_valid ? spec_insn_srliw_valid :
		spec_insn_srlw_valid ? spec_insn_srlw_valid :
		spec_insn_sub_valid ? spec_insn_sub_valid :
		spec_insn_subw_valid ? spec_insn_subw_valid :
		spec_insn_sw_valid ? spec_insn_sw_valid :
		spec_insn_xor_valid ? spec_insn_xor_valid :
		spec_insn_xori_valid ? spec_insn_xori_valid : 0;
  assign spec_trap =
		spec_insn_add_valid ? spec_insn_add_trap :
		spec_insn_addi_valid ? spec_insn_addi_trap :
		spec_insn_addiw_valid ? spec_insn_addiw_trap :
		spec_insn_addw_valid ? spec_insn_addw_trap :
		spec_insn_and_valid ? spec_insn_and_trap :
		spec_insn_andi_valid ? spec_insn_andi_trap :
		spec_insn_auipc_valid ? spec_insn_auipc_trap :
		spec_insn_beq_valid ? spec_insn_beq_trap :
		spec_insn_bge_valid ? spec_insn_bge_trap :
		spec_insn_bgeu_valid ? spec_insn_bgeu_trap :
		spec_insn_blt_valid ? spec_insn_blt_trap :
		spec_insn_bltu_valid ? spec_insn_bltu_trap :
		spec_insn_bne_valid ? spec_insn_bne_trap :
		spec_insn_c_add_valid ? spec_insn_c_add_trap :
		spec_insn_c_addi_valid ? spec_insn_c_addi_trap :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_trap :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_trap :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_trap :
		spec_insn_c_addw_valid ? spec_insn_c_addw_trap :
		spec_insn_c_and_valid ? spec_insn_c_and_trap :
		spec_insn_c_andi_valid ? spec_insn_c_andi_trap :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_trap :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_trap :
		spec_insn_c_j_valid ? spec_insn_c_j_trap :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_trap :
		spec_insn_c_jr_valid ? spec_insn_c_jr_trap :
		spec_insn_c_ld_valid ? spec_insn_c_ld_trap :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_trap :
		spec_insn_c_li_valid ? spec_insn_c_li_trap :
		spec_insn_c_lui_valid ? spec_insn_c_lui_trap :
		spec_insn_c_lw_valid ? spec_insn_c_lw_trap :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_trap :
		spec_insn_c_mv_valid ? spec_insn_c_mv_trap :
		spec_insn_c_or_valid ? spec_insn_c_or_trap :
		spec_insn_c_sd_valid ? spec_insn_c_sd_trap :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_trap :
		spec_insn_c_slli_valid ? spec_insn_c_slli_trap :
		spec_insn_c_srai_valid ? spec_insn_c_srai_trap :
		spec_insn_c_srli_valid ? spec_insn_c_srli_trap :
		spec_insn_c_sub_valid ? spec_insn_c_sub_trap :
		spec_insn_c_subw_valid ? spec_insn_c_subw_trap :
		spec_insn_c_sw_valid ? spec_insn_c_sw_trap :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_trap :
		spec_insn_c_xor_valid ? spec_insn_c_xor_trap :
		spec_insn_div_valid ? spec_insn_div_trap :
		spec_insn_divu_valid ? spec_insn_divu_trap :
		spec_insn_divuw_valid ? spec_insn_divuw_trap :
		spec_insn_divw_valid ? spec_insn_divw_trap :
		spec_insn_jal_valid ? spec_insn_jal_trap :
		spec_insn_jalr_valid ? spec_insn_jalr_trap :
		spec_insn_lb_valid ? spec_insn_lb_trap :
		spec_insn_lbu_valid ? spec_insn_lbu_trap :
		spec_insn_ld_valid ? spec_insn_ld_trap :
		spec_insn_lh_valid ? spec_insn_lh_trap :
		spec_insn_lhu_valid ? spec_insn_lhu_trap :
		spec_insn_lui_valid ? spec_insn_lui_trap :
		spec_insn_lw_valid ? spec_insn_lw_trap :
		spec_insn_lwu_valid ? spec_insn_lwu_trap :
		spec_insn_mul_valid ? spec_insn_mul_trap :
		spec_insn_mulh_valid ? spec_insn_mulh_trap :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_trap :
		spec_insn_mulhu_valid ? spec_insn_mulhu_trap :
		spec_insn_mulw_valid ? spec_insn_mulw_trap :
		spec_insn_or_valid ? spec_insn_or_trap :
		spec_insn_ori_valid ? spec_insn_ori_trap :
		spec_insn_rem_valid ? spec_insn_rem_trap :
		spec_insn_remu_valid ? spec_insn_remu_trap :
		spec_insn_remuw_valid ? spec_insn_remuw_trap :
		spec_insn_remw_valid ? spec_insn_remw_trap :
		spec_insn_sb_valid ? spec_insn_sb_trap :
		spec_insn_sd_valid ? spec_insn_sd_trap :
		spec_insn_sh_valid ? spec_insn_sh_trap :
		spec_insn_sll_valid ? spec_insn_sll_trap :
		spec_insn_slli_valid ? spec_insn_slli_trap :
		spec_insn_slliw_valid ? spec_insn_slliw_trap :
		spec_insn_sllw_valid ? spec_insn_sllw_trap :
		spec_insn_slt_valid ? spec_insn_slt_trap :
		spec_insn_slti_valid ? spec_insn_slti_trap :
		spec_insn_sltiu_valid ? spec_insn_sltiu_trap :
		spec_insn_sltu_valid ? spec_insn_sltu_trap :
		spec_insn_sra_valid ? spec_insn_sra_trap :
		spec_insn_srai_valid ? spec_insn_srai_trap :
		spec_insn_sraiw_valid ? spec_insn_sraiw_trap :
		spec_insn_sraw_valid ? spec_insn_sraw_trap :
		spec_insn_srl_valid ? spec_insn_srl_trap :
		spec_insn_srli_valid ? spec_insn_srli_trap :
		spec_insn_srliw_valid ? spec_insn_srliw_trap :
		spec_insn_srlw_valid ? spec_insn_srlw_trap :
		spec_insn_sub_valid ? spec_insn_sub_trap :
		spec_insn_subw_valid ? spec_insn_subw_trap :
		spec_insn_sw_valid ? spec_insn_sw_trap :
		spec_insn_xor_valid ? spec_insn_xor_trap :
		spec_insn_xori_valid ? spec_insn_xori_trap : 0;
  assign spec_rs1_addr =
		spec_insn_add_valid ? spec_insn_add_rs1_addr :
		spec_insn_addi_valid ? spec_insn_addi_rs1_addr :
		spec_insn_addiw_valid ? spec_insn_addiw_rs1_addr :
		spec_insn_addw_valid ? spec_insn_addw_rs1_addr :
		spec_insn_and_valid ? spec_insn_and_rs1_addr :
		spec_insn_andi_valid ? spec_insn_andi_rs1_addr :
		spec_insn_auipc_valid ? spec_insn_auipc_rs1_addr :
		spec_insn_beq_valid ? spec_insn_beq_rs1_addr :
		spec_insn_bge_valid ? spec_insn_bge_rs1_addr :
		spec_insn_bgeu_valid ? spec_insn_bgeu_rs1_addr :
		spec_insn_blt_valid ? spec_insn_blt_rs1_addr :
		spec_insn_bltu_valid ? spec_insn_bltu_rs1_addr :
		spec_insn_bne_valid ? spec_insn_bne_rs1_addr :
		spec_insn_c_add_valid ? spec_insn_c_add_rs1_addr :
		spec_insn_c_addi_valid ? spec_insn_c_addi_rs1_addr :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_rs1_addr :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_rs1_addr :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_rs1_addr :
		spec_insn_c_addw_valid ? spec_insn_c_addw_rs1_addr :
		spec_insn_c_and_valid ? spec_insn_c_and_rs1_addr :
		spec_insn_c_andi_valid ? spec_insn_c_andi_rs1_addr :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_rs1_addr :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_rs1_addr :
		spec_insn_c_j_valid ? spec_insn_c_j_rs1_addr :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_rs1_addr :
		spec_insn_c_jr_valid ? spec_insn_c_jr_rs1_addr :
		spec_insn_c_ld_valid ? spec_insn_c_ld_rs1_addr :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_rs1_addr :
		spec_insn_c_li_valid ? spec_insn_c_li_rs1_addr :
		spec_insn_c_lui_valid ? spec_insn_c_lui_rs1_addr :
		spec_insn_c_lw_valid ? spec_insn_c_lw_rs1_addr :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_rs1_addr :
		spec_insn_c_mv_valid ? spec_insn_c_mv_rs1_addr :
		spec_insn_c_or_valid ? spec_insn_c_or_rs1_addr :
		spec_insn_c_sd_valid ? spec_insn_c_sd_rs1_addr :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_rs1_addr :
		spec_insn_c_slli_valid ? spec_insn_c_slli_rs1_addr :
		spec_insn_c_srai_valid ? spec_insn_c_srai_rs1_addr :
		spec_insn_c_srli_valid ? spec_insn_c_srli_rs1_addr :
		spec_insn_c_sub_valid ? spec_insn_c_sub_rs1_addr :
		spec_insn_c_subw_valid ? spec_insn_c_subw_rs1_addr :
		spec_insn_c_sw_valid ? spec_insn_c_sw_rs1_addr :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_rs1_addr :
		spec_insn_c_xor_valid ? spec_insn_c_xor_rs1_addr :
		spec_insn_div_valid ? spec_insn_div_rs1_addr :
		spec_insn_divu_valid ? spec_insn_divu_rs1_addr :
		spec_insn_divuw_valid ? spec_insn_divuw_rs1_addr :
		spec_insn_divw_valid ? spec_insn_divw_rs1_addr :
		spec_insn_jal_valid ? spec_insn_jal_rs1_addr :
		spec_insn_jalr_valid ? spec_insn_jalr_rs1_addr :
		spec_insn_lb_valid ? spec_insn_lb_rs1_addr :
		spec_insn_lbu_valid ? spec_insn_lbu_rs1_addr :
		spec_insn_ld_valid ? spec_insn_ld_rs1_addr :
		spec_insn_lh_valid ? spec_insn_lh_rs1_addr :
		spec_insn_lhu_valid ? spec_insn_lhu_rs1_addr :
		spec_insn_lui_valid ? spec_insn_lui_rs1_addr :
		spec_insn_lw_valid ? spec_insn_lw_rs1_addr :
		spec_insn_lwu_valid ? spec_insn_lwu_rs1_addr :
		spec_insn_mul_valid ? spec_insn_mul_rs1_addr :
		spec_insn_mulh_valid ? spec_insn_mulh_rs1_addr :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_rs1_addr :
		spec_insn_mulhu_valid ? spec_insn_mulhu_rs1_addr :
		spec_insn_mulw_valid ? spec_insn_mulw_rs1_addr :
		spec_insn_or_valid ? spec_insn_or_rs1_addr :
		spec_insn_ori_valid ? spec_insn_ori_rs1_addr :
		spec_insn_rem_valid ? spec_insn_rem_rs1_addr :
		spec_insn_remu_valid ? spec_insn_remu_rs1_addr :
		spec_insn_remuw_valid ? spec_insn_remuw_rs1_addr :
		spec_insn_remw_valid ? spec_insn_remw_rs1_addr :
		spec_insn_sb_valid ? spec_insn_sb_rs1_addr :
		spec_insn_sd_valid ? spec_insn_sd_rs1_addr :
		spec_insn_sh_valid ? spec_insn_sh_rs1_addr :
		spec_insn_sll_valid ? spec_insn_sll_rs1_addr :
		spec_insn_slli_valid ? spec_insn_slli_rs1_addr :
		spec_insn_slliw_valid ? spec_insn_slliw_rs1_addr :
		spec_insn_sllw_valid ? spec_insn_sllw_rs1_addr :
		spec_insn_slt_valid ? spec_insn_slt_rs1_addr :
		spec_insn_slti_valid ? spec_insn_slti_rs1_addr :
		spec_insn_sltiu_valid ? spec_insn_sltiu_rs1_addr :
		spec_insn_sltu_valid ? spec_insn_sltu_rs1_addr :
		spec_insn_sra_valid ? spec_insn_sra_rs1_addr :
		spec_insn_srai_valid ? spec_insn_srai_rs1_addr :
		spec_insn_sraiw_valid ? spec_insn_sraiw_rs1_addr :
		spec_insn_sraw_valid ? spec_insn_sraw_rs1_addr :
		spec_insn_srl_valid ? spec_insn_srl_rs1_addr :
		spec_insn_srli_valid ? spec_insn_srli_rs1_addr :
		spec_insn_srliw_valid ? spec_insn_srliw_rs1_addr :
		spec_insn_srlw_valid ? spec_insn_srlw_rs1_addr :
		spec_insn_sub_valid ? spec_insn_sub_rs1_addr :
		spec_insn_subw_valid ? spec_insn_subw_rs1_addr :
		spec_insn_sw_valid ? spec_insn_sw_rs1_addr :
		spec_insn_xor_valid ? spec_insn_xor_rs1_addr :
		spec_insn_xori_valid ? spec_insn_xori_rs1_addr : 0;
  assign spec_rs2_addr =
		spec_insn_add_valid ? spec_insn_add_rs2_addr :
		spec_insn_addi_valid ? spec_insn_addi_rs2_addr :
		spec_insn_addiw_valid ? spec_insn_addiw_rs2_addr :
		spec_insn_addw_valid ? spec_insn_addw_rs2_addr :
		spec_insn_and_valid ? spec_insn_and_rs2_addr :
		spec_insn_andi_valid ? spec_insn_andi_rs2_addr :
		spec_insn_auipc_valid ? spec_insn_auipc_rs2_addr :
		spec_insn_beq_valid ? spec_insn_beq_rs2_addr :
		spec_insn_bge_valid ? spec_insn_bge_rs2_addr :
		spec_insn_bgeu_valid ? spec_insn_bgeu_rs2_addr :
		spec_insn_blt_valid ? spec_insn_blt_rs2_addr :
		spec_insn_bltu_valid ? spec_insn_bltu_rs2_addr :
		spec_insn_bne_valid ? spec_insn_bne_rs2_addr :
		spec_insn_c_add_valid ? spec_insn_c_add_rs2_addr :
		spec_insn_c_addi_valid ? spec_insn_c_addi_rs2_addr :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_rs2_addr :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_rs2_addr :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_rs2_addr :
		spec_insn_c_addw_valid ? spec_insn_c_addw_rs2_addr :
		spec_insn_c_and_valid ? spec_insn_c_and_rs2_addr :
		spec_insn_c_andi_valid ? spec_insn_c_andi_rs2_addr :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_rs2_addr :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_rs2_addr :
		spec_insn_c_j_valid ? spec_insn_c_j_rs2_addr :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_rs2_addr :
		spec_insn_c_jr_valid ? spec_insn_c_jr_rs2_addr :
		spec_insn_c_ld_valid ? spec_insn_c_ld_rs2_addr :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_rs2_addr :
		spec_insn_c_li_valid ? spec_insn_c_li_rs2_addr :
		spec_insn_c_lui_valid ? spec_insn_c_lui_rs2_addr :
		spec_insn_c_lw_valid ? spec_insn_c_lw_rs2_addr :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_rs2_addr :
		spec_insn_c_mv_valid ? spec_insn_c_mv_rs2_addr :
		spec_insn_c_or_valid ? spec_insn_c_or_rs2_addr :
		spec_insn_c_sd_valid ? spec_insn_c_sd_rs2_addr :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_rs2_addr :
		spec_insn_c_slli_valid ? spec_insn_c_slli_rs2_addr :
		spec_insn_c_srai_valid ? spec_insn_c_srai_rs2_addr :
		spec_insn_c_srli_valid ? spec_insn_c_srli_rs2_addr :
		spec_insn_c_sub_valid ? spec_insn_c_sub_rs2_addr :
		spec_insn_c_subw_valid ? spec_insn_c_subw_rs2_addr :
		spec_insn_c_sw_valid ? spec_insn_c_sw_rs2_addr :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_rs2_addr :
		spec_insn_c_xor_valid ? spec_insn_c_xor_rs2_addr :
		spec_insn_div_valid ? spec_insn_div_rs2_addr :
		spec_insn_divu_valid ? spec_insn_divu_rs2_addr :
		spec_insn_divuw_valid ? spec_insn_divuw_rs2_addr :
		spec_insn_divw_valid ? spec_insn_divw_rs2_addr :
		spec_insn_jal_valid ? spec_insn_jal_rs2_addr :
		spec_insn_jalr_valid ? spec_insn_jalr_rs2_addr :
		spec_insn_lb_valid ? spec_insn_lb_rs2_addr :
		spec_insn_lbu_valid ? spec_insn_lbu_rs2_addr :
		spec_insn_ld_valid ? spec_insn_ld_rs2_addr :
		spec_insn_lh_valid ? spec_insn_lh_rs2_addr :
		spec_insn_lhu_valid ? spec_insn_lhu_rs2_addr :
		spec_insn_lui_valid ? spec_insn_lui_rs2_addr :
		spec_insn_lw_valid ? spec_insn_lw_rs2_addr :
		spec_insn_lwu_valid ? spec_insn_lwu_rs2_addr :
		spec_insn_mul_valid ? spec_insn_mul_rs2_addr :
		spec_insn_mulh_valid ? spec_insn_mulh_rs2_addr :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_rs2_addr :
		spec_insn_mulhu_valid ? spec_insn_mulhu_rs2_addr :
		spec_insn_mulw_valid ? spec_insn_mulw_rs2_addr :
		spec_insn_or_valid ? spec_insn_or_rs2_addr :
		spec_insn_ori_valid ? spec_insn_ori_rs2_addr :
		spec_insn_rem_valid ? spec_insn_rem_rs2_addr :
		spec_insn_remu_valid ? spec_insn_remu_rs2_addr :
		spec_insn_remuw_valid ? spec_insn_remuw_rs2_addr :
		spec_insn_remw_valid ? spec_insn_remw_rs2_addr :
		spec_insn_sb_valid ? spec_insn_sb_rs2_addr :
		spec_insn_sd_valid ? spec_insn_sd_rs2_addr :
		spec_insn_sh_valid ? spec_insn_sh_rs2_addr :
		spec_insn_sll_valid ? spec_insn_sll_rs2_addr :
		spec_insn_slli_valid ? spec_insn_slli_rs2_addr :
		spec_insn_slliw_valid ? spec_insn_slliw_rs2_addr :
		spec_insn_sllw_valid ? spec_insn_sllw_rs2_addr :
		spec_insn_slt_valid ? spec_insn_slt_rs2_addr :
		spec_insn_slti_valid ? spec_insn_slti_rs2_addr :
		spec_insn_sltiu_valid ? spec_insn_sltiu_rs2_addr :
		spec_insn_sltu_valid ? spec_insn_sltu_rs2_addr :
		spec_insn_sra_valid ? spec_insn_sra_rs2_addr :
		spec_insn_srai_valid ? spec_insn_srai_rs2_addr :
		spec_insn_sraiw_valid ? spec_insn_sraiw_rs2_addr :
		spec_insn_sraw_valid ? spec_insn_sraw_rs2_addr :
		spec_insn_srl_valid ? spec_insn_srl_rs2_addr :
		spec_insn_srli_valid ? spec_insn_srli_rs2_addr :
		spec_insn_srliw_valid ? spec_insn_srliw_rs2_addr :
		spec_insn_srlw_valid ? spec_insn_srlw_rs2_addr :
		spec_insn_sub_valid ? spec_insn_sub_rs2_addr :
		spec_insn_subw_valid ? spec_insn_subw_rs2_addr :
		spec_insn_sw_valid ? spec_insn_sw_rs2_addr :
		spec_insn_xor_valid ? spec_insn_xor_rs2_addr :
		spec_insn_xori_valid ? spec_insn_xori_rs2_addr : 0;
  assign spec_rd_addr =
		spec_insn_add_valid ? spec_insn_add_rd_addr :
		spec_insn_addi_valid ? spec_insn_addi_rd_addr :
		spec_insn_addiw_valid ? spec_insn_addiw_rd_addr :
		spec_insn_addw_valid ? spec_insn_addw_rd_addr :
		spec_insn_and_valid ? spec_insn_and_rd_addr :
		spec_insn_andi_valid ? spec_insn_andi_rd_addr :
		spec_insn_auipc_valid ? spec_insn_auipc_rd_addr :
		spec_insn_beq_valid ? spec_insn_beq_rd_addr :
		spec_insn_bge_valid ? spec_insn_bge_rd_addr :
		spec_insn_bgeu_valid ? spec_insn_bgeu_rd_addr :
		spec_insn_blt_valid ? spec_insn_blt_rd_addr :
		spec_insn_bltu_valid ? spec_insn_bltu_rd_addr :
		spec_insn_bne_valid ? spec_insn_bne_rd_addr :
		spec_insn_c_add_valid ? spec_insn_c_add_rd_addr :
		spec_insn_c_addi_valid ? spec_insn_c_addi_rd_addr :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_rd_addr :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_rd_addr :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_rd_addr :
		spec_insn_c_addw_valid ? spec_insn_c_addw_rd_addr :
		spec_insn_c_and_valid ? spec_insn_c_and_rd_addr :
		spec_insn_c_andi_valid ? spec_insn_c_andi_rd_addr :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_rd_addr :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_rd_addr :
		spec_insn_c_j_valid ? spec_insn_c_j_rd_addr :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_rd_addr :
		spec_insn_c_jr_valid ? spec_insn_c_jr_rd_addr :
		spec_insn_c_ld_valid ? spec_insn_c_ld_rd_addr :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_rd_addr :
		spec_insn_c_li_valid ? spec_insn_c_li_rd_addr :
		spec_insn_c_lui_valid ? spec_insn_c_lui_rd_addr :
		spec_insn_c_lw_valid ? spec_insn_c_lw_rd_addr :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_rd_addr :
		spec_insn_c_mv_valid ? spec_insn_c_mv_rd_addr :
		spec_insn_c_or_valid ? spec_insn_c_or_rd_addr :
		spec_insn_c_sd_valid ? spec_insn_c_sd_rd_addr :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_rd_addr :
		spec_insn_c_slli_valid ? spec_insn_c_slli_rd_addr :
		spec_insn_c_srai_valid ? spec_insn_c_srai_rd_addr :
		spec_insn_c_srli_valid ? spec_insn_c_srli_rd_addr :
		spec_insn_c_sub_valid ? spec_insn_c_sub_rd_addr :
		spec_insn_c_subw_valid ? spec_insn_c_subw_rd_addr :
		spec_insn_c_sw_valid ? spec_insn_c_sw_rd_addr :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_rd_addr :
		spec_insn_c_xor_valid ? spec_insn_c_xor_rd_addr :
		spec_insn_div_valid ? spec_insn_div_rd_addr :
		spec_insn_divu_valid ? spec_insn_divu_rd_addr :
		spec_insn_divuw_valid ? spec_insn_divuw_rd_addr :
		spec_insn_divw_valid ? spec_insn_divw_rd_addr :
		spec_insn_jal_valid ? spec_insn_jal_rd_addr :
		spec_insn_jalr_valid ? spec_insn_jalr_rd_addr :
		spec_insn_lb_valid ? spec_insn_lb_rd_addr :
		spec_insn_lbu_valid ? spec_insn_lbu_rd_addr :
		spec_insn_ld_valid ? spec_insn_ld_rd_addr :
		spec_insn_lh_valid ? spec_insn_lh_rd_addr :
		spec_insn_lhu_valid ? spec_insn_lhu_rd_addr :
		spec_insn_lui_valid ? spec_insn_lui_rd_addr :
		spec_insn_lw_valid ? spec_insn_lw_rd_addr :
		spec_insn_lwu_valid ? spec_insn_lwu_rd_addr :
		spec_insn_mul_valid ? spec_insn_mul_rd_addr :
		spec_insn_mulh_valid ? spec_insn_mulh_rd_addr :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_rd_addr :
		spec_insn_mulhu_valid ? spec_insn_mulhu_rd_addr :
		spec_insn_mulw_valid ? spec_insn_mulw_rd_addr :
		spec_insn_or_valid ? spec_insn_or_rd_addr :
		spec_insn_ori_valid ? spec_insn_ori_rd_addr :
		spec_insn_rem_valid ? spec_insn_rem_rd_addr :
		spec_insn_remu_valid ? spec_insn_remu_rd_addr :
		spec_insn_remuw_valid ? spec_insn_remuw_rd_addr :
		spec_insn_remw_valid ? spec_insn_remw_rd_addr :
		spec_insn_sb_valid ? spec_insn_sb_rd_addr :
		spec_insn_sd_valid ? spec_insn_sd_rd_addr :
		spec_insn_sh_valid ? spec_insn_sh_rd_addr :
		spec_insn_sll_valid ? spec_insn_sll_rd_addr :
		spec_insn_slli_valid ? spec_insn_slli_rd_addr :
		spec_insn_slliw_valid ? spec_insn_slliw_rd_addr :
		spec_insn_sllw_valid ? spec_insn_sllw_rd_addr :
		spec_insn_slt_valid ? spec_insn_slt_rd_addr :
		spec_insn_slti_valid ? spec_insn_slti_rd_addr :
		spec_insn_sltiu_valid ? spec_insn_sltiu_rd_addr :
		spec_insn_sltu_valid ? spec_insn_sltu_rd_addr :
		spec_insn_sra_valid ? spec_insn_sra_rd_addr :
		spec_insn_srai_valid ? spec_insn_srai_rd_addr :
		spec_insn_sraiw_valid ? spec_insn_sraiw_rd_addr :
		spec_insn_sraw_valid ? spec_insn_sraw_rd_addr :
		spec_insn_srl_valid ? spec_insn_srl_rd_addr :
		spec_insn_srli_valid ? spec_insn_srli_rd_addr :
		spec_insn_srliw_valid ? spec_insn_srliw_rd_addr :
		spec_insn_srlw_valid ? spec_insn_srlw_rd_addr :
		spec_insn_sub_valid ? spec_insn_sub_rd_addr :
		spec_insn_subw_valid ? spec_insn_subw_rd_addr :
		spec_insn_sw_valid ? spec_insn_sw_rd_addr :
		spec_insn_xor_valid ? spec_insn_xor_rd_addr :
		spec_insn_xori_valid ? spec_insn_xori_rd_addr : 0;
  assign spec_rd_wdata =
		spec_insn_add_valid ? spec_insn_add_rd_wdata :
		spec_insn_addi_valid ? spec_insn_addi_rd_wdata :
		spec_insn_addiw_valid ? spec_insn_addiw_rd_wdata :
		spec_insn_addw_valid ? spec_insn_addw_rd_wdata :
		spec_insn_and_valid ? spec_insn_and_rd_wdata :
		spec_insn_andi_valid ? spec_insn_andi_rd_wdata :
		spec_insn_auipc_valid ? spec_insn_auipc_rd_wdata :
		spec_insn_beq_valid ? spec_insn_beq_rd_wdata :
		spec_insn_bge_valid ? spec_insn_bge_rd_wdata :
		spec_insn_bgeu_valid ? spec_insn_bgeu_rd_wdata :
		spec_insn_blt_valid ? spec_insn_blt_rd_wdata :
		spec_insn_bltu_valid ? spec_insn_bltu_rd_wdata :
		spec_insn_bne_valid ? spec_insn_bne_rd_wdata :
		spec_insn_c_add_valid ? spec_insn_c_add_rd_wdata :
		spec_insn_c_addi_valid ? spec_insn_c_addi_rd_wdata :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_rd_wdata :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_rd_wdata :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_rd_wdata :
		spec_insn_c_addw_valid ? spec_insn_c_addw_rd_wdata :
		spec_insn_c_and_valid ? spec_insn_c_and_rd_wdata :
		spec_insn_c_andi_valid ? spec_insn_c_andi_rd_wdata :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_rd_wdata :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_rd_wdata :
		spec_insn_c_j_valid ? spec_insn_c_j_rd_wdata :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_rd_wdata :
		spec_insn_c_jr_valid ? spec_insn_c_jr_rd_wdata :
		spec_insn_c_ld_valid ? spec_insn_c_ld_rd_wdata :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_rd_wdata :
		spec_insn_c_li_valid ? spec_insn_c_li_rd_wdata :
		spec_insn_c_lui_valid ? spec_insn_c_lui_rd_wdata :
		spec_insn_c_lw_valid ? spec_insn_c_lw_rd_wdata :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_rd_wdata :
		spec_insn_c_mv_valid ? spec_insn_c_mv_rd_wdata :
		spec_insn_c_or_valid ? spec_insn_c_or_rd_wdata :
		spec_insn_c_sd_valid ? spec_insn_c_sd_rd_wdata :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_rd_wdata :
		spec_insn_c_slli_valid ? spec_insn_c_slli_rd_wdata :
		spec_insn_c_srai_valid ? spec_insn_c_srai_rd_wdata :
		spec_insn_c_srli_valid ? spec_insn_c_srli_rd_wdata :
		spec_insn_c_sub_valid ? spec_insn_c_sub_rd_wdata :
		spec_insn_c_subw_valid ? spec_insn_c_subw_rd_wdata :
		spec_insn_c_sw_valid ? spec_insn_c_sw_rd_wdata :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_rd_wdata :
		spec_insn_c_xor_valid ? spec_insn_c_xor_rd_wdata :
		spec_insn_div_valid ? spec_insn_div_rd_wdata :
		spec_insn_divu_valid ? spec_insn_divu_rd_wdata :
		spec_insn_divuw_valid ? spec_insn_divuw_rd_wdata :
		spec_insn_divw_valid ? spec_insn_divw_rd_wdata :
		spec_insn_jal_valid ? spec_insn_jal_rd_wdata :
		spec_insn_jalr_valid ? spec_insn_jalr_rd_wdata :
		spec_insn_lb_valid ? spec_insn_lb_rd_wdata :
		spec_insn_lbu_valid ? spec_insn_lbu_rd_wdata :
		spec_insn_ld_valid ? spec_insn_ld_rd_wdata :
		spec_insn_lh_valid ? spec_insn_lh_rd_wdata :
		spec_insn_lhu_valid ? spec_insn_lhu_rd_wdata :
		spec_insn_lui_valid ? spec_insn_lui_rd_wdata :
		spec_insn_lw_valid ? spec_insn_lw_rd_wdata :
		spec_insn_lwu_valid ? spec_insn_lwu_rd_wdata :
		spec_insn_mul_valid ? spec_insn_mul_rd_wdata :
		spec_insn_mulh_valid ? spec_insn_mulh_rd_wdata :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_rd_wdata :
		spec_insn_mulhu_valid ? spec_insn_mulhu_rd_wdata :
		spec_insn_mulw_valid ? spec_insn_mulw_rd_wdata :
		spec_insn_or_valid ? spec_insn_or_rd_wdata :
		spec_insn_ori_valid ? spec_insn_ori_rd_wdata :
		spec_insn_rem_valid ? spec_insn_rem_rd_wdata :
		spec_insn_remu_valid ? spec_insn_remu_rd_wdata :
		spec_insn_remuw_valid ? spec_insn_remuw_rd_wdata :
		spec_insn_remw_valid ? spec_insn_remw_rd_wdata :
		spec_insn_sb_valid ? spec_insn_sb_rd_wdata :
		spec_insn_sd_valid ? spec_insn_sd_rd_wdata :
		spec_insn_sh_valid ? spec_insn_sh_rd_wdata :
		spec_insn_sll_valid ? spec_insn_sll_rd_wdata :
		spec_insn_slli_valid ? spec_insn_slli_rd_wdata :
		spec_insn_slliw_valid ? spec_insn_slliw_rd_wdata :
		spec_insn_sllw_valid ? spec_insn_sllw_rd_wdata :
		spec_insn_slt_valid ? spec_insn_slt_rd_wdata :
		spec_insn_slti_valid ? spec_insn_slti_rd_wdata :
		spec_insn_sltiu_valid ? spec_insn_sltiu_rd_wdata :
		spec_insn_sltu_valid ? spec_insn_sltu_rd_wdata :
		spec_insn_sra_valid ? spec_insn_sra_rd_wdata :
		spec_insn_srai_valid ? spec_insn_srai_rd_wdata :
		spec_insn_sraiw_valid ? spec_insn_sraiw_rd_wdata :
		spec_insn_sraw_valid ? spec_insn_sraw_rd_wdata :
		spec_insn_srl_valid ? spec_insn_srl_rd_wdata :
		spec_insn_srli_valid ? spec_insn_srli_rd_wdata :
		spec_insn_srliw_valid ? spec_insn_srliw_rd_wdata :
		spec_insn_srlw_valid ? spec_insn_srlw_rd_wdata :
		spec_insn_sub_valid ? spec_insn_sub_rd_wdata :
		spec_insn_subw_valid ? spec_insn_subw_rd_wdata :
		spec_insn_sw_valid ? spec_insn_sw_rd_wdata :
		spec_insn_xor_valid ? spec_insn_xor_rd_wdata :
		spec_insn_xori_valid ? spec_insn_xori_rd_wdata : 0;
  assign spec_pc_wdata =
		spec_insn_add_valid ? spec_insn_add_pc_wdata :
		spec_insn_addi_valid ? spec_insn_addi_pc_wdata :
		spec_insn_addiw_valid ? spec_insn_addiw_pc_wdata :
		spec_insn_addw_valid ? spec_insn_addw_pc_wdata :
		spec_insn_and_valid ? spec_insn_and_pc_wdata :
		spec_insn_andi_valid ? spec_insn_andi_pc_wdata :
		spec_insn_auipc_valid ? spec_insn_auipc_pc_wdata :
		spec_insn_beq_valid ? spec_insn_beq_pc_wdata :
		spec_insn_bge_valid ? spec_insn_bge_pc_wdata :
		spec_insn_bgeu_valid ? spec_insn_bgeu_pc_wdata :
		spec_insn_blt_valid ? spec_insn_blt_pc_wdata :
		spec_insn_bltu_valid ? spec_insn_bltu_pc_wdata :
		spec_insn_bne_valid ? spec_insn_bne_pc_wdata :
		spec_insn_c_add_valid ? spec_insn_c_add_pc_wdata :
		spec_insn_c_addi_valid ? spec_insn_c_addi_pc_wdata :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_pc_wdata :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_pc_wdata :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_pc_wdata :
		spec_insn_c_addw_valid ? spec_insn_c_addw_pc_wdata :
		spec_insn_c_and_valid ? spec_insn_c_and_pc_wdata :
		spec_insn_c_andi_valid ? spec_insn_c_andi_pc_wdata :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_pc_wdata :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_pc_wdata :
		spec_insn_c_j_valid ? spec_insn_c_j_pc_wdata :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_pc_wdata :
		spec_insn_c_jr_valid ? spec_insn_c_jr_pc_wdata :
		spec_insn_c_ld_valid ? spec_insn_c_ld_pc_wdata :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_pc_wdata :
		spec_insn_c_li_valid ? spec_insn_c_li_pc_wdata :
		spec_insn_c_lui_valid ? spec_insn_c_lui_pc_wdata :
		spec_insn_c_lw_valid ? spec_insn_c_lw_pc_wdata :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_pc_wdata :
		spec_insn_c_mv_valid ? spec_insn_c_mv_pc_wdata :
		spec_insn_c_or_valid ? spec_insn_c_or_pc_wdata :
		spec_insn_c_sd_valid ? spec_insn_c_sd_pc_wdata :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_pc_wdata :
		spec_insn_c_slli_valid ? spec_insn_c_slli_pc_wdata :
		spec_insn_c_srai_valid ? spec_insn_c_srai_pc_wdata :
		spec_insn_c_srli_valid ? spec_insn_c_srli_pc_wdata :
		spec_insn_c_sub_valid ? spec_insn_c_sub_pc_wdata :
		spec_insn_c_subw_valid ? spec_insn_c_subw_pc_wdata :
		spec_insn_c_sw_valid ? spec_insn_c_sw_pc_wdata :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_pc_wdata :
		spec_insn_c_xor_valid ? spec_insn_c_xor_pc_wdata :
		spec_insn_div_valid ? spec_insn_div_pc_wdata :
		spec_insn_divu_valid ? spec_insn_divu_pc_wdata :
		spec_insn_divuw_valid ? spec_insn_divuw_pc_wdata :
		spec_insn_divw_valid ? spec_insn_divw_pc_wdata :
		spec_insn_jal_valid ? spec_insn_jal_pc_wdata :
		spec_insn_jalr_valid ? spec_insn_jalr_pc_wdata :
		spec_insn_lb_valid ? spec_insn_lb_pc_wdata :
		spec_insn_lbu_valid ? spec_insn_lbu_pc_wdata :
		spec_insn_ld_valid ? spec_insn_ld_pc_wdata :
		spec_insn_lh_valid ? spec_insn_lh_pc_wdata :
		spec_insn_lhu_valid ? spec_insn_lhu_pc_wdata :
		spec_insn_lui_valid ? spec_insn_lui_pc_wdata :
		spec_insn_lw_valid ? spec_insn_lw_pc_wdata :
		spec_insn_lwu_valid ? spec_insn_lwu_pc_wdata :
		spec_insn_mul_valid ? spec_insn_mul_pc_wdata :
		spec_insn_mulh_valid ? spec_insn_mulh_pc_wdata :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_pc_wdata :
		spec_insn_mulhu_valid ? spec_insn_mulhu_pc_wdata :
		spec_insn_mulw_valid ? spec_insn_mulw_pc_wdata :
		spec_insn_or_valid ? spec_insn_or_pc_wdata :
		spec_insn_ori_valid ? spec_insn_ori_pc_wdata :
		spec_insn_rem_valid ? spec_insn_rem_pc_wdata :
		spec_insn_remu_valid ? spec_insn_remu_pc_wdata :
		spec_insn_remuw_valid ? spec_insn_remuw_pc_wdata :
		spec_insn_remw_valid ? spec_insn_remw_pc_wdata :
		spec_insn_sb_valid ? spec_insn_sb_pc_wdata :
		spec_insn_sd_valid ? spec_insn_sd_pc_wdata :
		spec_insn_sh_valid ? spec_insn_sh_pc_wdata :
		spec_insn_sll_valid ? spec_insn_sll_pc_wdata :
		spec_insn_slli_valid ? spec_insn_slli_pc_wdata :
		spec_insn_slliw_valid ? spec_insn_slliw_pc_wdata :
		spec_insn_sllw_valid ? spec_insn_sllw_pc_wdata :
		spec_insn_slt_valid ? spec_insn_slt_pc_wdata :
		spec_insn_slti_valid ? spec_insn_slti_pc_wdata :
		spec_insn_sltiu_valid ? spec_insn_sltiu_pc_wdata :
		spec_insn_sltu_valid ? spec_insn_sltu_pc_wdata :
		spec_insn_sra_valid ? spec_insn_sra_pc_wdata :
		spec_insn_srai_valid ? spec_insn_srai_pc_wdata :
		spec_insn_sraiw_valid ? spec_insn_sraiw_pc_wdata :
		spec_insn_sraw_valid ? spec_insn_sraw_pc_wdata :
		spec_insn_srl_valid ? spec_insn_srl_pc_wdata :
		spec_insn_srli_valid ? spec_insn_srli_pc_wdata :
		spec_insn_srliw_valid ? spec_insn_srliw_pc_wdata :
		spec_insn_srlw_valid ? spec_insn_srlw_pc_wdata :
		spec_insn_sub_valid ? spec_insn_sub_pc_wdata :
		spec_insn_subw_valid ? spec_insn_subw_pc_wdata :
		spec_insn_sw_valid ? spec_insn_sw_pc_wdata :
		spec_insn_xor_valid ? spec_insn_xor_pc_wdata :
		spec_insn_xori_valid ? spec_insn_xori_pc_wdata : 0;
  assign spec_mem_addr =
		spec_insn_add_valid ? spec_insn_add_mem_addr :
		spec_insn_addi_valid ? spec_insn_addi_mem_addr :
		spec_insn_addiw_valid ? spec_insn_addiw_mem_addr :
		spec_insn_addw_valid ? spec_insn_addw_mem_addr :
		spec_insn_and_valid ? spec_insn_and_mem_addr :
		spec_insn_andi_valid ? spec_insn_andi_mem_addr :
		spec_insn_auipc_valid ? spec_insn_auipc_mem_addr :
		spec_insn_beq_valid ? spec_insn_beq_mem_addr :
		spec_insn_bge_valid ? spec_insn_bge_mem_addr :
		spec_insn_bgeu_valid ? spec_insn_bgeu_mem_addr :
		spec_insn_blt_valid ? spec_insn_blt_mem_addr :
		spec_insn_bltu_valid ? spec_insn_bltu_mem_addr :
		spec_insn_bne_valid ? spec_insn_bne_mem_addr :
		spec_insn_c_add_valid ? spec_insn_c_add_mem_addr :
		spec_insn_c_addi_valid ? spec_insn_c_addi_mem_addr :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_mem_addr :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_mem_addr :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_mem_addr :
		spec_insn_c_addw_valid ? spec_insn_c_addw_mem_addr :
		spec_insn_c_and_valid ? spec_insn_c_and_mem_addr :
		spec_insn_c_andi_valid ? spec_insn_c_andi_mem_addr :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_mem_addr :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_mem_addr :
		spec_insn_c_j_valid ? spec_insn_c_j_mem_addr :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_mem_addr :
		spec_insn_c_jr_valid ? spec_insn_c_jr_mem_addr :
		spec_insn_c_ld_valid ? spec_insn_c_ld_mem_addr :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_mem_addr :
		spec_insn_c_li_valid ? spec_insn_c_li_mem_addr :
		spec_insn_c_lui_valid ? spec_insn_c_lui_mem_addr :
		spec_insn_c_lw_valid ? spec_insn_c_lw_mem_addr :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_mem_addr :
		spec_insn_c_mv_valid ? spec_insn_c_mv_mem_addr :
		spec_insn_c_or_valid ? spec_insn_c_or_mem_addr :
		spec_insn_c_sd_valid ? spec_insn_c_sd_mem_addr :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_mem_addr :
		spec_insn_c_slli_valid ? spec_insn_c_slli_mem_addr :
		spec_insn_c_srai_valid ? spec_insn_c_srai_mem_addr :
		spec_insn_c_srli_valid ? spec_insn_c_srli_mem_addr :
		spec_insn_c_sub_valid ? spec_insn_c_sub_mem_addr :
		spec_insn_c_subw_valid ? spec_insn_c_subw_mem_addr :
		spec_insn_c_sw_valid ? spec_insn_c_sw_mem_addr :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_mem_addr :
		spec_insn_c_xor_valid ? spec_insn_c_xor_mem_addr :
		spec_insn_div_valid ? spec_insn_div_mem_addr :
		spec_insn_divu_valid ? spec_insn_divu_mem_addr :
		spec_insn_divuw_valid ? spec_insn_divuw_mem_addr :
		spec_insn_divw_valid ? spec_insn_divw_mem_addr :
		spec_insn_jal_valid ? spec_insn_jal_mem_addr :
		spec_insn_jalr_valid ? spec_insn_jalr_mem_addr :
		spec_insn_lb_valid ? spec_insn_lb_mem_addr :
		spec_insn_lbu_valid ? spec_insn_lbu_mem_addr :
		spec_insn_ld_valid ? spec_insn_ld_mem_addr :
		spec_insn_lh_valid ? spec_insn_lh_mem_addr :
		spec_insn_lhu_valid ? spec_insn_lhu_mem_addr :
		spec_insn_lui_valid ? spec_insn_lui_mem_addr :
		spec_insn_lw_valid ? spec_insn_lw_mem_addr :
		spec_insn_lwu_valid ? spec_insn_lwu_mem_addr :
		spec_insn_mul_valid ? spec_insn_mul_mem_addr :
		spec_insn_mulh_valid ? spec_insn_mulh_mem_addr :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_mem_addr :
		spec_insn_mulhu_valid ? spec_insn_mulhu_mem_addr :
		spec_insn_mulw_valid ? spec_insn_mulw_mem_addr :
		spec_insn_or_valid ? spec_insn_or_mem_addr :
		spec_insn_ori_valid ? spec_insn_ori_mem_addr :
		spec_insn_rem_valid ? spec_insn_rem_mem_addr :
		spec_insn_remu_valid ? spec_insn_remu_mem_addr :
		spec_insn_remuw_valid ? spec_insn_remuw_mem_addr :
		spec_insn_remw_valid ? spec_insn_remw_mem_addr :
		spec_insn_sb_valid ? spec_insn_sb_mem_addr :
		spec_insn_sd_valid ? spec_insn_sd_mem_addr :
		spec_insn_sh_valid ? spec_insn_sh_mem_addr :
		spec_insn_sll_valid ? spec_insn_sll_mem_addr :
		spec_insn_slli_valid ? spec_insn_slli_mem_addr :
		spec_insn_slliw_valid ? spec_insn_slliw_mem_addr :
		spec_insn_sllw_valid ? spec_insn_sllw_mem_addr :
		spec_insn_slt_valid ? spec_insn_slt_mem_addr :
		spec_insn_slti_valid ? spec_insn_slti_mem_addr :
		spec_insn_sltiu_valid ? spec_insn_sltiu_mem_addr :
		spec_insn_sltu_valid ? spec_insn_sltu_mem_addr :
		spec_insn_sra_valid ? spec_insn_sra_mem_addr :
		spec_insn_srai_valid ? spec_insn_srai_mem_addr :
		spec_insn_sraiw_valid ? spec_insn_sraiw_mem_addr :
		spec_insn_sraw_valid ? spec_insn_sraw_mem_addr :
		spec_insn_srl_valid ? spec_insn_srl_mem_addr :
		spec_insn_srli_valid ? spec_insn_srli_mem_addr :
		spec_insn_srliw_valid ? spec_insn_srliw_mem_addr :
		spec_insn_srlw_valid ? spec_insn_srlw_mem_addr :
		spec_insn_sub_valid ? spec_insn_sub_mem_addr :
		spec_insn_subw_valid ? spec_insn_subw_mem_addr :
		spec_insn_sw_valid ? spec_insn_sw_mem_addr :
		spec_insn_xor_valid ? spec_insn_xor_mem_addr :
		spec_insn_xori_valid ? spec_insn_xori_mem_addr : 0;
  assign spec_mem_rmask =
		spec_insn_add_valid ? spec_insn_add_mem_rmask :
		spec_insn_addi_valid ? spec_insn_addi_mem_rmask :
		spec_insn_addiw_valid ? spec_insn_addiw_mem_rmask :
		spec_insn_addw_valid ? spec_insn_addw_mem_rmask :
		spec_insn_and_valid ? spec_insn_and_mem_rmask :
		spec_insn_andi_valid ? spec_insn_andi_mem_rmask :
		spec_insn_auipc_valid ? spec_insn_auipc_mem_rmask :
		spec_insn_beq_valid ? spec_insn_beq_mem_rmask :
		spec_insn_bge_valid ? spec_insn_bge_mem_rmask :
		spec_insn_bgeu_valid ? spec_insn_bgeu_mem_rmask :
		spec_insn_blt_valid ? spec_insn_blt_mem_rmask :
		spec_insn_bltu_valid ? spec_insn_bltu_mem_rmask :
		spec_insn_bne_valid ? spec_insn_bne_mem_rmask :
		spec_insn_c_add_valid ? spec_insn_c_add_mem_rmask :
		spec_insn_c_addi_valid ? spec_insn_c_addi_mem_rmask :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_mem_rmask :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_mem_rmask :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_mem_rmask :
		spec_insn_c_addw_valid ? spec_insn_c_addw_mem_rmask :
		spec_insn_c_and_valid ? spec_insn_c_and_mem_rmask :
		spec_insn_c_andi_valid ? spec_insn_c_andi_mem_rmask :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_mem_rmask :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_mem_rmask :
		spec_insn_c_j_valid ? spec_insn_c_j_mem_rmask :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_mem_rmask :
		spec_insn_c_jr_valid ? spec_insn_c_jr_mem_rmask :
		spec_insn_c_ld_valid ? spec_insn_c_ld_mem_rmask :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_mem_rmask :
		spec_insn_c_li_valid ? spec_insn_c_li_mem_rmask :
		spec_insn_c_lui_valid ? spec_insn_c_lui_mem_rmask :
		spec_insn_c_lw_valid ? spec_insn_c_lw_mem_rmask :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_mem_rmask :
		spec_insn_c_mv_valid ? spec_insn_c_mv_mem_rmask :
		spec_insn_c_or_valid ? spec_insn_c_or_mem_rmask :
		spec_insn_c_sd_valid ? spec_insn_c_sd_mem_rmask :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_mem_rmask :
		spec_insn_c_slli_valid ? spec_insn_c_slli_mem_rmask :
		spec_insn_c_srai_valid ? spec_insn_c_srai_mem_rmask :
		spec_insn_c_srli_valid ? spec_insn_c_srli_mem_rmask :
		spec_insn_c_sub_valid ? spec_insn_c_sub_mem_rmask :
		spec_insn_c_subw_valid ? spec_insn_c_subw_mem_rmask :
		spec_insn_c_sw_valid ? spec_insn_c_sw_mem_rmask :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_mem_rmask :
		spec_insn_c_xor_valid ? spec_insn_c_xor_mem_rmask :
		spec_insn_div_valid ? spec_insn_div_mem_rmask :
		spec_insn_divu_valid ? spec_insn_divu_mem_rmask :
		spec_insn_divuw_valid ? spec_insn_divuw_mem_rmask :
		spec_insn_divw_valid ? spec_insn_divw_mem_rmask :
		spec_insn_jal_valid ? spec_insn_jal_mem_rmask :
		spec_insn_jalr_valid ? spec_insn_jalr_mem_rmask :
		spec_insn_lb_valid ? spec_insn_lb_mem_rmask :
		spec_insn_lbu_valid ? spec_insn_lbu_mem_rmask :
		spec_insn_ld_valid ? spec_insn_ld_mem_rmask :
		spec_insn_lh_valid ? spec_insn_lh_mem_rmask :
		spec_insn_lhu_valid ? spec_insn_lhu_mem_rmask :
		spec_insn_lui_valid ? spec_insn_lui_mem_rmask :
		spec_insn_lw_valid ? spec_insn_lw_mem_rmask :
		spec_insn_lwu_valid ? spec_insn_lwu_mem_rmask :
		spec_insn_mul_valid ? spec_insn_mul_mem_rmask :
		spec_insn_mulh_valid ? spec_insn_mulh_mem_rmask :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_mem_rmask :
		spec_insn_mulhu_valid ? spec_insn_mulhu_mem_rmask :
		spec_insn_mulw_valid ? spec_insn_mulw_mem_rmask :
		spec_insn_or_valid ? spec_insn_or_mem_rmask :
		spec_insn_ori_valid ? spec_insn_ori_mem_rmask :
		spec_insn_rem_valid ? spec_insn_rem_mem_rmask :
		spec_insn_remu_valid ? spec_insn_remu_mem_rmask :
		spec_insn_remuw_valid ? spec_insn_remuw_mem_rmask :
		spec_insn_remw_valid ? spec_insn_remw_mem_rmask :
		spec_insn_sb_valid ? spec_insn_sb_mem_rmask :
		spec_insn_sd_valid ? spec_insn_sd_mem_rmask :
		spec_insn_sh_valid ? spec_insn_sh_mem_rmask :
		spec_insn_sll_valid ? spec_insn_sll_mem_rmask :
		spec_insn_slli_valid ? spec_insn_slli_mem_rmask :
		spec_insn_slliw_valid ? spec_insn_slliw_mem_rmask :
		spec_insn_sllw_valid ? spec_insn_sllw_mem_rmask :
		spec_insn_slt_valid ? spec_insn_slt_mem_rmask :
		spec_insn_slti_valid ? spec_insn_slti_mem_rmask :
		spec_insn_sltiu_valid ? spec_insn_sltiu_mem_rmask :
		spec_insn_sltu_valid ? spec_insn_sltu_mem_rmask :
		spec_insn_sra_valid ? spec_insn_sra_mem_rmask :
		spec_insn_srai_valid ? spec_insn_srai_mem_rmask :
		spec_insn_sraiw_valid ? spec_insn_sraiw_mem_rmask :
		spec_insn_sraw_valid ? spec_insn_sraw_mem_rmask :
		spec_insn_srl_valid ? spec_insn_srl_mem_rmask :
		spec_insn_srli_valid ? spec_insn_srli_mem_rmask :
		spec_insn_srliw_valid ? spec_insn_srliw_mem_rmask :
		spec_insn_srlw_valid ? spec_insn_srlw_mem_rmask :
		spec_insn_sub_valid ? spec_insn_sub_mem_rmask :
		spec_insn_subw_valid ? spec_insn_subw_mem_rmask :
		spec_insn_sw_valid ? spec_insn_sw_mem_rmask :
		spec_insn_xor_valid ? spec_insn_xor_mem_rmask :
		spec_insn_xori_valid ? spec_insn_xori_mem_rmask : 0;
  assign spec_mem_wmask =
		spec_insn_add_valid ? spec_insn_add_mem_wmask :
		spec_insn_addi_valid ? spec_insn_addi_mem_wmask :
		spec_insn_addiw_valid ? spec_insn_addiw_mem_wmask :
		spec_insn_addw_valid ? spec_insn_addw_mem_wmask :
		spec_insn_and_valid ? spec_insn_and_mem_wmask :
		spec_insn_andi_valid ? spec_insn_andi_mem_wmask :
		spec_insn_auipc_valid ? spec_insn_auipc_mem_wmask :
		spec_insn_beq_valid ? spec_insn_beq_mem_wmask :
		spec_insn_bge_valid ? spec_insn_bge_mem_wmask :
		spec_insn_bgeu_valid ? spec_insn_bgeu_mem_wmask :
		spec_insn_blt_valid ? spec_insn_blt_mem_wmask :
		spec_insn_bltu_valid ? spec_insn_bltu_mem_wmask :
		spec_insn_bne_valid ? spec_insn_bne_mem_wmask :
		spec_insn_c_add_valid ? spec_insn_c_add_mem_wmask :
		spec_insn_c_addi_valid ? spec_insn_c_addi_mem_wmask :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_mem_wmask :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_mem_wmask :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_mem_wmask :
		spec_insn_c_addw_valid ? spec_insn_c_addw_mem_wmask :
		spec_insn_c_and_valid ? spec_insn_c_and_mem_wmask :
		spec_insn_c_andi_valid ? spec_insn_c_andi_mem_wmask :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_mem_wmask :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_mem_wmask :
		spec_insn_c_j_valid ? spec_insn_c_j_mem_wmask :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_mem_wmask :
		spec_insn_c_jr_valid ? spec_insn_c_jr_mem_wmask :
		spec_insn_c_ld_valid ? spec_insn_c_ld_mem_wmask :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_mem_wmask :
		spec_insn_c_li_valid ? spec_insn_c_li_mem_wmask :
		spec_insn_c_lui_valid ? spec_insn_c_lui_mem_wmask :
		spec_insn_c_lw_valid ? spec_insn_c_lw_mem_wmask :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_mem_wmask :
		spec_insn_c_mv_valid ? spec_insn_c_mv_mem_wmask :
		spec_insn_c_or_valid ? spec_insn_c_or_mem_wmask :
		spec_insn_c_sd_valid ? spec_insn_c_sd_mem_wmask :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_mem_wmask :
		spec_insn_c_slli_valid ? spec_insn_c_slli_mem_wmask :
		spec_insn_c_srai_valid ? spec_insn_c_srai_mem_wmask :
		spec_insn_c_srli_valid ? spec_insn_c_srli_mem_wmask :
		spec_insn_c_sub_valid ? spec_insn_c_sub_mem_wmask :
		spec_insn_c_subw_valid ? spec_insn_c_subw_mem_wmask :
		spec_insn_c_sw_valid ? spec_insn_c_sw_mem_wmask :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_mem_wmask :
		spec_insn_c_xor_valid ? spec_insn_c_xor_mem_wmask :
		spec_insn_div_valid ? spec_insn_div_mem_wmask :
		spec_insn_divu_valid ? spec_insn_divu_mem_wmask :
		spec_insn_divuw_valid ? spec_insn_divuw_mem_wmask :
		spec_insn_divw_valid ? spec_insn_divw_mem_wmask :
		spec_insn_jal_valid ? spec_insn_jal_mem_wmask :
		spec_insn_jalr_valid ? spec_insn_jalr_mem_wmask :
		spec_insn_lb_valid ? spec_insn_lb_mem_wmask :
		spec_insn_lbu_valid ? spec_insn_lbu_mem_wmask :
		spec_insn_ld_valid ? spec_insn_ld_mem_wmask :
		spec_insn_lh_valid ? spec_insn_lh_mem_wmask :
		spec_insn_lhu_valid ? spec_insn_lhu_mem_wmask :
		spec_insn_lui_valid ? spec_insn_lui_mem_wmask :
		spec_insn_lw_valid ? spec_insn_lw_mem_wmask :
		spec_insn_lwu_valid ? spec_insn_lwu_mem_wmask :
		spec_insn_mul_valid ? spec_insn_mul_mem_wmask :
		spec_insn_mulh_valid ? spec_insn_mulh_mem_wmask :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_mem_wmask :
		spec_insn_mulhu_valid ? spec_insn_mulhu_mem_wmask :
		spec_insn_mulw_valid ? spec_insn_mulw_mem_wmask :
		spec_insn_or_valid ? spec_insn_or_mem_wmask :
		spec_insn_ori_valid ? spec_insn_ori_mem_wmask :
		spec_insn_rem_valid ? spec_insn_rem_mem_wmask :
		spec_insn_remu_valid ? spec_insn_remu_mem_wmask :
		spec_insn_remuw_valid ? spec_insn_remuw_mem_wmask :
		spec_insn_remw_valid ? spec_insn_remw_mem_wmask :
		spec_insn_sb_valid ? spec_insn_sb_mem_wmask :
		spec_insn_sd_valid ? spec_insn_sd_mem_wmask :
		spec_insn_sh_valid ? spec_insn_sh_mem_wmask :
		spec_insn_sll_valid ? spec_insn_sll_mem_wmask :
		spec_insn_slli_valid ? spec_insn_slli_mem_wmask :
		spec_insn_slliw_valid ? spec_insn_slliw_mem_wmask :
		spec_insn_sllw_valid ? spec_insn_sllw_mem_wmask :
		spec_insn_slt_valid ? spec_insn_slt_mem_wmask :
		spec_insn_slti_valid ? spec_insn_slti_mem_wmask :
		spec_insn_sltiu_valid ? spec_insn_sltiu_mem_wmask :
		spec_insn_sltu_valid ? spec_insn_sltu_mem_wmask :
		spec_insn_sra_valid ? spec_insn_sra_mem_wmask :
		spec_insn_srai_valid ? spec_insn_srai_mem_wmask :
		spec_insn_sraiw_valid ? spec_insn_sraiw_mem_wmask :
		spec_insn_sraw_valid ? spec_insn_sraw_mem_wmask :
		spec_insn_srl_valid ? spec_insn_srl_mem_wmask :
		spec_insn_srli_valid ? spec_insn_srli_mem_wmask :
		spec_insn_srliw_valid ? spec_insn_srliw_mem_wmask :
		spec_insn_srlw_valid ? spec_insn_srlw_mem_wmask :
		spec_insn_sub_valid ? spec_insn_sub_mem_wmask :
		spec_insn_subw_valid ? spec_insn_subw_mem_wmask :
		spec_insn_sw_valid ? spec_insn_sw_mem_wmask :
		spec_insn_xor_valid ? spec_insn_xor_mem_wmask :
		spec_insn_xori_valid ? spec_insn_xori_mem_wmask : 0;
  assign spec_mem_wdata =
		spec_insn_add_valid ? spec_insn_add_mem_wdata :
		spec_insn_addi_valid ? spec_insn_addi_mem_wdata :
		spec_insn_addiw_valid ? spec_insn_addiw_mem_wdata :
		spec_insn_addw_valid ? spec_insn_addw_mem_wdata :
		spec_insn_and_valid ? spec_insn_and_mem_wdata :
		spec_insn_andi_valid ? spec_insn_andi_mem_wdata :
		spec_insn_auipc_valid ? spec_insn_auipc_mem_wdata :
		spec_insn_beq_valid ? spec_insn_beq_mem_wdata :
		spec_insn_bge_valid ? spec_insn_bge_mem_wdata :
		spec_insn_bgeu_valid ? spec_insn_bgeu_mem_wdata :
		spec_insn_blt_valid ? spec_insn_blt_mem_wdata :
		spec_insn_bltu_valid ? spec_insn_bltu_mem_wdata :
		spec_insn_bne_valid ? spec_insn_bne_mem_wdata :
		spec_insn_c_add_valid ? spec_insn_c_add_mem_wdata :
		spec_insn_c_addi_valid ? spec_insn_c_addi_mem_wdata :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_mem_wdata :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_mem_wdata :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_mem_wdata :
		spec_insn_c_addw_valid ? spec_insn_c_addw_mem_wdata :
		spec_insn_c_and_valid ? spec_insn_c_and_mem_wdata :
		spec_insn_c_andi_valid ? spec_insn_c_andi_mem_wdata :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_mem_wdata :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_mem_wdata :
		spec_insn_c_j_valid ? spec_insn_c_j_mem_wdata :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_mem_wdata :
		spec_insn_c_jr_valid ? spec_insn_c_jr_mem_wdata :
		spec_insn_c_ld_valid ? spec_insn_c_ld_mem_wdata :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_mem_wdata :
		spec_insn_c_li_valid ? spec_insn_c_li_mem_wdata :
		spec_insn_c_lui_valid ? spec_insn_c_lui_mem_wdata :
		spec_insn_c_lw_valid ? spec_insn_c_lw_mem_wdata :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_mem_wdata :
		spec_insn_c_mv_valid ? spec_insn_c_mv_mem_wdata :
		spec_insn_c_or_valid ? spec_insn_c_or_mem_wdata :
		spec_insn_c_sd_valid ? spec_insn_c_sd_mem_wdata :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_mem_wdata :
		spec_insn_c_slli_valid ? spec_insn_c_slli_mem_wdata :
		spec_insn_c_srai_valid ? spec_insn_c_srai_mem_wdata :
		spec_insn_c_srli_valid ? spec_insn_c_srli_mem_wdata :
		spec_insn_c_sub_valid ? spec_insn_c_sub_mem_wdata :
		spec_insn_c_subw_valid ? spec_insn_c_subw_mem_wdata :
		spec_insn_c_sw_valid ? spec_insn_c_sw_mem_wdata :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_mem_wdata :
		spec_insn_c_xor_valid ? spec_insn_c_xor_mem_wdata :
		spec_insn_div_valid ? spec_insn_div_mem_wdata :
		spec_insn_divu_valid ? spec_insn_divu_mem_wdata :
		spec_insn_divuw_valid ? spec_insn_divuw_mem_wdata :
		spec_insn_divw_valid ? spec_insn_divw_mem_wdata :
		spec_insn_jal_valid ? spec_insn_jal_mem_wdata :
		spec_insn_jalr_valid ? spec_insn_jalr_mem_wdata :
		spec_insn_lb_valid ? spec_insn_lb_mem_wdata :
		spec_insn_lbu_valid ? spec_insn_lbu_mem_wdata :
		spec_insn_ld_valid ? spec_insn_ld_mem_wdata :
		spec_insn_lh_valid ? spec_insn_lh_mem_wdata :
		spec_insn_lhu_valid ? spec_insn_lhu_mem_wdata :
		spec_insn_lui_valid ? spec_insn_lui_mem_wdata :
		spec_insn_lw_valid ? spec_insn_lw_mem_wdata :
		spec_insn_lwu_valid ? spec_insn_lwu_mem_wdata :
		spec_insn_mul_valid ? spec_insn_mul_mem_wdata :
		spec_insn_mulh_valid ? spec_insn_mulh_mem_wdata :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_mem_wdata :
		spec_insn_mulhu_valid ? spec_insn_mulhu_mem_wdata :
		spec_insn_mulw_valid ? spec_insn_mulw_mem_wdata :
		spec_insn_or_valid ? spec_insn_or_mem_wdata :
		spec_insn_ori_valid ? spec_insn_ori_mem_wdata :
		spec_insn_rem_valid ? spec_insn_rem_mem_wdata :
		spec_insn_remu_valid ? spec_insn_remu_mem_wdata :
		spec_insn_remuw_valid ? spec_insn_remuw_mem_wdata :
		spec_insn_remw_valid ? spec_insn_remw_mem_wdata :
		spec_insn_sb_valid ? spec_insn_sb_mem_wdata :
		spec_insn_sd_valid ? spec_insn_sd_mem_wdata :
		spec_insn_sh_valid ? spec_insn_sh_mem_wdata :
		spec_insn_sll_valid ? spec_insn_sll_mem_wdata :
		spec_insn_slli_valid ? spec_insn_slli_mem_wdata :
		spec_insn_slliw_valid ? spec_insn_slliw_mem_wdata :
		spec_insn_sllw_valid ? spec_insn_sllw_mem_wdata :
		spec_insn_slt_valid ? spec_insn_slt_mem_wdata :
		spec_insn_slti_valid ? spec_insn_slti_mem_wdata :
		spec_insn_sltiu_valid ? spec_insn_sltiu_mem_wdata :
		spec_insn_sltu_valid ? spec_insn_sltu_mem_wdata :
		spec_insn_sra_valid ? spec_insn_sra_mem_wdata :
		spec_insn_srai_valid ? spec_insn_srai_mem_wdata :
		spec_insn_sraiw_valid ? spec_insn_sraiw_mem_wdata :
		spec_insn_sraw_valid ? spec_insn_sraw_mem_wdata :
		spec_insn_srl_valid ? spec_insn_srl_mem_wdata :
		spec_insn_srli_valid ? spec_insn_srli_mem_wdata :
		spec_insn_srliw_valid ? spec_insn_srliw_mem_wdata :
		spec_insn_srlw_valid ? spec_insn_srlw_mem_wdata :
		spec_insn_sub_valid ? spec_insn_sub_mem_wdata :
		spec_insn_subw_valid ? spec_insn_subw_mem_wdata :
		spec_insn_sw_valid ? spec_insn_sw_mem_wdata :
		spec_insn_xor_valid ? spec_insn_xor_mem_wdata :
		spec_insn_xori_valid ? spec_insn_xori_mem_wdata : 0;
`ifdef RISCV_FORMAL_CSR_MISA
  assign spec_csr_misa_rmask =
		spec_insn_add_valid ? spec_insn_add_csr_misa_rmask :
		spec_insn_addi_valid ? spec_insn_addi_csr_misa_rmask :
		spec_insn_addiw_valid ? spec_insn_addiw_csr_misa_rmask :
		spec_insn_addw_valid ? spec_insn_addw_csr_misa_rmask :
		spec_insn_and_valid ? spec_insn_and_csr_misa_rmask :
		spec_insn_andi_valid ? spec_insn_andi_csr_misa_rmask :
		spec_insn_auipc_valid ? spec_insn_auipc_csr_misa_rmask :
		spec_insn_beq_valid ? spec_insn_beq_csr_misa_rmask :
		spec_insn_bge_valid ? spec_insn_bge_csr_misa_rmask :
		spec_insn_bgeu_valid ? spec_insn_bgeu_csr_misa_rmask :
		spec_insn_blt_valid ? spec_insn_blt_csr_misa_rmask :
		spec_insn_bltu_valid ? spec_insn_bltu_csr_misa_rmask :
		spec_insn_bne_valid ? spec_insn_bne_csr_misa_rmask :
		spec_insn_c_add_valid ? spec_insn_c_add_csr_misa_rmask :
		spec_insn_c_addi_valid ? spec_insn_c_addi_csr_misa_rmask :
		spec_insn_c_addi16sp_valid ? spec_insn_c_addi16sp_csr_misa_rmask :
		spec_insn_c_addi4spn_valid ? spec_insn_c_addi4spn_csr_misa_rmask :
		spec_insn_c_addiw_valid ? spec_insn_c_addiw_csr_misa_rmask :
		spec_insn_c_addw_valid ? spec_insn_c_addw_csr_misa_rmask :
		spec_insn_c_and_valid ? spec_insn_c_and_csr_misa_rmask :
		spec_insn_c_andi_valid ? spec_insn_c_andi_csr_misa_rmask :
		spec_insn_c_beqz_valid ? spec_insn_c_beqz_csr_misa_rmask :
		spec_insn_c_bnez_valid ? spec_insn_c_bnez_csr_misa_rmask :
		spec_insn_c_j_valid ? spec_insn_c_j_csr_misa_rmask :
		spec_insn_c_jalr_valid ? spec_insn_c_jalr_csr_misa_rmask :
		spec_insn_c_jr_valid ? spec_insn_c_jr_csr_misa_rmask :
		spec_insn_c_ld_valid ? spec_insn_c_ld_csr_misa_rmask :
		spec_insn_c_ldsp_valid ? spec_insn_c_ldsp_csr_misa_rmask :
		spec_insn_c_li_valid ? spec_insn_c_li_csr_misa_rmask :
		spec_insn_c_lui_valid ? spec_insn_c_lui_csr_misa_rmask :
		spec_insn_c_lw_valid ? spec_insn_c_lw_csr_misa_rmask :
		spec_insn_c_lwsp_valid ? spec_insn_c_lwsp_csr_misa_rmask :
		spec_insn_c_mv_valid ? spec_insn_c_mv_csr_misa_rmask :
		spec_insn_c_or_valid ? spec_insn_c_or_csr_misa_rmask :
		spec_insn_c_sd_valid ? spec_insn_c_sd_csr_misa_rmask :
		spec_insn_c_sdsp_valid ? spec_insn_c_sdsp_csr_misa_rmask :
		spec_insn_c_slli_valid ? spec_insn_c_slli_csr_misa_rmask :
		spec_insn_c_srai_valid ? spec_insn_c_srai_csr_misa_rmask :
		spec_insn_c_srli_valid ? spec_insn_c_srli_csr_misa_rmask :
		spec_insn_c_sub_valid ? spec_insn_c_sub_csr_misa_rmask :
		spec_insn_c_subw_valid ? spec_insn_c_subw_csr_misa_rmask :
		spec_insn_c_sw_valid ? spec_insn_c_sw_csr_misa_rmask :
		spec_insn_c_swsp_valid ? spec_insn_c_swsp_csr_misa_rmask :
		spec_insn_c_xor_valid ? spec_insn_c_xor_csr_misa_rmask :
		spec_insn_div_valid ? spec_insn_div_csr_misa_rmask :
		spec_insn_divu_valid ? spec_insn_divu_csr_misa_rmask :
		spec_insn_divuw_valid ? spec_insn_divuw_csr_misa_rmask :
		spec_insn_divw_valid ? spec_insn_divw_csr_misa_rmask :
		spec_insn_jal_valid ? spec_insn_jal_csr_misa_rmask :
		spec_insn_jalr_valid ? spec_insn_jalr_csr_misa_rmask :
		spec_insn_lb_valid ? spec_insn_lb_csr_misa_rmask :
		spec_insn_lbu_valid ? spec_insn_lbu_csr_misa_rmask :
		spec_insn_ld_valid ? spec_insn_ld_csr_misa_rmask :
		spec_insn_lh_valid ? spec_insn_lh_csr_misa_rmask :
		spec_insn_lhu_valid ? spec_insn_lhu_csr_misa_rmask :
		spec_insn_lui_valid ? spec_insn_lui_csr_misa_rmask :
		spec_insn_lw_valid ? spec_insn_lw_csr_misa_rmask :
		spec_insn_lwu_valid ? spec_insn_lwu_csr_misa_rmask :
		spec_insn_mul_valid ? spec_insn_mul_csr_misa_rmask :
		spec_insn_mulh_valid ? spec_insn_mulh_csr_misa_rmask :
		spec_insn_mulhsu_valid ? spec_insn_mulhsu_csr_misa_rmask :
		spec_insn_mulhu_valid ? spec_insn_mulhu_csr_misa_rmask :
		spec_insn_mulw_valid ? spec_insn_mulw_csr_misa_rmask :
		spec_insn_or_valid ? spec_insn_or_csr_misa_rmask :
		spec_insn_ori_valid ? spec_insn_ori_csr_misa_rmask :
		spec_insn_rem_valid ? spec_insn_rem_csr_misa_rmask :
		spec_insn_remu_valid ? spec_insn_remu_csr_misa_rmask :
		spec_insn_remuw_valid ? spec_insn_remuw_csr_misa_rmask :
		spec_insn_remw_valid ? spec_insn_remw_csr_misa_rmask :
		spec_insn_sb_valid ? spec_insn_sb_csr_misa_rmask :
		spec_insn_sd_valid ? spec_insn_sd_csr_misa_rmask :
		spec_insn_sh_valid ? spec_insn_sh_csr_misa_rmask :
		spec_insn_sll_valid ? spec_insn_sll_csr_misa_rmask :
		spec_insn_slli_valid ? spec_insn_slli_csr_misa_rmask :
		spec_insn_slliw_valid ? spec_insn_slliw_csr_misa_rmask :
		spec_insn_sllw_valid ? spec_insn_sllw_csr_misa_rmask :
		spec_insn_slt_valid ? spec_insn_slt_csr_misa_rmask :
		spec_insn_slti_valid ? spec_insn_slti_csr_misa_rmask :
		spec_insn_sltiu_valid ? spec_insn_sltiu_csr_misa_rmask :
		spec_insn_sltu_valid ? spec_insn_sltu_csr_misa_rmask :
		spec_insn_sra_valid ? spec_insn_sra_csr_misa_rmask :
		spec_insn_srai_valid ? spec_insn_srai_csr_misa_rmask :
		spec_insn_sraiw_valid ? spec_insn_sraiw_csr_misa_rmask :
		spec_insn_sraw_valid ? spec_insn_sraw_csr_misa_rmask :
		spec_insn_srl_valid ? spec_insn_srl_csr_misa_rmask :
		spec_insn_srli_valid ? spec_insn_srli_csr_misa_rmask :
		spec_insn_srliw_valid ? spec_insn_srliw_csr_misa_rmask :
		spec_insn_srlw_valid ? spec_insn_srlw_csr_misa_rmask :
		spec_insn_sub_valid ? spec_insn_sub_csr_misa_rmask :
		spec_insn_subw_valid ? spec_insn_subw_csr_misa_rmask :
		spec_insn_sw_valid ? spec_insn_sw_csr_misa_rmask :
		spec_insn_xor_valid ? spec_insn_xor_csr_misa_rmask :
		spec_insn_xori_valid ? spec_insn_xori_csr_misa_rmask : 0;
`endif
endmodule
