module rvfi_pc_fwd_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`rvformal_const_rand_reg [63:0] insn_order;
	reg [`RISCV_FORMAL_XLEN-1:0] expect_pc;
	reg expect_pc_valid = 0;

	wire [`RISCV_FORMAL_XLEN-1:0] pc_rdata = rvfi_pc_rdata[`RISCV_FORMAL_CHANNEL_IDX*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			expect_pc_valid = 0;
		end else begin
			if (check) begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_CHANNEL_IDX; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == insn_order-1) begin
						expect_pc = rvfi_pc_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						expect_pc_valid = 1;
					end
				end

				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(insn_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);
				if (expect_pc_valid) begin
					assert(`rvformal_addr_eq(expect_pc, pc_rdata));
				end
			end else begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == insn_order-1) begin
						expect_pc = rvfi_pc_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						expect_pc_valid = 1;
					end
				end
			end
		end
	end
endmodule
