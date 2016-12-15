
`define RFVI_WIRES           \
wire        rvfi_valid;      \
wire [4:0]  rvfi_rs1;        \
wire [4:0]  rvfi_rs2;        \
wire [4:0]  rvfi_rd;         \
wire [31:0] rvfi_insn;       \
wire [31:0] rvfi_pre_pc;     \
wire [31:0] rvfi_pre_rs1;    \
wire [31:0] rvfi_pre_rs2;    \
wire [31:0] rvfi_post_pc;    \
wire [31:0] rvfi_post_rd;    \
wire        rvfi_post_trap;

`define RFVI_CONN                  \
.rvfi_valid     (rvfi_valid    ),  \
.rvfi_rs1       (rvfi_rs1      ),  \
.rvfi_rs2       (rvfi_rs2      ),  \
.rvfi_rd        (rvfi_rd       ),  \
.rvfi_insn      (rvfi_insn     ),  \
.rvfi_pre_pc    (rvfi_pre_pc   ),  \
.rvfi_pre_rs1   (rvfi_pre_rs1  ),  \
.rvfi_pre_rs2   (rvfi_pre_rs2  ),  \
.rvfi_post_pc   (rvfi_post_pc  ),  \
.rvfi_post_rd   (rvfi_post_rd  ),  \
.rvfi_post_trap (rvfi_post_trap)

