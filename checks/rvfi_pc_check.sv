module rvfi_pc_check (
	input clock, reset, trig, check,
	`RVFI_INPUTS
);
	`rvformal_const_rand_reg [63:0] trig_order;
	wire [63:0] next_order = trig_order + 1;

	reg got_next_pc = 0;
	reg [`RISCV_FORMAL_XLEN-1:0] expect_next_pc;
	reg [`RISCV_FORMAL_XLEN-1:0] next_pc;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			got_next_pc = 0;
		end else begin
			if (trig) begin
				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(trig_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);
				expect_next_pc <= rvfi_pc_wdata[`RISCV_FORMAL_CHANNEL_IDX*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
			end
			if (check && got_next_pc) begin
				assert(expect_next_pc == next_pc);
			end
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == trig_order+1) begin
					got_next_pc <= 1;
					next_pc <= rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
				end
			end
		end
	end
endmodule
