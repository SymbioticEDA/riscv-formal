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

	localparam [11:0] csr_none = 12'hFFF;
	`define DECLARE_CSR(_name, _maddr, _saddr, _uaddr) \
		localparam [11:0] csr_mindex_``_name = _maddr; \
		localparam [11:0] csr_sindex_``_name = _saddr; \
		localparam [11:0] csr_uindex_``_name = _uaddr;

	`DECLARE_CSR(misa,      12'h 301, csr_none, csr_none)
	`DECLARE_CSR(mcycle,    12'h B00, csr_none, 12'h C00)
	`DECLARE_CSR(minstret,  12'h B02, csr_none, 12'h C02)
	`DECLARE_CSR(mcycleh,   12'h B80, csr_none, 12'h C80)
	`DECLARE_CSR(minstreth, 12'h B82, csr_none, 12'h C82)

	`define csrget(_name, _type) rvfi.csr_``_name``_``_type
	`define csr_mindex(_name) csr_mindex_``_name
	`define csr_sindex(_name) csr_sindex_``_name
	`define csr_uindex(_name) csr_uindex_``_name
	`define csr_mindexh(_name) csr_mindex_``_name``h
	`define csr_sindexh(_name) csr_sindex_``_name``h
	`define csr_uindexh(_name) csr_uindex_``_name``h

	wire csr_insn_valid = rvfi.valid && (rvfi.insn[6:0] == 7'b 1110011) && (rvfi.insn[13:12] != 0) && ((rvfi.insn >> 32) == 0);
	wire [11:0] csr_insn_addr = rvfi.insn[31:20];

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_arg = rvfi.insn[14] ? rvfi.insn[19:15] : rvfi.rs1_rdata;

`ifdef RISCV_FORMAL_CSRWH
	wire csr_hi = rvfi.ixl == 1 && (csr_insn_addr == `csr_mindexh(`RISCV_FORMAL_CSRW_NAME)
		`ifdef RISCV_FORMAL_SMODE
			|| csr_insn_addr == `csr_sindexh(`RISCV_FORMAL_CSRW_NAME)
		`endif
		`ifdef RISCV_FORMAL_UMODE
			|| csr_insn_addr == `csr_uindexh(`RISCV_FORMAL_CSRW_NAME)
		`endif
	);

	wire [63:0] csr_insn_rmask_full = `csrget(`RISCV_FORMAL_CSRW_NAME, rmask);
	wire [63:0] csr_insn_wmask_full = `csrget(`RISCV_FORMAL_CSRW_NAME, wmask);
	wire [63:0] csr_insn_rdata_full = `csrget(`RISCV_FORMAL_CSRW_NAME, rdata);
	wire [63:0] csr_insn_wdata_full = `csrget(`RISCV_FORMAL_CSRW_NAME, wdata);

	wire [63:0] csr_insn_changed_full = csr_insn_wmask_full & (~csr_insn_rmask_full | (csr_insn_rmask_full & (csr_insn_rdata_full ^ csr_insn_wdata_full)));

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rmask = (csr_hi ? csr_insn_rmask_full >> 32 : csr_insn_rmask_full) & (rvfi.ixl == 1 ? 'h FFFF_FFFF : -1);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wmask = (csr_hi ? csr_insn_wmask_full >> 32 : csr_insn_wmask_full) & (rvfi.ixl == 1 ? 'h FFFF_FFFF : -1);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rdata = (csr_hi ? csr_insn_rdata_full >> 32 : csr_insn_rdata_full) & (rvfi.ixl == 1 ? 'h FFFF_FFFF : -1);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wdata = (csr_hi ? csr_insn_wdata_full >> 32 : csr_insn_wdata_full) & (rvfi.ixl == 1 ? 'h FFFF_FFFF : -1);
`else
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rmask = `csrget(`RISCV_FORMAL_CSRW_NAME, rmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wmask = `csrget(`RISCV_FORMAL_CSRW_NAME, wmask);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_rdata = `csrget(`RISCV_FORMAL_CSRW_NAME, rdata);
	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_wdata = `csrget(`RISCV_FORMAL_CSRW_NAME, wdata);
`endif

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_smask =
		/* CSRRW, CSRRWI */ (rvfi.insn[13:12] == 1) ? csr_insn_arg :
		/* CSRRS, CSRRSI */ (rvfi.insn[13:12] == 2) ? csr_insn_arg : 0;

	wire [`RISCV_FORMAL_XLEN-1:0] csr_insn_cmask =
		/* CSRRW, CSRRWI */ (rvfi.insn[13:12] == 1) ? ~csr_insn_arg :
		/* CSRCS, CSRRCI */ (rvfi.insn[13:12] == 3) ? csr_insn_arg : 0;

	wire csr_write = !rvfi.insn[13] || rvfi.insn[19:15];
	wire csr_read = rvfi.insn[11:7] != 0;
	reg csr_illacc;

	always @* begin
		csr_illacc = 0;
		case (csr_insn_addr[11:8])
			/* User CSRs */
			4'b 00_00, 4'b 01_00, 4'b 10_00: begin // read/write
			end
			4'b 11_00: begin // read-only
				if (csr_write) csr_illacc = 1;
			end

			/* Supervisor CSRs */
			4'b 00_01, 4'b 01_01, 4'b 10_01: begin // read/write
				if (rvfi.mode < 1) csr_illacc = 1;
			end
			4'b 11_01: begin // read-only
				if (rvfi.mode < 1) csr_illacc = 1;
				if (csr_write) csr_illacc = 1;
			end

			/* Reserved CSRs */
			4'b 00_10, 4'b 01_10, 4'b 10_10, 4'b 11_10: begin
			end

			/* Machine CSRs */
			4'b 00_11, 4'b 01_11, 4'b 10_11: begin // read/write
				if (rvfi.mode < 3) csr_illacc = 1;
			end
			4'b 11_11: begin // read-only
				if (rvfi.mode < 3) csr_illacc = 1;
				if (csr_write) csr_illacc = 1;
			end
		endcase
	end

	wire [`RISCV_FORMAL_XLEN-1:0] effective_csr_insn_wmask = csr_insn_rmask | csr_insn_wmask;
	wire [`RISCV_FORMAL_XLEN-1:0] effective_csr_insn_wdata = (csr_insn_wdata & csr_insn_wmask) | (csr_insn_rdata & ~csr_insn_wmask);

	wire [`RISCV_FORMAL_XLEN-1:0] spec_pc_wdata = rvfi.pc_rdata + 4;

	wire insn_pma_x;

`ifdef RISCV_FORMAL_PMA_MAP
	`RISCV_FORMAL_PMA_MAP insn_pma (
		.address(rvfi.pc_rdata),
		.log2len(rvfi.insn[1:0] == 2'b11 ? 2'd2 : 2'd1),
		.X(insn_pma_x)
	);
`else
	assign insn_pma_x = 1;
`endif

	integer i;

	always @* begin
		if (!reset && check) begin
			assume (csr_insn_valid);
			assume (csr_insn_addr != csr_none);
			assume (csr_insn_addr == `csr_mindex(`RISCV_FORMAL_CSRW_NAME)
				`ifdef RISCV_FORMAL_SMODE
					|| csr_insn_addr == `csr_sindex(`RISCV_FORMAL_CSRW_NAME)
				`endif
				`ifdef RISCV_FORMAL_UMODE
					|| csr_insn_addr == `csr_uindex(`RISCV_FORMAL_CSRW_NAME)
				`endif
				`ifdef RISCV_FORMAL_CSRWH
					|| csr_hi
				`endif
			);

			if (!`rvformal_addr_valid(rvfi.pc_rdata) || !insn_pma_x || csr_illacc) begin
				assert (rvfi.trap);
				assert (rvfi.rd_addr == 0);
				assert (rvfi.rd_wdata == 0);
			end else begin
				assert (!rvfi.trap);
				assert (rvfi.rd_addr == rvfi.insn[11:7]);
				assert (`rvformal_addr_eq(rvfi.pc_wdata, spec_pc_wdata));

				if (rvfi.rd_addr == 0) begin
					assert (rvfi.rd_wdata == 0);
				end else begin
					assert (csr_insn_rmask == {`RISCV_FORMAL_XLEN{1'b1}});
					assert (csr_insn_rdata == rvfi.rd_wdata);
				end

				assert (((csr_insn_smask | csr_insn_cmask) & ~effective_csr_insn_wmask) == 0);
				assert ((csr_insn_smask & ~effective_csr_insn_wdata) == 0);
				assert ((csr_insn_cmask & effective_csr_insn_wdata) == 0);

`ifdef RISCV_FORMAL_CSRWH
				if (csr_hi) begin
					assert (csr_insn_changed_full[31:0] == 0);
				end else if (rvfi.ixl == 1) begin
					assert (csr_insn_changed_full[63:32] == 0);
				end
`endif
			end

			assert (rvfi.mem_wmask == 0);
		end
	end
endmodule
