module rocket_wrapper (
	input         clock,
	input         reset,

	output [31:0] rvfi_insn,
	output [31:0] rvfi_mem_addr,
	output [31:0] rvfi_mem_rdata,
	output [3:0]  rvfi_mem_rmask,
	output [31:0] rvfi_mem_wdata,
	output [3:0]  rvfi_mem_wmask,
	output [7:0]  rvfi_order,
	output [31:0] rvfi_pc_rdata,
	output [31:0] rvfi_pc_wdata,
	output [4:0]  rvfi_rd_addr,
	output [31:0] rvfi_rd_wdata,
	output [4:0]  rvfi_rs1_addr,
	output [31:0] rvfi_rs1_rdata,
	output [4:0]  rvfi_rs2_addr,
	output [31:0] rvfi_rs2_rdata,
	output        rvfi_trap,
	output        rvfi_valid
);
	// Rocket Tile Inputs

	(* keep *) wire        io_hartid = 0;
	(* keep *) wire [31:0] io_resetVector = 32'h 0001_0000;

	(* keep *) wire        io_interrupts_0_0 = 0;
	(* keep *) wire        io_interrupts_0_1 = 0;
	(* keep *) wire        io_interrupts_0_2 = 0;
	(* keep *) wire        io_interrupts_0_3 = 0;
	(* keep *) wire        io_interrupts_0_4 = 0;

	(* keep *) wire        io_master_0_a_ready = $anyseq;
	(* keep *) wire [31:0] io_master_0_b_bits_address = $anyseq;
	(* keep *) wire [3:0]  io_master_0_b_bits_mask = $anyseq;
	(* keep *) wire [2:0]  io_master_0_b_bits_opcode = $anyseq;
	(* keep *) wire [1:0]  io_master_0_b_bits_param = $anyseq;
	(* keep *) wire [3:0]  io_master_0_b_bits_size = $anyseq;
	(* keep *) wire [1:0]  io_master_0_b_bits_source = $anyseq;
	(* keep *) wire        io_master_0_b_valid = $anyseq;
	(* keep *) wire        io_master_0_c_ready = $anyseq;
	(* keep *) wire [1:0]  io_master_0_d_bits_addr_lo = $anyseq;
	(* keep *) wire [31:0] io_master_0_d_bits_data = $anyseq;
	(* keep *) wire        io_master_0_d_bits_error = $anyseq;
	(* keep *) wire [2:0]  io_master_0_d_bits_opcode = $anyseq;
	(* keep *) wire [1:0]  io_master_0_d_bits_param = $anyseq;
	(* keep *) wire [1:0]  io_master_0_d_bits_sink = $anyseq;
	(* keep *) wire [3:0]  io_master_0_d_bits_size = $anyseq;
	(* keep *) wire [1:0]  io_master_0_d_bits_source = $anyseq;
	(* keep *) wire        io_master_0_d_valid = $anyseq;
	(* keep *) wire        io_master_0_e_ready = $anyseq;

	// Rocket Tile Outputs

	(* keep *) wire [31:0] io_master_0_a_bits_address;
	(* keep *) wire [31:0] io_master_0_a_bits_data;
	(* keep *) wire [3:0]  io_master_0_a_bits_mask;
	(* keep *) wire [2:0]  io_master_0_a_bits_opcode;
	(* keep *) wire [2:0]  io_master_0_a_bits_param;
	(* keep *) wire [3:0]  io_master_0_a_bits_size;
	(* keep *) wire [1:0]  io_master_0_a_bits_source;
	(* keep *) wire        io_master_0_a_valid;
	(* keep *) wire        io_master_0_b_ready;
	(* keep *) wire [31:0] io_master_0_c_bits_address;
	(* keep *) wire [31:0] io_master_0_c_bits_data;
	(* keep *) wire        io_master_0_c_bits_error;
	(* keep *) wire [2:0]  io_master_0_c_bits_opcode;
	(* keep *) wire [2:0]  io_master_0_c_bits_param;
	(* keep *) wire [3:0]  io_master_0_c_bits_size;
	(* keep *) wire [1:0]  io_master_0_c_bits_source;
	(* keep *) wire        io_master_0_c_valid;
	(* keep *) wire        io_master_0_d_ready;
	(* keep *) wire [1:0]  io_master_0_e_bits_sink;
	(* keep *) wire        io_master_0_e_valid;

	// Input Constraints

	always @(posedge clock) begin
		if (reset) begin
			assume(io_master_0_a_ready == 0);
			assume(io_master_0_b_valid == 0);
			assume(io_master_0_c_ready == 0);
			assume(io_master_0_d_valid == 0);
			assume(io_master_0_e_ready == 0);
		end else begin
			if ($past(io_master_0_a_ready) && !$past(io_master_0_a_valid)) begin
				assume(io_master_0_a_ready);
			end

			if ($past(io_master_0_b_valid) && !$past(io_master_0_a_ready)) begin
				assume(io_master_0_b_valid);
				assume($stable(io_master_0_b_bits_address));
				assume($stable(io_master_0_b_bits_mask));
				assume($stable(io_master_0_b_bits_opcode));
				assume($stable(io_master_0_b_bits_param));
				assume($stable(io_master_0_b_bits_size));
				assume($stable(io_master_0_b_bits_source));
			end

			if ($past(io_master_0_c_ready) && !$past(io_master_0_c_valid)) begin
				assume(io_master_0_c_ready);
			end

			if ($past(io_master_0_d_valid) && !$past(io_master_0_d_ready)) begin
				assume(io_master_0_d_valid);
				assume($stable(io_master_0_d_bits_addr_lo));
				assume($stable(io_master_0_d_bits_data));
				assume($stable(io_master_0_d_bits_error));
				assume($stable(io_master_0_d_bits_opcode));
				assume($stable(io_master_0_d_bits_param));
				assume($stable(io_master_0_d_bits_sink));
				assume($stable(io_master_0_d_bits_size));
				assume($stable(io_master_0_d_bits_source));
			end

			if ($past(io_master_0_e_ready) && !$past(io_master_0_e_valid)) begin
				assume(io_master_0_e_ready);
			end
		end
	end

	// Formal Checker for IO interfaces

