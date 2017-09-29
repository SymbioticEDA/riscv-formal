module rvfi_causal_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`rvformal_const_rand_reg [63:0] insn_order;
	`rvformal_const_rand_reg [4:0] register_index;
	reg found_non_causal = 0;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			found_non_causal = 0;
		end else begin
			if (check) begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_CHANNEL_IDX; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] > insn_order &&
							(register_index == rvfi_rs1_addr[channel_idx*5 +: 5] ||
							register_index == rvfi_rs2_addr[channel_idx*5 +: 5])) begin
						found_non_causal = 1;
					end
				end
				assume(register_index != 0);
				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume((register_index == rvfi_rd_addr[`RISCV_FORMAL_CHANNEL_IDX*5 +: 5]));
				assume(insn_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);
				assert(!found_non_causal);
			end else begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] > insn_order &&
							(register_index == rvfi_rs1_addr[channel_idx*5 +: 5] ||
							register_index == rvfi_rs2_addr[channel_idx*5 +: 5])) begin
						found_non_causal = 1;
					end
				end
			end
		end
	end
endmodule
