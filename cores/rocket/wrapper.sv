module rocket_wrapper (
	input         clock,
	input         reset,

	output [63:0] rvfi_insn,
	output [63:0] rvfi_mem_addr,
	output [63:0] rvfi_mem_rdata,
	output [7:0]  rvfi_mem_rmask,
	output [63:0] rvfi_mem_wdata,
	output [7:0]  rvfi_mem_wmask,
	output [15:0]  rvfi_order,
	output [63:0] rvfi_pc_rdata,
	output [63:0] rvfi_pc_wdata,
	output [9:0]  rvfi_rd_addr,
	output [63:0] rvfi_rd_wdata,
	output [9:0]  rvfi_rs1_addr,
	output [63:0] rvfi_rs1_rdata,
	output [9:0]  rvfi_rs2_addr,
	output [63:0] rvfi_rs2_rdata,
	output [1:0]  rvfi_trap,
	output [1:0]  rvfi_halt,
	output [1:0]  rvfi_intr,
	output [1:0]  rvfi_valid
);
	// Rocket Tile Inputs

	(* keep *) wire        io_hartid = 0;
	(* keep *) wire [31:0] io_resetVector = 32'h 0001_0000;

	(* keep *) wire        io_interrupts_0_0 = 0;
	(* keep *) wire        io_interrupts_0_1 = 0;
	(* keep *) wire        io_interrupts_0_2 = 0;
	(* keep *) wire        io_interrupts_0_3 = 0;

	(* keep *) wire         io_master_0_a_ready;
	(* keep *) wire         io_master_0_b_valid = 0;
	(* keep *) wire         io_master_0_d_valid;
	(* keep *) wire  [2:0]  io_master_0_d_bits_opcode;
	(* keep *) wire  [1:0]  io_master_0_d_bits_param;
	(* keep *) wire  [3:0]  io_master_0_d_bits_size;
	(* keep *) wire         io_master_0_d_bits_source;
	(* keep *) wire         io_master_0_d_bits_sink;
	(* keep *) wire  [1:0]  io_master_0_d_bits_addr_lo;
	(* keep *) wire  [31:0] io_master_0_d_bits_data;
	(* keep *) wire         io_master_0_d_bits_error;

	(* keep *) wire         io_slave_0_a_valid = 0;
	(* keep *) wire  [2:0]  io_slave_0_a_bits_opcode = 0;
	(* keep *) wire  [2:0]  io_slave_0_a_bits_param = 0;
	(* keep *) wire  [2:0]  io_slave_0_a_bits_size = 0;
	(* keep *) wire  [4:0]  io_slave_0_a_bits_source = 0;
	(* keep *) wire  [31:0] io_slave_0_a_bits_address = 0;
	(* keep *) wire  [3:0]  io_slave_0_a_bits_mask = 0;
	(* keep *) wire  [31:0] io_slave_0_a_bits_data = 0;
	(* keep *) wire         io_slave_0_c_valid = 0;
	(* keep *) wire         io_slave_0_d_ready = 0;
	(* keep *) wire         io_slave_0_e_valid = 0;

	// Rocket Tile Outputs

	(* keep *) wire        io_master_0_a_valid;
	(* keep *) wire [2:0]  io_master_0_a_bits_opcode;
	(* keep *) wire [2:0]  io_master_0_a_bits_param;
	(* keep *) wire [3:0]  io_master_0_a_bits_size;
	(* keep *) wire        io_master_0_a_bits_source;
	(* keep *) wire [31:0] io_master_0_a_bits_address;
	(* keep *) wire [3:0]  io_master_0_a_bits_mask;
	(* keep *) wire [31:0] io_master_0_a_bits_data;
	(* keep *) wire        io_master_0_c_valid;
	(* keep *) wire        io_master_0_d_ready;
	(* keep *) wire        io_master_0_e_valid;

	(* keep *) wire        io_slave_0_a_ready;
	(* keep *) wire        io_slave_0_b_valid;
	(* keep *) wire        io_slave_0_d_valid;
	(* keep *) wire [2:0]  io_slave_0_d_bits_opcode;
	(* keep *) wire [1:0]  io_slave_0_d_bits_param;
	(* keep *) wire [2:0]  io_slave_0_d_bits_size;
	(* keep *) wire [4:0]  io_slave_0_d_bits_source;
	(* keep *) wire        io_slave_0_d_bits_sink;
	(* keep *) wire [1:0]  io_slave_0_d_bits_addr_lo;
	(* keep *) wire [31:0] io_slave_0_d_bits_data;
	(* keep *) wire        io_slave_0_d_bits_error;

	// TileLink A-D Dummy Slave

	tilelink_ad_dummy TL_AD_DUMMY (
		.clock                  (clock                     ),
		.reset                  (reset                     ),

		.channel_a_ready        (io_master_0_a_ready       ),
		.channel_a_valid        (io_master_0_a_valid       ),
		.channel_a_bits_address (io_master_0_a_bits_address),
		.channel_a_bits_data    (io_master_0_a_bits_data   ),
		.channel_a_bits_mask    (io_master_0_a_bits_mask   ),
		.channel_a_bits_opcode  (io_master_0_a_bits_opcode ),
		.channel_a_bits_param   (io_master_0_a_bits_param  ),
		.channel_a_bits_size    (io_master_0_a_bits_size   ),
		.channel_a_bits_source  (io_master_0_a_bits_source ),

		.channel_d_ready        (io_master_0_d_ready       ),
		.channel_d_valid        (io_master_0_d_valid       ),
		.channel_d_bits_addr_lo (io_master_0_d_bits_addr_lo),
		.channel_d_bits_data    (io_master_0_d_bits_data   ),
		.channel_d_bits_error   (io_master_0_d_bits_error  ),
		.channel_d_bits_opcode  (io_master_0_d_bits_opcode ),
		.channel_d_bits_param   (io_master_0_d_bits_param  ),
		.channel_d_bits_sink    (io_master_0_d_bits_sink   ),
		.channel_d_bits_size    (io_master_0_d_bits_size   ),
		.channel_d_bits_source  (io_master_0_d_bits_source )
	);

	// Input Constraints

	always @(posedge clock) begin
		if (reset) begin
			// assume(io_master_0_a_ready == 0);
			// assume(io_master_0_d_valid == 0);
		end

		// Also make sure we don't toggle source on channel D during reset (makes d_ready toggle)
		if (reset && !io_master_0_d_valid) assume(io_master_0_d_bits_source == 0);
	end

	// Formal Checker for IO interfaces

