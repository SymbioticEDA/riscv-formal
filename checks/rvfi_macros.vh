
`define RFVI_WIRES                                                        \
wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid;      \
wire [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order;      \
wire [`RISCV_FORMAL_NRET *                 32   - 1 : 0] rvfi_insn;       \
wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr;        \
wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr;        \
wire [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr;         \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata;     \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata;    \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata;    \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_pc;    \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata;    \
wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap;  \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr;   \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask;  \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask;  \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata;  \
wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata;

`define RFVI_CONN                  \
.rvfi_valid     (rvfi_valid    ),  \
.rvfi_order     (rvfi_order    ),  \
.rvfi_insn      (rvfi_insn     ),  \
.rvfi_rs1_addr  (rvfi_rs1_addr ),  \
.rvfi_rs2_addr  (rvfi_rs2_addr ),  \
.rvfi_rd_addr   (rvfi_rd_addr  ),  \
.rvfi_pc_rdata    (rvfi_pc_rdata   ),  \
.rvfi_rs1_rdata (rvfi_rs1_rdata),  \
.rvfi_rs2_rdata (rvfi_rs2_rdata),  \
.rvfi_post_pc   (rvfi_post_pc  ),  \
.rvfi_rd_wdata   (rvfi_rd_wdata  ),  \
.rvfi_trap      (rvfi_trap     ),  \
.rvfi_mem_addr  (rvfi_mem_addr ),  \
.rvfi_mem_rmask (rvfi_mem_rmask),  \
.rvfi_mem_wmask (rvfi_mem_wmask),  \
.rvfi_mem_rdata (rvfi_mem_rdata),  \
.rvfi_mem_wdata (rvfi_mem_wdata)

