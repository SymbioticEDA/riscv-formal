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

	wire csr_insn_valid = rvfi.valid && (rvfi.insn[6:0] == 7'b 1110011) && (rvfi.insn[13:12] != 0) && ((rvfi.insn >> 32) == 0);
	wire [11:0] csr_insn_addr = rvfi.insn[31:20];

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_arg = rvfi.insn[14] ? rvfi.insn[19:15] : rvfi.rs1_rdata;
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rmask = `csrget(`RISCV_FORMAL_CSR_NAME, rmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wmask = `csrget(`RISCV_FORMAL_CSR_NAME, wmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rdata = `csrget(`RISCV_FORMAL_CSR_NAME, rdata);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wdata = `csrget(`RISCV_FORMAL_CSR_NAME, wdata);

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_smask =
		/* CSRRW, CSRRWI */ (rvfi.insn[13:12] == 1) ? csr_insn_wdata :
		/* CSRRS, CSRRSI */ (rvfi.insn[13:12] == 2) ? csr_insn_wdata : 0;

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_cmask =
		/* CSRRW, CSRRWI */ (rvfi.insn[13:12] == 1) ? ~csr_insn_wdata :
		/* CSRCS, CSRRCI */ (rvfi.insn[13:12] == 3) ? csr_insn_wdata : 0;

	wire [`RISCV_FORMAL_XLEN-1:0] effective_csr_insn_wmask = csr_insn_rmask | csr_insn_wmask;
	wire [`RISCV_FORMAL_XLEN-1:0] effective_csr_insn_wdata = (csr_insn_wdata & csr_insn_wmask) | (csr_insn_rdata & ~csr_insn_wmask);

	integer i;

	always @* begin
		if (!reset && check) begin
			assume (csr_insn_valid);
			assume (csr_insn_addr == `csrindex(`RISCV_FORMAL_CSR_NAME));

			if (rvfi.rd_addr == 0) begin
				assert (rvfi.rd_wdata == 0);
			end else begin
				assert (csr_insn_rmask == {`RISCV_FORMAL_XLEN{1'b1}});
				assert (csr_insn_rdata == rvfi.rd_wdata);
			end

			assert (((csr_insn_smask | csr_insn_cmask) & ~effective_csr_insn_wmask) == 0);
			assert ((csr_insn_smask & ~effective_csr_insn_wdata) == 0);
			assert ((csr_insn_cmask & effective_csr_insn_wdata) == 0);
		end
	end
endmodule
