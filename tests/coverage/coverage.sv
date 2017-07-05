module coverage(input [31:0] insn);
	wire [`ISA_COVERAGE_LEN_RV32I-1:0] insn_valid_rv32i;
	wire [`ISA_COVERAGE_LEN_RV32IC-1:0] insn_valid_rv32ic;

	wire riscv_rv32i_valid;

	isa_coverage_rv32i  isa_coverage_rv32i_inst  (.insn(insn), .valid(insn_valid_rv32i ));
	isa_coverage_rv32ic isa_coverage_rv32ic_inst (.insn(insn), .valid(insn_valid_rv32ic));

	riscv_rv32i_insn riscv_rv32i_insn_inst (.insn(insn), .valid(riscv_rv32i_valid));

	always_comb begin
		// check one-hot conditions
		assert(insn_valid_rv32i  == (insn_valid_rv32i  & -insn_valid_rv32i ));
		assert(insn_valid_rv32ic == (insn_valid_rv32ic & -insn_valid_rv32ic));

		// check insn hierarchy
		if (insn_valid_rv32i) assert(insn_valid_rv32ic);

		// check hand-written checkers
		assert(riscv_rv32i_valid == |insn_valid_rv32i);
	end
endmodule