`ifdef FORMAL_CHECK_ROCKET_IO
	localparam integer reset_depth = 30;

	reg [7:0] cycle = 0;
	always @(posedge clock) cycle <= cycle + !(&cycle);

	always @(posedge clock) begin
		assume(reset == (cycle <= reset_depth));

		if (cycle == reset_depth) begin
			assert(!io_master_0_a_valid);
			assert(!io_master_0_b_ready);
			assert(!io_master_0_c_valid);
			assert(!io_master_0_d_ready);
			assert(!io_master_0_e_valid);
		end

		if (cycle > reset_depth) begin
			if ($past(io_master_0_a_valid) && !$past(io_master_0_a_ready)) begin
				assert(io_master_0_a_valid);
				assert($stable(io_master_0_a_bits_address));
				assert($stable(io_master_0_a_bits_data));
				assert($stable(io_master_0_a_bits_mask));
				assert($stable(io_master_0_a_bits_opcode));
				assert($stable(io_master_0_a_bits_param));
				assert($stable(io_master_0_a_bits_size));
				assert($stable(io_master_0_a_bits_source));
			end

			if ($past(io_master_0_b_ready) && !$past(io_master_0_b_valid)) begin
				assert(io_master_0_b_ready);
			end

			if ($past(io_master_0_c_valid) && !$past(io_master_0_c_ready)) begin
				assert(io_master_0_c_valid);
				assert($stable(io_master_0_c_bits_address));
				assert($stable(io_master_0_c_bits_data));
				assert($stable(io_master_0_c_bits_error));
				assert($stable(io_master_0_c_bits_opcode));
				assert($stable(io_master_0_c_bits_param));
				assert($stable(io_master_0_c_bits_size));
				assert($stable(io_master_0_c_bits_source));
			end

			if ($past(io_master_0_d_ready) && !$past(io_master_0_d_valid)) begin
				assert(io_master_0_d_ready);
			end

			if ($past(io_master_0_e_valid) && !$past(io_master_0_e_ready)) begin
				assert(io_master_0_e_valid);
				assert($stable(io_master_0_e_bits_sink));
			end

			cover(io_master_0_a_valid && io_master_0_a_ready);
			cover(io_master_0_b_valid && io_master_0_b_ready);
			cover(io_master_0_c_valid && io_master_0_c_ready);
			cover(io_master_0_d_valid && io_master_0_d_ready);
			cover(io_master_0_e_valid && io_master_0_e_ready);
		end
	end
`endif

	// Rocket Tile

	RocketTile_rocket rocket (
		.clock                     (clock                     ),
		.reset                     (reset                     ),

		.io_hartid                 (io_hartid                 ),
		.io_interrupts_0_0         (io_interrupts_0_0         ),
		.io_interrupts_0_1         (io_interrupts_0_1         ),
		.io_interrupts_0_2         (io_interrupts_0_2         ),
		.io_interrupts_0_3         (io_interrupts_0_3         ),
		.io_interrupts_0_4         (io_interrupts_0_4         ),
		.io_master_0_a_bits_address(io_master_0_a_bits_address),
		.io_master_0_a_bits_data   (io_master_0_a_bits_data   ),
		.io_master_0_a_bits_mask   (io_master_0_a_bits_mask   ),
		.io_master_0_a_bits_opcode (io_master_0_a_bits_opcode ),
		.io_master_0_a_bits_param  (io_master_0_a_bits_param  ),
		.io_master_0_a_bits_size   (io_master_0_a_bits_size   ),
		.io_master_0_a_bits_source (io_master_0_a_bits_source ),
		.io_master_0_a_ready       (io_master_0_a_ready       ),
		.io_master_0_a_valid       (io_master_0_a_valid       ),
		.io_master_0_b_bits_address(io_master_0_b_bits_address),
		.io_master_0_b_bits_mask   (io_master_0_b_bits_mask   ),
		.io_master_0_b_bits_opcode (io_master_0_b_bits_opcode ),
		.io_master_0_b_bits_param  (io_master_0_b_bits_param  ),
		.io_master_0_b_bits_size   (io_master_0_b_bits_size   ),
		.io_master_0_b_bits_source (io_master_0_b_bits_source ),
		.io_master_0_b_ready       (io_master_0_b_ready       ),
		.io_master_0_b_valid       (io_master_0_b_valid       ),
		.io_master_0_c_bits_address(io_master_0_c_bits_address),
		.io_master_0_c_bits_data   (io_master_0_c_bits_data   ),
		.io_master_0_c_bits_error  (io_master_0_c_bits_error  ),
		.io_master_0_c_bits_opcode (io_master_0_c_bits_opcode ),
		.io_master_0_c_bits_param  (io_master_0_c_bits_param  ),
		.io_master_0_c_bits_size   (io_master_0_c_bits_size   ),
		.io_master_0_c_bits_source (io_master_0_c_bits_source ),
		.io_master_0_c_ready       (io_master_0_c_ready       ),
		.io_master_0_c_valid       (io_master_0_c_valid       ),
		.io_master_0_d_bits_addr_lo(io_master_0_d_bits_addr_lo),
		.io_master_0_d_bits_data   (io_master_0_d_bits_data   ),
		.io_master_0_d_bits_error  (io_master_0_d_bits_error  ),
		.io_master_0_d_bits_opcode (io_master_0_d_bits_opcode ),
		.io_master_0_d_bits_param  (io_master_0_d_bits_param  ),
		.io_master_0_d_bits_sink   (io_master_0_d_bits_sink   ),
		.io_master_0_d_bits_size   (io_master_0_d_bits_size   ),
		.io_master_0_d_bits_source (io_master_0_d_bits_source ),
		.io_master_0_d_ready       (io_master_0_d_ready       ),
		.io_master_0_d_valid       (io_master_0_d_valid       ),
		.io_master_0_e_bits_sink   (io_master_0_e_bits_sink   ),
		.io_master_0_e_ready       (io_master_0_e_ready       ),
		.io_master_0_e_valid       (io_master_0_e_valid       ),
		.io_resetVector            (io_resetVector            ),

		.rvfi_insn                 (rvfi_insn                 ),
		.rvfi_mem_addr             (rvfi_mem_addr             ),
		.rvfi_mem_rdata            (rvfi_mem_rdata            ),
		.rvfi_mem_rmask            (rvfi_mem_rmask            ),
		.rvfi_mem_wdata            (rvfi_mem_wdata            ),
		.rvfi_mem_wmask            (rvfi_mem_wmask            ),
		.rvfi_order                (rvfi_order                ),
		.rvfi_pc_rdata             (rvfi_pc_rdata             ),
		.rvfi_pc_wdata             (rvfi_pc_wdata             ),
		.rvfi_rd_addr              (rvfi_rd_addr              ),
		.rvfi_rd_wdata             (rvfi_rd_wdata             ),
		.rvfi_rs1_addr             (rvfi_rs1_addr             ),
		.rvfi_rs1_rdata            (rvfi_rs1_rdata            ),
		.rvfi_rs2_addr             (rvfi_rs2_addr             ),
		.rvfi_rs2_rdata            (rvfi_rs2_rdata            ),
		.rvfi_trap                 (rvfi_trap                 ),
		.rvfi_valid                (rvfi_valid                )
	);
endmodule
