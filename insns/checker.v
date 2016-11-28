module riscv_formal_insn_checker #(
	parameter integer XLEN = 32,
	parameter integer NRET = 1
) (
	input clk,
	input [NRET        - 1 : 0] rvfi_valid,
	input [NRET *    5 - 1 : 0] rvfi_rs1,
	input [NRET *    5 - 1 : 0] rvfi_rs2,
	input [NRET *    5 - 1 : 0] rvfi_rd,
	input [NRET *   32 - 1 : 0] rvfi_insn,
	input [NRET * XLEN - 1 : 0] rvfi_pre_pc,
	input [NRET * XLEN - 1 : 0] rvfi_pre_rs1,
	input [NRET * XLEN - 1 : 0] rvfi_pre_rs2,
	input [NRET * XLEN - 1 : 0] rvfi_post_pc,
	input [NRET * XLEN - 1 : 0] rvfi_post_rd
);
`ifdef CHANNEL_IDX
	localparam integer channel_idx = `CHANNEL_IDX;
`else
	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < NRET; channel_idx=channel_idx+1) begin:channel
`endif
		wire valid = rvfi_valid[channel_idx];
		wire [4:0] rs1 = rvfi_rs1[channel_idx*5 +: 5];
		wire [4:0] rs2 = rvfi_rs2[channel_idx*5 +: 5];
		wire [4:0] rd = rvfi_rd[channel_idx*5 +: 5];
		wire [31:0] insn = rvfi_insn[channel_idx*32 +: 32];
		wire [XLEN-1:0] pre_pc = rvfi_pre_pc[channel_idx*XLEN +: XLEN];
		wire [XLEN-1:0] pre_rs1 = rvfi_pre_rs1[channel_idx*XLEN +: XLEN];
		wire [XLEN-1:0] pre_rs2 = rvfi_pre_rs2[channel_idx*XLEN +: XLEN];
		wire [XLEN-1:0] post_pc = rvfi_post_pc[channel_idx*XLEN +: XLEN];
		wire [XLEN-1:0] post_rd = rvfi_post_rd[channel_idx*XLEN +: XLEN];
		`include `INSN_VH
`ifndef CHANNEL_IDX
	end endgenerate
`endif
endmodule
