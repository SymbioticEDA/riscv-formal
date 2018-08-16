// Copyright (C) 2017  Clifford Wolf <clifford@symbioticeda.com>
//
// Permission to use, copy, modify, and/or distribute this software for any
// purpose with or without fee is hereby granted, provided that the above
// copyright notice and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
// WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
// ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
// WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
// ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
// OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

module rvfi_csrw_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
	`RVFI_CHANNEL(rvfi, `RISCV_FORMAL_CHANNEL_IDX)

	localparam [11:0] csr_index_mcycle = 12'hB00;

	`define csrget(_name, _type) rvfi.csr_``_name``_``_type
	`define csrindex(_name) csr_index_``_name

	wire [`RISCV_FORMAL_XLEN-1:0] arg = rvfi.insn[14] ? rvfi.insn[19:15] : rvfi.rs1_rdata;
	wire [`RISCV_FORMAL_XLEN-1:0] csr_rmask = `csrget(`RISCV_FORMAL_CSR_NAME, rmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_wmask = `csrget(`RISCV_FORMAL_CSR_NAME, wmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_rdata = `csrget(`RISCV_FORMAL_CSR_NAME, rdata);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_wdata = `csrget(`RISCV_FORMAL_CSR_NAME, wdata);

	integer i;

	always @* begin
		if (!reset && check) begin
			assume (rvfi.valid);
			assume (rvfi.insn[6:0] == 7'b 1110011);
			assume (rvfi.insn[13:12] != 0);
			assume (rvfi.insn[31:20] == `csrindex(`RISCV_FORMAL_CSR_NAME));

			assert ((rvfi.insn >> 32) == 0);

			if (rvfi.rd_addr == 0) begin
				assert (rvfi.rd_wdata == 0);
			end else begin
				assert (csr_rmask == {`RISCV_FORMAL_XLEN{1'b1}});
				assert (csr_rdata == rvfi.rd_wdata);
			end

			// CSRRW, CSRRWI
			if (rvfi.insn[13:12] == 1) begin
				assert (csr_wmask == {`RISCV_FORMAL_XLEN{1'b1}});
				assert (csr_wdata == arg);
			end

			// CSRRS, CSRRSI
			if (rvfi.insn[13:12] == 2) begin
				for (i = 0; i < `RISCV_FORMAL_XLEN; i = i+1) begin
					if (arg[i]) begin
						if (csr_wmask[i]) begin
							assert (csr_wdata[i]);
						end else begin
							assert (csr_rmask[i]);
							assert (csr_rdata[i]);
						end
					end else
					if (csr_wmask[i]) begin
						assert (csr_rmask[i]);
						assert (csr_rdata[i] == csr_wdata[i]);
					end
				end
			end

			// CSRRC, CSRRCI
			if (rvfi.insn[13:12] == 3) begin
				for (i = 0; i < `RISCV_FORMAL_XLEN; i = i+1) begin
					if (arg[i]) begin
						if (csr_wmask[i]) begin
							assert (!csr_wdata[i]);
						end else begin
							assert (csr_rmask[i]);
							assert (!csr_rdata[i]);
						end
					end else
					if (csr_wmask[i]) begin
						assert (csr_rmask[i]);
						assert (csr_rdata[i] == csr_wdata[i]);
					end
				end
			end
		end
	end
endmodule
