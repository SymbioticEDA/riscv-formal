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

	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin:channel
		(* keep *) wire valid = !reset && rvfi_valid[channel_idx];
		(* keep *) wire [`RISCV_FORMAL_ILEN   - 1 : 0] insn      = rvfi_insn     [channel_idx*`RISCV_FORMAL_ILEN   +: `RISCV_FORMAL_ILEN];
		(* keep *) wire [                64   - 1 : 0] order     = rvfi_order    [channel_idx*                64   +:                 64];
		(* keep *) wire                                trap      = rvfi_trap     [channel_idx];
		(* keep *) wire                                intr      = rvfi_intr     [channel_idx];

		(* keep *) integer cnt_insns;
		(* keep *) integer cnt_trap_insns;
		(* keep *) integer cnt_intr_insns;
		(* keep *) integer cnt_norm_insns;

		// "arb" = after rollback
		(* keep *) integer arb_cnt_insns;
		(* keep *) integer arb_cnt_trap_insns;
		(* keep *) integer arb_cnt_intr_insns;
		(* keep *) integer arb_cnt_norm_insns;

		integer cnt_insns_q;
		integer cnt_trap_insns_q;
		integer cnt_intr_insns_q;
		integer cnt_norm_insns_q;

		integer arb_cnt_insns_q;
		integer arb_cnt_trap_insns_q;
		integer arb_cnt_intr_insns_q;
		integer arb_cnt_norm_insns_q;

		always @(posedge clock) begin
			cnt_insns_q <= cnt_insns;
			cnt_trap_insns_q <= cnt_trap_insns;
			cnt_intr_insns_q <= cnt_intr_insns;
			cnt_norm_insns_q <= cnt_norm_insns;

			arb_cnt_insns_q <= arb_cnt_insns;
			arb_cnt_trap_insns_q <= arb_cnt_trap_insns;
			arb_cnt_intr_insns_q <= arb_cnt_intr_insns;
			arb_cnt_norm_insns_q <= arb_cnt_norm_insns;
		end

		always @* begin
			if (reset) begin
				cnt_insns = 0;
				cnt_trap_insns = 0;
				cnt_intr_insns = 0;
				cnt_norm_insns = 0;

				arb_cnt_insns = 0;
				arb_cnt_trap_insns = 0;
				arb_cnt_intr_insns = 0;
				arb_cnt_norm_insns = 0;
			end else begin
				cnt_insns = cnt_insns_q + valid;
				cnt_trap_insns = cnt_trap_insns_q + (valid && trap);
				cnt_intr_insns = cnt_intr_insns_q + (valid && intr);
				cnt_norm_insns = cnt_norm_insns_q + (valid && !{trap,intr});

				arb_cnt_insns = arb_cnt_insns_q + (valid && cnt_rollback);
				arb_cnt_trap_insns = arb_cnt_trap_insns_q + (valid && cnt_rollback && trap);
				arb_cnt_intr_insns = arb_cnt_intr_insns_q + (valid && cnt_rollback && intr);
				arb_cnt_norm_insns = arb_cnt_norm_insns_q + (valid && cnt_rollback && !{trap,intr});
			end
		end
	end endgenerate

`include "cover_stmts.vh"
endmodule
