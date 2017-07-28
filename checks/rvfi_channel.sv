module rvfi_channel (
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,
	input [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
	parameter CHANNEL_IDX = 0;

	(* keep *) wire                                valid     = rvfi_valid    [CHANNEL_IDX];
	(* keep *) wire [                       7 : 0] order     = rvfi_order    [CHANNEL_IDX*8                    +:  8];
	(* keep *) wire [`RISCV_FORMAL_ILEN   - 1 : 0] insn      = rvfi_insn     [CHANNEL_IDX*`RISCV_FORMAL_ILEN   +: `RISCV_FORMAL_ILEN];
	(* keep *) wire                                trap      = rvfi_trap     [CHANNEL_IDX];
	(* keep *) wire                                halt      = rvfi_halt     [CHANNEL_IDX];
	(* keep *) wire                                intr      = rvfi_intr     [CHANNEL_IDX];
	(* keep *) wire [                       4 : 0] rs1_addr  = rvfi_rs1_addr [CHANNEL_IDX*5                    +:  5];
	(* keep *) wire [                       4 : 0] rs2_addr  = rvfi_rs2_addr [CHANNEL_IDX*5                    +:  5];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rs1_rdata = rvfi_rs1_rdata[CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rs2_rdata = rvfi_rs2_rdata[CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [                       4 : 0] rd_addr   = rvfi_rd_addr  [CHANNEL_IDX*5                    +:  5];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rd_wdata  = rvfi_rd_wdata [CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pc_rdata  = rvfi_pc_rdata [CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pc_wdata  = rvfi_pc_wdata [CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];

	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_addr  = rvfi_mem_addr [CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_rmask = rvfi_mem_rmask[CHANNEL_IDX*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
	(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_wmask = rvfi_mem_wmask[CHANNEL_IDX*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_rdata = rvfi_mem_rdata[CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
	(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_wdata = rvfi_mem_wdata[CHANNEL_IDX*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
endmodule
