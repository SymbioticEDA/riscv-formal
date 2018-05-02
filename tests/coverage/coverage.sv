module coverage32(input [31:0] insn);
	wire [`ISA_COVERAGE_LEN_RV32I-1:0] insn_valid_rv32i;
	wire [`ISA_COVERAGE_LEN_RV32IC-1:0] insn_valid_rv32ic;

	wire riscv_rv32i_valid;
	wire riscv_rv32ic_valid;

	isa_coverage_rv32i  isa_coverage_rv32i_inst  (.insn(insn), .valid(insn_valid_rv32i ));
	isa_coverage_rv32ic isa_coverage_rv32ic_inst (.insn(insn), .valid(insn_valid_rv32ic));

	riscv_rv32i_insn  riscv_rv32i_insn_inst  (.insn(insn), .valid(riscv_rv32i_valid ));
	riscv_rv32ic_insn riscv_rv32ic_insn_inst (.insn(insn), .valid(riscv_rv32ic_valid));

	always_comb begin
		// check one-hot conditions
		assert(insn_valid_rv32i  == (insn_valid_rv32i  & -insn_valid_rv32i ));
		assert(insn_valid_rv32ic == (insn_valid_rv32ic & -insn_valid_rv32ic));

		// check insn hierarchy
		if (insn_valid_rv32i) assert(insn_valid_rv32ic);

		// check hand-written checkers
		assert(riscv_rv32i_valid == |insn_valid_rv32i);
		assert(riscv_rv32ic_valid == |insn_valid_rv32ic);
	end
endmodule

module coverage64(input [31:0] insn);
	wire [`ISA_COVERAGE_LEN_RV64I-1:0] insn_valid_rv64i;
	wire [`ISA_COVERAGE_LEN_RV64IC-1:0] insn_valid_rv64ic;

	wire riscv_rv64i_valid;
	wire riscv_rv64ic_valid;

	isa_coverage_rv64i  isa_coverage_rv64i_inst  (.insn(insn), .valid(insn_valid_rv64i ));
	isa_coverage_rv64ic isa_coverage_rv64ic_inst (.insn(insn), .valid(insn_valid_rv64ic));

	riscv_rv64i_insn  riscv_rv64i_insn_inst  (.insn(insn), .valid(riscv_rv64i_valid ));
	riscv_rv64ic_insn riscv_rv64ic_insn_inst (.insn(insn), .valid(riscv_rv64ic_valid));

	always_comb begin
		// check one-hot conditions
		assert(insn_valid_rv64i  == (insn_valid_rv64i  & -insn_valid_rv64i ));
		assert(insn_valid_rv64ic == (insn_valid_rv64ic & -insn_valid_rv64ic));

		// check insn hierarchy
		if (insn_valid_rv64i) assert(insn_valid_rv64ic);

		// check hand-written checkers
		assert(riscv_rv64i_valid == |insn_valid_rv64i);
		assert(riscv_rv64ic_valid == |insn_valid_rv64ic);
	end
endmodule
