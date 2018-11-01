module testbench (
	input clock,
	input reset,
	`RVFI_OUTPUTS
);
	rvfi_wrapper wrapper (
		.clock(clock),
		.reset(reset),
		`RVFI_CONN
	);

	integer cycle = 0;
	always @(posedge clock) cycle <= cycle + 1;

	always @(posedge clock) begin
		assume (reset == (cycle == 0));
		cover (rvfi_valid);
	end
endmodule
