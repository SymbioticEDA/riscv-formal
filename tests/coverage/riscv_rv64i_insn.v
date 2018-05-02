// Check if a given instruction is an RV64I instruction (without SYSTEM opcode)
//
module riscv_rv64i_insn (
	input [31:0] insn,
	output reg valid
);
	always @* begin
		valid = 0;

		if (insn[6:0] == 7'b 01_101_11) valid = 1; // LUI
		if (insn[6:0] == 7'b 00_101_11) valid = 1; // AUIPC
		if (insn[6:0] == 7'b 11_011_11) valid = 1; // JAL

		if (insn[6:0] == 7'b 11_001_11) begin // JALR
			valid = insn[14:12] == 3'b 000;
		end

		if (insn[6:0] == 7'b 11_000_11) begin // BRANCH
			valid = (insn[14:12] != 3'b 010) && (insn[14:12] != 3'b 011);
		end

		if (insn[6:0] == 7'b 00_000_11) begin // LOAD
			valid = (insn[14:12] != 3'b 111);
		end

		if (insn[6:0] == 7'b 01_000_11) begin // STORE
			valid = (insn[14:12] == 3'b 000) || (insn[14:12] == 3'b 001) || (insn[14:12] == 3'b 010) || (insn[14:12] == 3'b 011);
		end

		if (insn[6:0] == 7'b 00_100_11) begin // OP-IMM
			case (insn[14:12])
				3'b 001: begin // SLLI
					valid = insn[31:26] == 6'b 000000;
				end
				3'b 101: begin // SRLI SRAI
					valid = (insn[31:26] == 6'b 000000) || (insn[31:26] == 6'b 010000);
				end
				default: begin
					valid = 1;
				end
			endcase
		end

		if (insn[6:0] == 7'b 01_100_11) begin // OP
			case (insn[14:12])
				3'b 000, 3'b 101: begin // ADD SUB SRL SRA
					valid = (insn[31:25] == 7'b 0000000) || (insn[31:25] == 7'b 0100000);
				end
				default: begin
					valid = insn[31:25] == 7'b 0000000;
				end
			endcase
		end

		if (insn[6:0] == 7'b 00_110_11) begin // OP-IMM-32
			case (insn[14:12])
				3'b 001: begin // SLLIW
					valid = insn[31:25] == 7'b 0000000;
				end
				3'b 101: begin // SRLIW SRAIW
					valid = (insn[31:25] == 7'b 0000000) || (insn[31:25] == 7'b 0100000);
				end
				3'b 000: begin // ADDIW
					valid = 1;
				end
			endcase
		end

		if (insn[6:0] == 7'b 01_110_11) begin // OP-32
			case (insn[14:12])
				3'b 000, 3'b 101: begin // ADDW SUBW SRLW SRAW
					valid = (insn[31:25] == 7'b 0000000) || (insn[31:25] == 7'b 0100000);
				end
				3'b 001: begin // SLLW
					valid = insn[31:25] == 7'b 0000000;
				end
			endcase
		end
	end
endmodule
