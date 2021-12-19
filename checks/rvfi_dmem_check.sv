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

module rvfi_dmem_check (
	input clock, reset, enable,
	output [`RISCV_FORMAL_XLEN-1:0] dmem_addr,
	`RVFI_INPUTS
);
	`rvformal_rand_const_reg [`RISCV_FORMAL_XLEN-1:0] dmem_addr_randval;
	assign dmem_addr = dmem_addr_randval;

	reg [`RISCV_FORMAL_XLEN-1:0] dmem_shadow;
	reg [`RISCV_FORMAL_XLEN/8-1:0] dmem_written = 0;

	integer channel_idx;
	integer i;

	always @(posedge clock) begin
		if (reset) begin
			dmem_written <= 0;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx] && rvfi_mem_addr[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN] == dmem_addr && `rvformal_addr_valid(dmem_addr)) begin
					for (i = 0; i < `RISCV_FORMAL_XLEN/8; i = i+1) begin
						if (enable && rvfi_mem_rmask[channel_idx*`RISCV_FORMAL_XLEN/8 + i] && dmem_written[i])
							assert(dmem_shadow[i*8 +: 8] == rvfi_mem_rdata[i*8 +: 8]);
						if (rvfi_mem_wmask[channel_idx*`RISCV_FORMAL_XLEN/8 + i]) begin
							dmem_shadow[i*8 +: 8] = rvfi_mem_wdata[i*8 +: 8];
							dmem_written[i] = 1;
						end
					end
				end
			end
		end
	end
endmodule
