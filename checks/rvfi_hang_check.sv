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
`ifdef RISCV_FORMAL_WAITINSN
				assume(!(`RISCV_FORMAL_WAITINSN(rvfi_insn[(channel_idx+1)*`RISCV_FORMAL_ILEN-1 : channel_idx*`RISCV_FORMAL_ILEN])));
`endif
			end
		end
	end
endmodule
