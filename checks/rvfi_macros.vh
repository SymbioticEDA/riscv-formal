`ifdef YOSYS
`define rvformal_rand_reg rand reg
`define rvformal_const_rand_reg const rand reg
`else
`ifdef SIMULATION
`define rvformal_rand_reg reg
`define rvformal_const_rand_reg reg
`else
`define rvformal_rand_reg wire
`define rvformal_const_rand_reg reg
`endif
`endif

`ifndef RISCV_FORMAL_VALIDADDR
`define RISCV_FORMAL_VALIDADDR(addr) 1
`endif

`define rvformal_addr_eq(a, b) \
((`RISCV_FORMAL_VALIDADDR(a) == `RISCV_FORMAL_VALIDADDR(b)) && (!`RISCV_FORMAL_VALIDADDR(a) || (a == b)))

`define RVFI_WIRES                                                                   \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid;      \
(* keep *) wire [`RISCV_FORMAL_NRET *                 64   - 1 : 0] rvfi_order;      \
(* keep *) wire [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn;       \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap;       \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt;       \
(* keep *) wire [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr;       \
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

`define RVFI_OUTPUTS                                                        \
output [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,      \
output [`RISCV_FORMAL_NRET *                 64   - 1 : 0] rvfi_order,      \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,       \
output [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,       \
output [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt,       \
output [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr,       \
output [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,   \
output [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,   \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,  \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,  \
output [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,    \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,   \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,   \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata,   \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,   \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,  \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,  \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,  \
output [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata

`define RVFI_INPUTS                                                        \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,      \
input [`RISCV_FORMAL_NRET *                 64   - 1 : 0] rvfi_order,      \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt,       \
input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr,       \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,   \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,  \
input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,    \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,   \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,  \
input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata

`define RVFI_CHANNEL(_n) \
wire [                 1   - 1 : 0]     rvfi_valid`RVFI_CHANNEL_POSTFIX = rvfi_valid      [(_n)*(                 1  )  +:                  1  ]; \
wire [                64   - 1 : 0]     rvfi_order`RVFI_CHANNEL_POSTFIX = rvfi_order      [(_n)*(                64  )  +:                 64  ]; \
wire [`RISCV_FORMAL_ILEN   - 1 : 0]      rvfi_insn`RVFI_CHANNEL_POSTFIX = rvfi_insn       [(_n)*(`RISCV_FORMAL_ILEN  )  +: `RISCV_FORMAL_ILEN  ]; \
wire [                 1   - 1 : 0]      rvfi_trap`RVFI_CHANNEL_POSTFIX = rvfi_trap       [(_n)*(                 1  )  +:                  1  ]; \
wire [                 1   - 1 : 0]      rvfi_halt`RVFI_CHANNEL_POSTFIX = rvfi_halt       [(_n)*(                 1  )  +:                  1  ]; \
wire [                 1   - 1 : 0]      rvfi_intr`RVFI_CHANNEL_POSTFIX = rvfi_intr       [(_n)*(                 1  )  +:                  1  ]; \
wire [                 5   - 1 : 0]  rvfi_rs1_addr`RVFI_CHANNEL_POSTFIX = rvfi_rs1_addr   [(_n)*(                 5  )  +:                  5  ]; \
wire [                 5   - 1 : 0]  rvfi_rs2_addr`RVFI_CHANNEL_POSTFIX = rvfi_rs2_addr   [(_n)*(                 5  )  +:                  5  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata`RVFI_CHANNEL_POSTFIX = rvfi_rs1_rdata  [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata`RVFI_CHANNEL_POSTFIX = rvfi_rs2_rdata  [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [                 5   - 1 : 0]   rvfi_rd_addr`RVFI_CHANNEL_POSTFIX = rvfi_rd_addr    [(_n)*(                 5  )  +:                  5  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0]  rvfi_rd_wdata`RVFI_CHANNEL_POSTFIX = rvfi_rd_wdata   [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0]  rvfi_pc_rdata`RVFI_CHANNEL_POSTFIX = rvfi_pc_rdata   [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0]  rvfi_pc_wdata`RVFI_CHANNEL_POSTFIX = rvfi_pc_wdata   [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0]  rvfi_mem_addr`RVFI_CHANNEL_POSTFIX = rvfi_mem_addr   [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask`RVFI_CHANNEL_POSTFIX = rvfi_mem_rmask  [(_n)*(`RISCV_FORMAL_XLEN/8)  +: `RISCV_FORMAL_XLEN/8]; \
wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask`RVFI_CHANNEL_POSTFIX = rvfi_mem_wmask  [(_n)*(`RISCV_FORMAL_XLEN/8)  +: `RISCV_FORMAL_XLEN/8]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata`RVFI_CHANNEL_POSTFIX = rvfi_mem_rdata  [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ]; \
wire [`RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata`RVFI_CHANNEL_POSTFIX = rvfi_mem_wdata  [(_n)*(`RISCV_FORMAL_XLEN  )  +: `RISCV_FORMAL_XLEN  ];

`define RVFI_CONN                  \
.rvfi_valid     (rvfi_valid    ),  \
.rvfi_order     (rvfi_order    ),  \
.rvfi_insn      (rvfi_insn     ),  \
.rvfi_trap      (rvfi_trap     ),  \
.rvfi_halt      (rvfi_halt     ),  \
.rvfi_intr      (rvfi_intr     ),  \
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

