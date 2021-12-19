// Copyright (C) 2017  Clifford Wolf <clifford@symbioticeda.com>
//
// Permission to use, copy, modify, and/or distribute this software for any
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
// WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
// ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
// WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
// ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
// OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

module rvfi_reg_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`rvformal_rand_const_reg [63:0] insn_order;
	`rvformal_rand_const_reg [4:0] register_index;
	reg [`RISCV_FORMAL_XLEN-1:0] register_shadow = 0;
	reg register_written = 0;

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			register_shadow = 0;
			register_written = 0;
		end else begin
			if (check) begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_CHANNEL_IDX; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] < insn_order && register_index == rvfi_rd_addr[channel_idx*5 +: 5]) begin
						register_shadow = rvfi_rd_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						register_written = 1;
					end
				end

				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(insn_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);

				if (register_written && register_index == rvfi_rs1_addr[`RISCV_FORMAL_CHANNEL_IDX*5 +: 5])
					assert(register_shadow == rvfi_rs1_rdata[`RISCV_FORMAL_CHANNEL_IDX*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
				if (register_written && register_index == rvfi_rs2_addr[`RISCV_FORMAL_CHANNEL_IDX*5 +: 5])
					assert(register_shadow == rvfi_rs2_rdata[`RISCV_FORMAL_CHANNEL_IDX*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
			end else begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] < insn_order && register_index == rvfi_rd_addr[channel_idx*5 +: 5]) begin
						register_shadow = rvfi_rd_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						register_written = 1;
					end
				end
			end
		end
	end
endmodule
