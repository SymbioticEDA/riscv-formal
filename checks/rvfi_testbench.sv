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

module rvfi_testbench (
	`ifdef RISCV_FORMAL_UNBOUNDED
	`ifdef RISCV_FORMAL_TRIG_CYCLE
		input trig,
	`endif
	`ifdef RISCV_FORMAL_CHECK_CYCLE
		input check,
	`endif
	`endif
	input clock, reset
);
	`RVFI_WIRES

`ifdef YOSYS
	assume property (reset == $initstate);
`endif

	reg [7:0] cycle_reg = 0;
	wire [7:0] cycle = reset ? 0 : cycle_reg;

	always @(posedge clock) begin
		cycle_reg <= reset ? 1 : cycle_reg + (cycle_reg != 255);
	end

	`RISCV_FORMAL_CHECKER checker_inst (
		.clock  (clock),
		.reset  (cycle < `RISCV_FORMAL_RESET_CYCLES),
`ifdef RISCV_FORMAL_TRIG_CYCLE
`ifdef RISCV_FORMAL_UNBOUNDED
		.trig   (trig),
`else
		.trig   (cycle == `RISCV_FORMAL_TRIG_CYCLE),
`endif
`endif
`ifdef RISCV_FORMAL_CHECK_CYCLE
`ifdef RISCV_FORMAL_UNBOUNDED
		.check   (check),
`else
		.check  (cycle == `RISCV_FORMAL_CHECK_CYCLE),
`endif
`endif
		`RVFI_CONN
	);

	rvfi_wrapper wrapper (
		.clock (clock),
		.reset (reset),
		`RVFI_CONN
	);
endmodule
