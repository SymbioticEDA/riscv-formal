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
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (rvfi_valid[channel_idx]) begin
				assume(!rvfi_halt[channel_idx]);
				assume(rvfi_insn[(channel_idx+1)*`RISCV_FORMAL_ILEN-1 : channel_idx*`RISCV_FORMAL_ILEN] != 32'b 0001000_00101_00000_000_00000_1110011); // WFI
			end
		end
	end
endmodule