`ifdef FORMAL_CHECK_ROCKET_IO
	localparam integer reset_depth = 5;

	reg [7:0] cycle = 0;
	always @(posedge clock) cycle <= cycle + !(&cycle);

	always @(posedge clock) begin
		assume(reset == (cycle <= reset_depth));

		if (cycle == reset_depth) begin
			// assert(!io_master_0_a_valid);
			// assert(!io_master_0_d_ready);
			assert(!rvfi_valid);
		end

		if (cycle > reset_depth) begin
			cover(io_master_0_a_valid && io_master_0_a_ready);
			cover(io_master_0_d_valid && io_master_0_d_ready);
		end

		cover(cycle == 30);
	end
`endif

	// Rocket Tile

	RocketTile_rocket rocket (
		.clock                     (clock                     ),
		.reset                     (reset                     ),

		.io_hartid                 (io_hartid                 ),
		.io_resetVector            (io_resetVector            ),

		.io_interrupts_0_0         (io_interrupts_0_0         ),
		.io_interrupts_0_1         (io_interrupts_0_1         ),
		.io_interrupts_0_2         (io_interrupts_0_2         ),
		.io_interrupts_0_3         (io_interrupts_0_3         ),

		.io_master_0_a_ready       (io_master_0_a_ready       ),
		.io_master_0_a_valid       (io_master_0_a_valid       ),
		.io_master_0_a_bits_opcode (io_master_0_a_bits_opcode ),
		.io_master_0_a_bits_param  (io_master_0_a_bits_param  ),
		.io_master_0_a_bits_size   (io_master_0_a_bits_size   ),
		.io_master_0_a_bits_source (io_master_0_a_bits_source ),
		.io_master_0_a_bits_address(io_master_0_a_bits_address),
		.io_master_0_a_bits_mask   (io_master_0_a_bits_mask   ),
		.io_master_0_a_bits_data   (io_master_0_a_bits_data   ),
		.io_master_0_b_valid       (io_master_0_b_valid       ),
		.io_master_0_c_valid       (io_master_0_c_valid       ),
		.io_master_0_d_ready       (io_master_0_d_ready       ),
		.io_master_0_d_valid       (io_master_0_d_valid       ),
		.io_master_0_d_bits_opcode (io_master_0_d_bits_opcode ),
		.io_master_0_d_bits_param  (io_master_0_d_bits_param  ),
		.io_master_0_d_bits_size   (io_master_0_d_bits_size   ),
		.io_master_0_d_bits_source (io_master_0_d_bits_source ),
		.io_master_0_d_bits_sink   (io_master_0_d_bits_sink   ),
		.io_master_0_d_bits_addr_lo(io_master_0_d_bits_addr_lo),
		.io_master_0_d_bits_data   (io_master_0_d_bits_data   ),
		.io_master_0_d_bits_error  (io_master_0_d_bits_error  ),
		.io_master_0_e_valid       (io_master_0_e_valid       ),

		.io_slave_0_a_ready        (io_slave_0_a_ready        ),
		.io_slave_0_a_valid        (io_slave_0_a_valid        ),
		.io_slave_0_a_bits_opcode  (io_slave_0_a_bits_opcode  ),
		.io_slave_0_a_bits_param   (io_slave_0_a_bits_param   ),
		.io_slave_0_a_bits_size    (io_slave_0_a_bits_size    ),
		.io_slave_0_a_bits_source  (io_slave_0_a_bits_source  ),
		.io_slave_0_a_bits_address (io_slave_0_a_bits_address ),
		.io_slave_0_a_bits_mask    (io_slave_0_a_bits_mask    ),
		.io_slave_0_a_bits_data    (io_slave_0_a_bits_data    ),
		.io_slave_0_b_valid        (io_slave_0_b_valid        ),
		.io_slave_0_c_valid        (io_slave_0_c_valid        ),
		.io_slave_0_d_ready        (io_slave_0_d_ready        ),
		.io_slave_0_d_valid        (io_slave_0_d_valid        ),
		.io_slave_0_d_bits_opcode  (io_slave_0_d_bits_opcode  ),
		.io_slave_0_d_bits_param   (io_slave_0_d_bits_param   ),
		.io_slave_0_d_bits_size    (io_slave_0_d_bits_size    ),
		.io_slave_0_d_bits_source  (io_slave_0_d_bits_source  ),
		.io_slave_0_d_bits_sink    (io_slave_0_d_bits_sink    ),
		.io_slave_0_d_bits_addr_lo (io_slave_0_d_bits_addr_lo ),
		.io_slave_0_d_bits_data    (io_slave_0_d_bits_data    ),
		.io_slave_0_d_bits_error   (io_slave_0_d_bits_error   ),
		.io_slave_0_e_valid        (io_slave_0_e_valid        ),

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
		.rvfi_halt                 (rvfi_halt                 ),
		.rvfi_intr                 (rvfi_intr                 ),
		.rvfi_valid                (rvfi_valid                )
	);
