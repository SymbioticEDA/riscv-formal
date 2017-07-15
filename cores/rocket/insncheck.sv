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
	wire riscv_rv32i_valid;

	riscv_rv32i_insn riscv_rv32i_insn_inst (
		.insn(rvfi_insn),
		.valid(riscv_rv32i_valid)
	);

	always @* begin
		if (rvfi_valid) begin
			assume (!rvfi_trap);
			assume (!rvfi_halt);
			assume (!rvfi_intr);
			assume (rvfi_insn[6:0] != 7'b1110011); // no SYSTEM instructions
			assume (rvfi_insn[6:0] != 7'b0000011); // no LOAD instructions
			assume (rvfi_insn[6:0] != 7'b0100011); // no STORE instructions
			assume (riscv_rv32i_valid); // no illegal instructions
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
