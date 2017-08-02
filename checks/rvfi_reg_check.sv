module rvfi_reg_check #(
	parameter [0:0] ZERO_INIT = 0
) (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`formal_anyconst [4:0] register_index;
	reg [`RISCV_FORMAL_XLEN-1:0] register_shadow = 0;
	reg register_written = ZERO_INIT;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			register_shadow <= 0;
			register_written <= ZERO_INIT;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx]) begin
					if (check && register_written) begin
						if (register_index == rvfi_rs1_addr[channel_idx*5 +: 5])
							assert(register_shadow == rvfi_rs1_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
						if (register_index == rvfi_rs2_addr[channel_idx*5 +: 5])
							assert(register_shadow == rvfi_rs2_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
					end
					if (register_index == rvfi_rd_addr[channel_idx*5 +: 5]) begin
						register_shadow = rvfi_rd_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						register_written = 1;
					end
				end
			end
		end
	end
endmodule
