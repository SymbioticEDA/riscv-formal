module rvfi_pc_check (
	input clock, reset, enable,
	`RVFI_INPUTS
);
	reg [`RISCV_FORMAL_XLEN-1:0] pc_shadow = 0;
	reg pc_written = 0;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			pc_written = 0;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx]) begin
					if (enable && pc_written)
						assert(pc_shadow == rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
					pc_shadow = rvfi_pc_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
					pc_written = 1;
				end
			end
		end
	end
endmodule
