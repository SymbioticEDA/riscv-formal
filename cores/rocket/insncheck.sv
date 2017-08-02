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
	wire enable = cycle == `RISCV_FORMAL_BMC_DEPTH;

	rvfi_insn_check checker_inst (
		.clock  (clk   ),
		.reset  (reset ),
		.enable (enable),
		`RVFI_CONN
	);

	rocket_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);
endmodule
