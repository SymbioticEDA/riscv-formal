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

module rvfi_cover_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
`ifdef RISCV_FORMAL_ROLLBACK
	(* keep *) integer cnt_rollback;
	integer cnt_rollback_q;

	always @(posedge clock) begin
		cnt_rollback_q <= cnt_rollback;
	end

	always @* begin
		if (reset)
			cnt_rollback = 0;
		else
			cnt_rollback = cnt_rollback_q + rvfi_rollback_valid;
	end
`endif

	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin:channel
		`RVFI_GETCHANNEL(channel_idx)

		(* keep *) integer cnt_insns;
		(* keep *) integer cnt_trap_insns;
		(* keep *) integer cnt_intr_insns;
		(* keep *) integer cnt_norm_insns;

`ifdef RISCV_FORMAL_ROLLBACK
		// "arb" = after rollback
		(* keep *) integer arb_cnt_insns;
		(* keep *) integer arb_cnt_trap_insns;
		(* keep *) integer arb_cnt_intr_insns;
		(* keep *) integer arb_cnt_norm_insns;
`endif

		integer cnt_insns_q;
		integer cnt_trap_insns_q;
		integer cnt_intr_insns_q;
		integer cnt_norm_insns_q;

`ifdef RISCV_FORMAL_ROLLBACK
		integer arb_cnt_insns_q;
		integer arb_cnt_trap_insns_q;
		integer arb_cnt_intr_insns_q;
		integer arb_cnt_norm_insns_q;
`endif

		always @(posedge clock) begin
			cnt_insns_q <= cnt_insns;
			cnt_trap_insns_q <= cnt_trap_insns;
			cnt_intr_insns_q <= cnt_intr_insns;
			cnt_norm_insns_q <= cnt_norm_insns;

`ifdef RISCV_FORMAL_ROLLBACK
			arb_cnt_insns_q <= arb_cnt_insns;
			arb_cnt_trap_insns_q <= arb_cnt_trap_insns;
			arb_cnt_intr_insns_q <= arb_cnt_intr_insns;
			arb_cnt_norm_insns_q <= arb_cnt_norm_insns;
`endif
		end

		always @* begin
			if (reset) begin
				cnt_insns = 0;
				cnt_trap_insns = 0;
				cnt_intr_insns = 0;
				cnt_norm_insns = 0;

`ifdef RISCV_FORMAL_ROLLBACK
				arb_cnt_insns = 0;
				arb_cnt_trap_insns = 0;
				arb_cnt_intr_insns = 0;
				arb_cnt_norm_insns = 0;
`endif
			end else begin
				cnt_insns = cnt_insns_q + valid;
				cnt_trap_insns = cnt_trap_insns_q + (valid && trap);
				cnt_intr_insns = cnt_intr_insns_q + (valid && intr);
				cnt_norm_insns = cnt_norm_insns_q + (valid && !{trap,intr});

`ifdef RISCV_FORMAL_ROLLBACK
				arb_cnt_insns = arb_cnt_insns_q + (valid && cnt_rollback);
				arb_cnt_trap_insns = arb_cnt_trap_insns_q + (valid && cnt_rollback && trap);
				arb_cnt_intr_insns = arb_cnt_intr_insns_q + (valid && cnt_rollback && intr);
				arb_cnt_norm_insns = arb_cnt_norm_insns_q + (valid && cnt_rollback && !{trap,intr});
`endif
			end
		end
	end endgenerate

`include "cover_stmts.vh"
endmodule
