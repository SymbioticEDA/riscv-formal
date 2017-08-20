module testbench (
	input clk, rst
);
	`RVFI_WIRES

`ifdef YOSYS
	assume property (rst == $initstate);
`endif

	reg [7:0] cycle_reg = 0;
	wire [7:0] cycle = rst ? 0 : cycle_reg;

	always @(posedge clk) begin
		cycle_reg <= rst ? 1 : cycle_reg + (cycle_reg != 255);
	end

	wire reset = cycle <= 5;

	rvfi_reg_check checker_inst (
		.clock  (clk   ),
		.reset  (cycle < `RISCV_FORMAL_BMC_START),
		.check  (cycle == `RISCV_FORMAL_BMC_DEPTH),
		`RVFI_CONN
	);

	rvfi_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);
endmodule
