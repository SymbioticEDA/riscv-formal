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

module rvfi_causal_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`rvformal_rand_const_reg [63:0] insn_order;
	`rvformal_rand_const_reg [4:0] register_index;
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
