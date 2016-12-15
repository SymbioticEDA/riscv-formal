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
	input [NRET * XLEN - 1 : 0] rvfi_post_rd,
	input [NRET        - 1 : 0] rvfi_post_trap
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
		wire [XLEN-1:0] post_trap = rvfi_post_trap[channel_idx*XLEN];

		reg ref_valid;
		reg [4:0] ref_rs1;
		reg [4:0] ref_rs2;
		reg [4:0] ref_rd;
		reg [XLEN-1:0] ref_post_rd;
		reg [XLEN-1:0] ref_post_pc;
		reg ref_post_trap;

		reg [XLEN-1:0] insn_imm;
		reg [4:0] insn_rs1;
		reg [4:0] insn_rs2;
		reg [4:0] insn_rd;
		reg [6:0] insn_opcode;
		reg [4:0] insn_funct3;
		reg [6:0] insn_funct7;
		reg [4:0] insn_shamt;

		reg [XLEN-1:0] result;
		reg cond;

		always @* begin
			ref_valid = 0;
			ref_rs1 = 0;
			ref_rs2 = 0;
			ref_rd = 0;
			ref_post_pc = 0;
			ref_post_rd = 0;
			ref_post_trap = 0;

			insn_imm = 'bx;
			insn_rs1 = 'bx;
			insn_rs2 = 'bx;
			insn_rd = 'bx;
			insn_opcode = 'bx;
			insn_funct3 = 'bx;
			insn_funct7 = 'bx;
			insn_shamt = 'bx;

			result = 'bx;
			cond = 'bx;

			`include `INSN_VH

			if (ref_valid) begin
				if (ref_rs1)
					assert(ref_rs1 == rs1);

				if (ref_rs2)
					assert(ref_rs2 == rs2);

				if (!ref_post_trap) begin
					assert(ref_rd == rd);
					assert(ref_post_rd == post_rd);
					assert(ref_post_pc == post_pc);
				end

				assert(ref_post_trap == post_trap);
			end
		end
`ifndef CHANNEL_IDX
	end endgenerate
`endif
endmodule
