module testbench (
	input clk
);
	`RFVI_WIRES

	reg reset = 1;
	reg enable = 0;
	reg [7:0] cycle = 0;

	always @(posedge clk) begin
		cycle <= cycle + !(&cycle);
		enable <= cycle == `RISCV_FORMAL_BMC_DEPTH;
		reset <= cycle < 5;
	end

	rvfi_insn_check checker_inst (
		.clk    (clk   ),
		.enable (enable),
		`RFVI_CONN
	);

	rocket_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RFVI_CONN
	);
endmodule
