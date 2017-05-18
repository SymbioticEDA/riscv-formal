`define RISCV_FORMAL
`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ALIGNED_MEM
`include "../../../../picorv32/picorv32.v"
`include "../../../checks/rvfi_macros.vh"
`include "insns.vh"

module testbench (
	input         clk,
	input         mem_ready,
	output        mem_valid,
	output        mem_instr,
	output [31:0] mem_addr,
	output [31:0] mem_wdata,
	output [3:0]  mem_wstrb,
	input  [31:0] mem_rdata
);
	`RFVI_WIRES

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

	reg resetn = 0;
	wire trap;

	always @(posedge clk)
		resetn <= 1;

	picorv32 #(
		.BARREL_SHIFTER(1)
	) uut (
		.clk       (clk      ),
		.resetn    (resetn   ),
		.trap      (trap     ),

		.mem_valid (mem_valid),
		.mem_instr (mem_instr),
		.mem_ready (mem_ready),
		.mem_addr  (mem_addr ),
		.mem_wdata (mem_wdata),
		.mem_wstrb (mem_wstrb),
		.mem_rdata (mem_rdata),

		`RFVI_CONN
	);

	`include "models.vh"

	integer i;
	always @* begin
		if (spec_valid) begin
			if (spec_rs1_addr)
				assert(spec_rs1_addr == rvfi_rs1_addr);

			if (spec_rs2_addr)
				assert(spec_rs2_addr == rvfi_rs2_addr);

			if (!spec_trap) begin
				assert(spec_rd_addr == rvfi_rd_addr);
				assert(spec_rd_wdata == rvfi_rd_wdata);
				assert(spec_pc_wdata == rvfi_pc_wdata);

				if (spec_mem_wmask || spec_mem_rmask) begin
					assert(spec_mem_addr == rvfi_mem_addr);
				end

				for (i = 0; i < `RISCV_FORMAL_XLEN/8; i = i+1) begin
					if (spec_mem_wmask[i]) begin
						assert(rvfi_mem_wmask[i]);
						assert(spec_mem_wdata[i*8 +: 8] == rvfi_mem_wdata[i*8 +: 8]);
					end else if (rvfi_mem_wmask[i]) begin
						assert(rvfi_mem_rmask[i]);
						assert(rvfi_mem_rdata[i*8 +: 8] == rvfi_mem_wdata[i*8 +: 8]);
					end
					if (spec_mem_rmask[i]) begin
						assert(rvfi_mem_rmask[i]);
					end
				end
			end

			assert(spec_trap == trap);
		end
	end
endmodule
