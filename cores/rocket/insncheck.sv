module testbench (
	input clk
);
	`RVFI_WIRES

	reg reset = 1;
	reg enable = 0;
	reg [7:0] cycle = 0;

	always @(posedge clk) begin
		cycle <= cycle + !(&cycle);
		enable <= cycle == `RISCV_FORMAL_BMC_DEPTH;
		reset <= cycle < 5;
	end

`ifdef NO_SYSTEM
	wire riscv_rv32i_valid_ch0;
	wire riscv_rv32i_valid_ch1;

	riscv_rv32i_insn riscv_rv32i_insn_ch0 (
		.insn(rvfi_insn[31:0]),
		.valid(riscv_rv32i_valid_ch0)
	);

	riscv_rv32i_insn riscv_rv32i_insn_ch1 (
		.insn(rvfi_insn[63:32]),
		.valid(riscv_rv32i_valid_ch1)
	);

	always @* begin
		if (rvfi_valid[0]) begin
			assume (!rvfi_trap[0]);
			assume (!rvfi_halt[0]);
			assume (!rvfi_intr[0]);
			assume (rvfi_insn[6:0] != 7'b1110011); // no SYSTEM instructions
			assume (riscv_rv32i_valid_ch0); // no illegal instructions
		end
		if (rvfi_valid[1]) begin
			assume (!rvfi_trap[1]);
			assume (!rvfi_halt[1]);
			assume (!rvfi_intr[1]);
			assume (rvfi_insn[38:32] != 7'b1110011); // no SYSTEM instructions
			assume (riscv_rv32i_valid_ch1); // no illegal instructions
		end
	end
`endif

	rvfi_insn_check checker_inst (
		.clk    (clk   ),
		.enable (enable),
		`RVFI_CONN
	);

	rocket_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);
endmodule
