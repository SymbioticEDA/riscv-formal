module rvfi_insn_check (
	input clk,
	input enable,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,
	input [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order,
	input [`RISCV_FORMAL_NRET *                 32   - 1 : 0] rvfi_insn,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_rd,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_post_trap,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
`ifdef RISCV_FORMAL_CHANNEL_IDX
	localparam integer channel_idx = `RISCV_FORMAL_CHANNEL_IDX;
`else
	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin:channel
`endif
		(* keep *) wire valid = enable && rvfi_valid[channel_idx];
		(* keep *) wire [                      31 : 0] insn      = rvfi_insn     [channel_idx*32 +: 32];
		(* keep *) wire [                       4 : 0] rs1       = rvfi_rs1      [channel_idx*5  +:  5];
		(* keep *) wire [                       4 : 0] rs2       = rvfi_rs2      [channel_idx*5  +:  5];
		(* keep *) wire [                       4 : 0] rd        = rvfi_rd       [channel_idx*5  +:  5];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pre_pc    = rvfi_pre_pc   [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pre_rs1   = rvfi_pre_rs1  [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] pre_rs2   = rvfi_pre_rs2  [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] post_pc   = rvfi_post_pc  [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] post_rd   = rvfi_post_rd  [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire                                post_trap = rvfi_post_trap[channel_idx];

		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_addr  = rvfi_mem_addr [channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_rmask = rvfi_mem_rmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] mem_wmask = rvfi_mem_wmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_rdata = rvfi_mem_rdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] mem_wdata = rvfi_mem_wdata[channel_idx*`RISCV_FORMAL_XLEN   +: `RISCV_FORMAL_XLEN];

		(* keep *) wire                                spec_valid;
		(* keep *) wire [                       4 : 0] spec_rs1;
		(* keep *) wire [                       4 : 0] spec_rs2;
		(* keep *) wire [                       4 : 0] spec_rd;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_rd;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_post_pc;
		(* keep *) wire                                spec_post_trap;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_addr;
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_rmask;
		(* keep *) wire [`RISCV_FORMAL_XLEN/8 - 1 : 0] spec_mem_wmask;
		(* keep *) wire [`RISCV_FORMAL_XLEN   - 1 : 0] spec_mem_wdata;

		rvfi_insn_`RISCV_FORMAL_INSN insn_spec (
			.rvfi_valid    (valid    ),
			.rvfi_insn     (insn     ),
			.rvfi_pre_pc   (pre_pc   ),
			.rvfi_pre_rs1  (pre_rs1  ),
			.rvfi_pre_rs2  (pre_rs2  ),
			.rvfi_mem_rdata(mem_rdata),

			.spec_valid    (spec_valid    ),
			.spec_rs1      (spec_rs1      ),
			.spec_rs2      (spec_rs2      ),
			.spec_rd       (spec_rd       ),
			.spec_post_rd  (spec_post_rd  ),
			.spec_post_pc  (spec_post_pc  ),
			.spec_post_trap(spec_post_trap),
			.spec_mem_addr (spec_mem_addr ),
			.spec_mem_rmask(spec_mem_rmask),
			.spec_mem_wmask(spec_mem_wmask),
			.spec_mem_wdata(spec_mem_wdata)
		);

		integer i;

		always @* begin
			if (spec_valid) begin
				if (spec_rs1)
					assert(spec_rs1 == rs1);

				if (spec_rs2)
					assert(spec_rs2 == rs2);

				if (!spec_post_trap) begin
					assert(spec_rd == rd);
					assert(spec_post_rd == post_rd);
					assert(spec_post_pc == post_pc);

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

				assert(spec_post_trap == post_trap);
			end
		end
`ifndef RISCV_FORMAL_CHANNEL_IDX
	end endgenerate
`endif
endmodule