endmodule

module tilelink_ad_dummy (
	input clock,
	input reset,

	output        channel_a_ready,
	input         channel_a_valid,
	input  [2:0]  channel_a_bits_opcode,
	input  [2:0]  channel_a_bits_param,
	input  [3:0]  channel_a_bits_size,
	input         channel_a_bits_source,
	input  [31:0] channel_a_bits_address,
	input  [3:0]  channel_a_bits_mask,
	input  [31:0] channel_a_bits_data,

	input             channel_d_ready,
	output            channel_d_valid,
	output reg [2:0]  channel_d_bits_opcode,
	output reg [1:0]  channel_d_bits_param,
	output reg [3:0]  channel_d_bits_size,
	output reg        channel_d_bits_source,
	output reg        channel_d_bits_sink,
	output reg [1:0]  channel_d_bits_addr_lo,
	output reg [31:0] channel_d_bits_data,
	output reg        channel_d_bits_error
);
	reg busy, ready, last;
	reg [15:0] count, next_count;

	// -- TL-UL --

	localparam [2:0] opcode_a_get = 4;            // -> opcode_d_accessackdata
	localparam [2:0] opcode_a_putfulldata = 0;    // -> opcode_d_accessack
	localparam [2:0] opcode_a_putpartialdata = 1; // -> opcode_d_accessack

	localparam [2:0] opcode_d_accessackdata = 1;
	localparam [2:0] opcode_d_accessack = 0;

	// -- TL-UH --

	localparam [2:0] opcode_a_arithmeticdata = 2; // -> opcode_d_accessackdata
	localparam [2:0] opcode_a_logicaldata = 3;    // -> opcode_d_accessackdata
	localparam [2:0] opcode_a_intent = 5;         // -> opcode_d_hintack

	localparam [2:0] opcode_d_hintack = 2;

	reg [2:0]  op_opcode;
	reg [2:0]  op_param;
	reg [3:0]  op_size;
	reg        op_source;
	reg [31:0] op_address;
	reg [3:0]  op_mask;
	reg [31:0] op_data;

