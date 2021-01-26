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

module rvfi_pc_bwd_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`rvformal_rand_const_reg [63:0] insn_order;
	reg [`RISCV_FORMAL_XLEN-1:0] expect_pc;
	reg expect_pc_valid = 0;

	wire [`RISCV_FORMAL_XLEN-1:0] pc_wdata = rvfi_pc_wdata[`RISCV_FORMAL_CHANNEL_IDX*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];

	integer channel_idx;
	always @(posedge clock) begin
		if (reset) begin
			expect_pc_valid = 0;
		end else begin
			if (check) begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_CHANNEL_IDX; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == insn_order+1) begin
						expect_pc = rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						expect_pc_valid = 1;
					end
				end

				assume(rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
				assume(insn_order == rvfi_order[64*`RISCV_FORMAL_CHANNEL_IDX +: 64]);
				if (expect_pc_valid) begin
					assert(`rvformal_addr_eq(expect_pc, pc_wdata));
				end
			end else begin
				for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
					if (rvfi_valid[channel_idx] && rvfi_order[64*channel_idx +: 64] == insn_order+1) begin
						expect_pc = rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
						expect_pc_valid = 1;
					end
				end
			end
		end
	end
endmodule
