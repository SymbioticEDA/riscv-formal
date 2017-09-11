module rvfi_insn_check (
	input clock, reset, check,
	`RVFI_INPUTS
);
`ifdef RISCV_FORMAL_CHANNEL_IDX
	localparam integer channel_idx = `RISCV_FORMAL_CHANNEL_IDX;
`else
	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin:channel
`endif
		(* keep *) wire valid = !reset && check && rvfi_valid[channel_idx];
		(* keep *) wire [`RISCV_FORMAL_ILEN   - 1 : 0] insn      = rvfi_insn     [channel_idx*`RISCV_FORMAL_ILEN   +: `RISCV_FORMAL_ILEN];
		(* keep *) wire                                trap      = rvfi_trap     [channel_idx];
		(* keep *) wire                                halt      = rvfi_halt     [channel_idx];
		(* keep *) wire                                intr      = rvfi_intr     [channel_idx];
		(* keep *) wire [                       4 : 0] rs1_addr  = rvfi_rs1_addr [channel_idx*5  +:  5];
		(* keep *) wire [                       4 : 0] rs2_addr  = rvfi_rs2_addr [channel_idx*5  +:  5];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rs1_rdata = rvfi_rs1_rdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rs2_rdata = rvfi_rs2_rdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [                       4 : 0] rd_addr   = rvfi_rd_addr  [channel_idx*5  +:  5];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] rd_wdata  = rvfi_rd_wdata [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pc_rdata  = rvfi_pc_rdata [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pc_wdata  = rvfi_pc_wdata [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];

		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_addr  = rvfi_mem_addr [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_rmask = rvfi_mem_rmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_wmask = rvfi_mem_wmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_rdata = rvfi_mem_rdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_wdata = rvfi_mem_wdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];

		(* keep *) wire                                spec_valid;
		(* keep *) wire                                spec_trap;
		(* keep *) wire [                       4 : 0] spec_rs1_addr;
		(* keep *) wire [                       4 : 0] spec_rs2_addr;
		(* keep *) wire [                       4 : 0] spec_rd_addr;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_rd_wdata;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_pc_wdata;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr;
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask;
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata;

		`RISCV_FORMAL_INSN_MODEL insn_spec (
			.rvfi_valid    (valid    ),
			.rvfi_insn     (insn     ),
			.rvfi_pc_rdata (pc_rdata ),
			.rvfi_rs1_rdata(rs1_rdata),
			.rvfi_rs2_rdata(rs2_rdata),
			.rvfi_mem_rdata(mem_rdata),

			.spec_valid    (spec_valid    ),
			.spec_trap     (spec_trap     ),
			.spec_rs1_addr (spec_rs1_addr ),
			.spec_rs2_addr (spec_rs2_addr ),
			.spec_rd_addr  (spec_rd_addr  ),
			.spec_rd_wdata (spec_rd_wdata ),
			.spec_pc_wdata (spec_pc_wdata ),
			.spec_mem_addr (spec_mem_addr ),
			.spec_mem_rmask(spec_mem_rmask),
			.spec_mem_wmask(spec_mem_wmask),
			.spec_mem_wdata(spec_mem_wdata)
		);

		integer i;

		always @* begin
			if (!reset && check) begin
				assume(spec_valid);
			end
			if (spec_valid) begin
				assert(spec_rs1_addr == rs1_addr);
				assert(spec_rs2_addr == rs2_addr);

				if (!spec_trap) begin
					assert(spec_rd_addr == rd_addr);
					assert(spec_rd_wdata == rd_wdata);
					assert(spec_pc_wdata == pc_wdata);

					if (spec_mem_wmask || spec_mem_rmask) begin
						assert(spec_mem_addr == mem_addr);
					end

					for (i = 0; i < `RISCV_FORMAL_XLEN/8; i = i+1) begin
						if (spec_mem_wmask[i]) begin
							assert(mem_wmask[i]);
							assert(spec_mem_wdata[i*8 +: 8] == mem_wdata[i*8 +: 8]);
						end else if (mem_wmask[i]) begin
							assert(mem_rmask[i]);
							assert(mem_rdata[i*8 +: 8] == mem_wdata[i*8 +: 8]);
						end
						if (spec_mem_rmask[i]) begin
							assert(mem_rmask[i]);
						end
					end
				end

				assert(spec_trap == trap);
			end
		end
`ifndef RISCV_FORMAL_CHANNEL_IDX
	end endgenerate
`endif
endmodule