`ifdef FAST_MEM
	wire delay_a = 0, delay_d = 0;
`else
	wire delay_a = $anyseq, delay_d = $anyseq;
`endif
	assign channel_a_ready = (!busy || (last && channel_d_ready && channel_d_valid)) && !reset && !delay_a;
	assign channel_d_valid = ready && !reset && !delay_d;

	always @* begin
		last = 1;
		ready = 0;
		next_count = count;

		channel_d_bits_opcode = 0;
		channel_d_bits_param = $anyseq;
		channel_d_bits_size = $anyseq;
		channel_d_bits_source = $anyseq;
		channel_d_bits_sink = $anyseq;
		channel_d_bits_addr_lo = $anyseq;
		channel_d_bits_data = $anyseq;
		channel_d_bits_error = 1;

		if (busy) begin
			if (op_opcode == opcode_a_get) begin
				channel_d_bits_opcode = opcode_d_accessackdata;
				channel_d_bits_param = 0;
				channel_d_bits_size = op_size;
				channel_d_bits_source = op_source;
				channel_d_bits_addr_lo = op_address;
				channel_d_bits_error = 0;
				next_count = count + 4;
				last = next_count >= (1 << op_size);
				ready = 1;
			end

			// TBD: opcode_a_putfulldata
			// TBD: opcode_a_putpartialdata
			// TBD: opcode_a_arithmeticdata
			// TBD: opcode_a_logicaldata
			// TBD: opcode_a_intent
		end
	end

	always @(posedge clock) begin
		if (reset) begin
			busy <= 0;
		end else begin
			if (channel_d_ready && channel_d_valid) begin
				if (last)
					busy <= 0;
				else
					count <= next_count;
			end

			if (channel_a_ready && channel_a_valid) begin
				op_opcode <= channel_a_bits_opcode;
				op_param <= channel_a_bits_param;
				op_size <= channel_a_bits_size;
				op_source <= channel_a_bits_source;
				op_address <= channel_a_bits_address;
				op_mask <= channel_a_bits_mask;
				op_data <= channel_a_bits_data;
				busy <= 1;
				count <= 0;
			end
		end
	end
endmodule

