module rvfi_testbench (
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
		.trig   (cycle == `RISCV_FORMAL_TRIG_CYCLE),
`endif
`ifdef RISCV_FORMAL_CHECK_CYCLE
		.check  (cycle == `RISCV_FORMAL_CHECK_CYCLE),
`endif
		`RVFI_CONN
	);

	rvfi_wrapper wrapper (
		.clock (clock),
		.reset (reset),
		`RVFI_CONN
	);
endmodule
