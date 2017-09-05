module rvfi_liveness_check (
	input clock, reset, trig, check,
	`RVFI_INPUTS
);
	`rvformal_const_rand_reg [63:0] insn_order;
	reg found_next_insn = 0;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			found_next_insn = 0;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == insn_order+1) begin
					found_next_insn = 1;
				end
			end
			if (trig) begin
				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(!rvfi_halt[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(insn_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);
			end
			if (check) begin
				assert(found_next_insn);
			end
		end
	end
endmodule
