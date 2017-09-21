module rvfi_hang_check (
	input clock, reset, trig, check,
	`RVFI_INPUTS
);
	reg okay = 0;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			okay <= 0;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx])
					okay <= 1;
			end
			if (check) begin
				assert(okay);
			end
		end
	end
endmodule
