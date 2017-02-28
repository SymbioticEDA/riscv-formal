
`define RFVI_WIRES                                                                   \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid;      \
(* keep *) wire [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order;      \
(* keep *) wire [`RISCV_FORMAL_NRET *                 32   - 1 : 0] rvfi_insn;       \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap;       \
(* keep *) wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr;   \
(* keep *) wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr;   \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata;  \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata;  \
(* keep *) wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr;    \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata;   \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata;   \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata;   \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr;   \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask;  \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask;  \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata;  \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata;

`define RFVI_CONN                  \
.rvfi_valid     (rvfi_valid    ),  \
.rvfi_order     (rvfi_order    ),  \
.rvfi_insn      (rvfi_insn     ),  \
.rvfi_trap      (rvfi_trap     ),  \
.rvfi_rs1_addr  (rvfi_rs1_addr ),  \
.rvfi_rs2_addr  (rvfi_rs2_addr ),  \
.rvfi_rs1_rdata (rvfi_rs1_rdata),  \
.rvfi_rs2_rdata (rvfi_rs2_rdata),  \
.rvfi_rd_addr   (rvfi_rd_addr  ),  \
.rvfi_rd_wdata  (rvfi_rd_wdata ),  \
.rvfi_pc_rdata  (rvfi_pc_rdata ),  \
.rvfi_pc_wdata  (rvfi_pc_wdata ),  \
.rvfi_mem_addr  (rvfi_mem_addr ),  \
.rvfi_mem_rmask (rvfi_mem_rmask),  \
.rvfi_mem_wmask (rvfi_mem_wmask),  \
.rvfi_mem_rdata (rvfi_mem_rdata),  \
.rvfi_mem_wdata (rvfi_mem_wdata)

