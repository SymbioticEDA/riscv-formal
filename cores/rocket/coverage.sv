module testbench (
	input clk, reset
);
	`RVFI_WIRES

`ifdef YOSYS
	assume property (reset == $initstate);
`endif

	rvfi_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);

`define RVFI_CHANNEL_POSTFIX _ch0
`RVFI_CHANNEL(0)

`define RVFI_CHANNEL_POSTFIX _ch1
`RVFI_CHANNEL(1)

	wire valid_ch0;
	wire valid_ch1;

	riscv_rv64ic_insn riscv_rv64ic_insn_ch0 (
		.insn(rvfi_insn_ch0),
		.valid(valid_ch0)
	);

	riscv_rv64ic_insn riscv_rv64ic_insn_ch1 (
		.insn(rvfi_insn_ch1),
		.valid(valid_ch1)
	);

	function [0:0] check_insn;
		input [31:0] insn;
		begin
			check_insn = 1;
			casez (rvfi_insn_ch0)
				32'b ???????_?????_?????_???_1110011: // SYSTEM
					check_insn = 0;
				32'b ???????_?????_?????_???_0001111: // MISC-MEM
					check_insn = 0;
				32'b ???????_?????_?????_???_0101111: // AMO
					check_insn = 0;
			endcase
		end
	endfunction

	always @* begin
		if (!reset && rvfi_valid_ch0 && check_insn(rvfi_insn_ch0) && !rvfi_trap_ch0) begin
			assert (valid_ch0);
		end
		if (!reset && rvfi_valid_ch1 && check_insn(rvfi_insn_ch1) && !rvfi_trap_ch0) begin
			assert (valid_ch1);
		end
	end
endmodule
