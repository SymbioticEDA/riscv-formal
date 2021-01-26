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

module rvfi_imem_check (
	input clock, reset, enable,
	output [`RISCV_FORMAL_XLEN-1:0] imem_addr,
	output [15:0] imem_data,
	`RVFI_INPUTS
);
	`rvformal_rand_const_reg [`RISCV_FORMAL_XLEN-1:0] imem_addr_randval;
	`rvformal_rand_const_reg [15:0] imem_data_randval;
	assign imem_addr = imem_addr_randval;
	assign imem_data = imem_data_randval;

	reg [`RISCV_FORMAL_XLEN-1:0] pc;
	reg [`RISCV_FORMAL_ILEN-1:0] insn;

	integer channel_idx;
	integer i;

	always @(posedge clock) begin
		if (reset) begin
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (enable && rvfi_valid[channel_idx]) begin
					pc = rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
					insn = rvfi_insn[channel_idx*`RISCV_FORMAL_ILEN +: `RISCV_FORMAL_ILEN];

					if (`rvformal_addr_valid(pc) && pc == imem_addr)
						assert(insn[15:0] == imem_data);

					if (insn[1:0] == 2'b11 && `rvformal_addr_valid(pc+2) && pc+2 == imem_addr)
						assert(insn[31:16] == imem_data);
				end
			end
		end
	end
endmodule
