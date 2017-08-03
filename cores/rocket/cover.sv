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

	rocket_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);

`define RVFI_CHANNEL_POSTFIX _ch0
`RVFI_CHANNEL(0)

`define RVFI_CHANNEL_POSTFIX _ch1
`RVFI_CHANNEL(1)

	always @(posedge clk) begin
		if (!reset) begin
			cover(rvfi_valid_ch0);
			cover(rvfi_valid_ch1);

			// SW
			cover(rvfi_valid_ch0 && rvfi_insn_ch0[14:12] == 'b 010 && rvfi_insn_ch0[6:0] == 'b 0100011);
			cover(rvfi_valid_ch1 && rvfi_insn_ch0[14:12] == 'b 010 && rvfi_insn_ch0[6:0] == 'b 0100011);

			// LW
			cover(rvfi_valid_ch0 && rvfi_insn_ch0[14:12] == 'b 010 && rvfi_insn_ch0[6:0] == 'b 0000011);
			cover(rvfi_valid_ch1 && rvfi_insn_ch0[14:12] == 'b 010 && rvfi_insn_ch0[6:0] == 'b 0000011);

			// Just some long traces
			cover(cycle == 30);
			cover(cycle == 40);
			cover(cycle == 50);
		end
	end
endmodule
