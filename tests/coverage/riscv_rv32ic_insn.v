// Check if a given instruction is an RV32IC instruction (without SYSTEM opcode)
//
module riscv_rv32ic_insn (
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
			valid = (insn[14:12] != 3'b 011) && (insn[14:12] != 3'b 110) && (insn[14:12] != 3'b 111);
		end

		if (insn[6:0] == 7'b 01_000_11) begin // STORE
			valid = (insn[14:12] == 3'b 000) || (insn[14:12] == 3'b 001) || (insn[14:12] == 3'b 010);
		end

		if (insn[6:0] == 7'b 00_100_11) begin // OP-IMM
			case (insn[14:12])
				3'b 001: begin // SLLI
					valid = insn[31:25] == 7'b 0000000;
				end
				3'b 101: begin // SRLI SRAI
					valid = (insn[31:25] == 7'b 0000000) || (insn[31:25] == 7'b 0100000);
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

		if (insn[31:16] == 16'b0 && insn[1:0] != 2'b11) begin
			casez (insn[15:0])
				// RVC -- Quadrant 0
				16'b 000_???_???_??_???_00: valid = |insn[12:5];              // C.ADDI4SPN
				16'b 010_???_???_??_???_00: valid = 1;                        // C.LW
				16'b 110_???_???_??_???_00: valid = 1;                        // C.SW

				// RVC -- Quadrant 1
				16'b 000_?_??_???_??_???_01: valid = 1;                       // C.NOP, C.ADDI
				16'b 001_?_??_???_??_???_01: valid = 1;                       // C.JAL
				16'b 010_?_??_???_??_???_01: valid = 1;                       // C.LI
				16'b 011_?_??_???_??_???_01: valid = |{insn[12], insn[6:2]};  // C.ADDI16SP, C.LUI
				16'b 100_?_00_???_??_???_01: valid = !insn[12];               // C.SRLI
				16'b 100_?_01_???_??_???_01: valid = !insn[12];               // C.SRAI
				16'b 100_?_10_???_??_???_01: valid = 1;                       // C.ANDI
				16'b 100_0_11_???_00_???_01: valid = 1;                       // C.SUB
				16'b 100_0_11_???_01_???_01: valid = 1;                       // C.XOR
				16'b 100_0_11_???_10_???_01: valid = 1;                       // C.OR
				16'b 100_0_11_???_11_???_01: valid = 1;                       // C.AND
				16'b 101_?_??_???_??_???_01: valid = 1;                       // C.J
				16'b 110_?_??_???_??_???_01: valid = 1;                       // C.BEQZ
				16'b 111_?_??_???_??_???_01: valid = 1;                       // C.BNEZ

				// RVC -- Quadrant 2
				16'b 000_?_?????_?????_10: valid = !insn[12];                 // C.SLLI
				16'b 010_?_?????_?????_10: valid = |insn[11:7];               // C.LWSP
				16'b 100_0_?????_00000_10: valid = |insn[11:7];               // C.JR
				16'b 100_0_?????_?????_10: valid = |insn[6:2];                // C.MV
				16'b 100_1_00000_00000_10: valid = 0;                         // C.EBREAK (SYSTEM => valid=0)
				16'b 100_1_?????_?????_10: valid = 1;                         // C.JALR, C.ADD
				16'b 110_?_?????_?????_10: valid = 1;                         // C.SWSP
			endcase
		end
	end
endmodule
