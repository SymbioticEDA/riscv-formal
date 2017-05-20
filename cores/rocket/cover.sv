module testbench (
	input clock, reset
);
	(* keep *) wire [31:0] rvfi_insn;
	(* keep *) wire [31:0] rvfi_mem_addr;
	(* keep *) wire [31:0] rvfi_mem_rdata;
	(* keep *) wire [3:0]  rvfi_mem_rmask;
	(* keep *) wire [31:0] rvfi_mem_wdata;
	(* keep *) wire [3:0]  rvfi_mem_wmask;
	(* keep *) wire [7:0]  rvfi_order;
	(* keep *) wire [31:0] rvfi_pc_rdata;
	(* keep *) wire [31:0] rvfi_pc_wdata;
	(* keep *) wire [4:0]  rvfi_rd_addr;
	(* keep *) wire [31:0] rvfi_rd_wdata;
	(* keep *) wire [4:0]  rvfi_rs1_addr;
	(* keep *) wire [31:0] rvfi_rs1_rdata;
	(* keep *) wire [4:0]  rvfi_rs2_addr;
	(* keep *) wire [31:0] rvfi_rs2_rdata;
	(* keep *) wire        rvfi_trap;
	(* keep *) wire        rvfi_valid;

	reg [7:0] insn_count = 0;
	reg [7:0] cycle_count = 0;

	localparam integer reset_depth = 10;

	always @(posedge clock) begin
		if (!reset && rvfi_valid)
			insn_count <= insn_count + |(insn_count + 1);
		cycle_count <= cycle_count + |(cycle_count + 1);
	end

	always @* begin
		assume(reset == (cycle_count <= reset_depth));
		cover(insn_count == 1);
		cover(insn_count == 2);
		cover(insn_count == 3);
		cover(insn_count == 4);
	end

	rocket_wrapper uut (
		.clock          (clock         ),
		.reset          (reset         ),
		.rvfi_insn      (rvfi_insn     ),
		.rvfi_mem_addr  (rvfi_mem_addr ),
		.rvfi_mem_rdata (rvfi_mem_rdata),
		.rvfi_mem_rmask (rvfi_mem_rmask),
		.rvfi_mem_wdata (rvfi_mem_wdata),
		.rvfi_mem_wmask (rvfi_mem_wmask),
		.rvfi_order     (rvfi_order    ),
		.rvfi_pc_rdata  (rvfi_pc_rdata ),
		.rvfi_pc_wdata  (rvfi_pc_wdata ),
		.rvfi_rd_addr   (rvfi_rd_addr  ),
		.rvfi_rd_wdata  (rvfi_rd_wdata ),
		.rvfi_rs1_addr  (rvfi_rs1_addr ),
		.rvfi_rs1_rdata (rvfi_rs1_rdata),
		.rvfi_rs2_addr  (rvfi_rs2_addr ),
		.rvfi_rs2_rdata (rvfi_rs2_rdata),
		.rvfi_trap      (rvfi_trap     ),
		.rvfi_valid     (rvfi_valid    )
	);
endmodule
