`define XLEN_BYTES (`RISCV_FORMAL_XLEN == 32 ? 4 : 8)

module rvfi_wrapper (
	input         clock,
	input         reset,
	`RVFI_OUTPUTS
);
`ifdef ROCKET_NORESET
	wire actual_reset = 0;
`else
	reg [3:0] reset_cnt = 0;
	wire actual_reset = reset || |reset_cnt;

	always @(posedge clock) begin
		reset_cnt <= reset ? 4'd 5 : reset_cnt - |reset_cnt;
	end
`endif

	(* keep *) wire  [31:0] reset_vector = 32'h10040;

	// Rocket TileLink Slave

	(* keep *) wire        tl_slave_a_ready;
	(* keep *) wire        tl_slave_a_valid = 0;
	(* keep *) wire [2:0]  tl_slave_a_bits_opcode = 0;
	(* keep *) wire [2:0]  tl_slave_a_bits_param = 0;
	(* keep *) wire [2:0]  tl_slave_a_bits_size = 0;
	(* keep *) wire [4:0]  tl_slave_a_bits_source = 0;
	(* keep *) wire [31:0] tl_slave_a_bits_address = 0;
	(* keep *) wire [7:0]  tl_slave_a_bits_mask = 0;
	(* keep *) wire [63:0] tl_slave_a_bits_data = 0;

	(* keep *) wire        tl_slave_d_ready = 0;
	(* keep *) wire        tl_slave_d_valid;
	(* keep *) wire [2:0]  tl_slave_d_bits_opcode;
	(* keep *) wire [1:0]  tl_slave_d_bits_param;
	(* keep *) wire [2:0]  tl_slave_d_bits_size;
	(* keep *) wire [4:0]  tl_slave_d_bits_source;
	(* keep *) wire        tl_slave_d_bits_sink;
	(* keep *) wire        tl_slave_d_bits_denied;
	(* keep *) wire [63:0] tl_slave_d_bits_data;
	(* keep *) wire        tl_slave_d_bits_corrupt;

	// Rocket TileLink Master

	(* keep *) wire        tl_master_a_ready;
	(* keep *) wire        tl_master_a_valid;
	(* keep *) wire [2:0]  tl_master_a_bits_opcode;
	(* keep *) wire [2:0]  tl_master_a_bits_param;
	(* keep *) wire [3:0]  tl_master_a_bits_size;
	(* keep *) wire        tl_master_a_bits_source;
	(* keep *) wire [31:0] tl_master_a_bits_address;
	(* keep *) wire [7:0]  tl_master_a_bits_mask;
	(* keep *) wire [63:0] tl_master_a_bits_data;
	(* keep *) wire        tl_master_a_bits_corrupt;

	(* keep *) wire        tl_master_d_ready;
	(* keep *) wire        tl_master_d_valid;
	(* keep *) wire [2:0]  tl_master_d_bits_opcode;
	(* keep *) wire [1:0]  tl_master_d_bits_param;
	(* keep *) wire [3:0]  tl_master_d_bits_size;
	(* keep *) wire        tl_master_d_bits_source;
	(* keep *) wire        tl_master_d_bits_sink;
	(* keep *) wire        tl_master_d_bits_denied;
	(* keep *) wire [63:0] tl_master_d_bits_data;
	(* keep *) wire        tl_master_d_bits_corrupt;

	// TileLink Master A-D Dummy Slave

	tilelink_ad_dummy tilelink_slave (
		.clock                  (clock                   ),
		.reset                  (actual_reset            ),

		.channel_a_ready        (tl_master_a_ready       ),
		.channel_a_valid        (tl_master_a_valid       ),
		.channel_a_bits_address (tl_master_a_bits_address),
		.channel_a_bits_data    (tl_master_a_bits_data   ),
		.channel_a_bits_mask    (tl_master_a_bits_mask   ),
		.channel_a_bits_opcode  (tl_master_a_bits_opcode ),
		.channel_a_bits_param   (tl_master_a_bits_param  ),
		.channel_a_bits_size    (tl_master_a_bits_size   ),
		.channel_a_bits_source  (tl_master_a_bits_source ),

		.channel_d_ready        (tl_master_d_ready       ),
		.channel_d_valid        (tl_master_d_valid       ),
		.channel_d_bits_data    (tl_master_d_bits_data   ),
		.channel_d_bits_denied  (tl_master_d_bits_denied ),
		.channel_d_bits_corrupt (tl_master_d_bits_corrupt),
		.channel_d_bits_opcode  (tl_master_d_bits_opcode ),
		.channel_d_bits_param   (tl_master_d_bits_param  ),
		.channel_d_bits_sink    (tl_master_d_bits_sink   ),
		.channel_d_bits_size    (tl_master_d_bits_size   ),
		.channel_d_bits_source  (tl_master_d_bits_source )
	);

	// Rocket Tile

	RocketTileWithRVFI rocket_rvfi_tile (
		.clock                  (clock                    ),
		.reset                  (actual_reset             ),

		`RVFI_CONN,

		.intsink_sync_0          (1'b0                    ),
		.int_1_sync_0            (1'b0                    ),
		.int_0_sync_0            (1'b0                    ),
		.int_0_sync_1            (1'b0                    ),

		.tl_slave_a_ready        (tl_slave_a_ready        ),
		.tl_slave_a_valid        (tl_slave_a_valid        ),
		.tl_slave_a_bits_opcode  (tl_slave_a_bits_opcode  ),
		.tl_slave_a_bits_param   (tl_slave_a_bits_param   ),
		.tl_slave_a_bits_size    (tl_slave_a_bits_size    ),
		.tl_slave_a_bits_source  (tl_slave_a_bits_source  ),
		.tl_slave_a_bits_address (tl_slave_a_bits_address ),
		.tl_slave_a_bits_mask    (tl_slave_a_bits_mask    ),
		.tl_slave_a_bits_data    (tl_slave_a_bits_data    ),
		.tl_slave_d_ready        (tl_slave_d_ready        ),
		.tl_slave_d_valid        (tl_slave_d_valid        ),
		.tl_slave_d_bits_opcode  (tl_slave_d_bits_opcode  ),
		.tl_slave_d_bits_param   (tl_slave_d_bits_param   ),
		.tl_slave_d_bits_size    (tl_slave_d_bits_size    ),
		.tl_slave_d_bits_source  (tl_slave_d_bits_source  ),
		.tl_slave_d_bits_sink    (tl_slave_d_bits_sink    ),
		.tl_slave_d_bits_denied  (tl_slave_d_bits_denied  ),
		.tl_slave_d_bits_data    (tl_slave_d_bits_data    ),
		.tl_slave_d_bits_corrupt (tl_slave_d_bits_corrupt ),

		.tl_master_a_ready       (tl_master_a_ready       ),
		.tl_master_a_valid       (tl_master_a_valid       ),
		.tl_master_a_bits_opcode (tl_master_a_bits_opcode ),
		.tl_master_a_bits_param  (tl_master_a_bits_param  ),
		.tl_master_a_bits_size   (tl_master_a_bits_size   ),
		.tl_master_a_bits_source (tl_master_a_bits_source ),
		.tl_master_a_bits_address(tl_master_a_bits_address),
		.tl_master_a_bits_mask   (tl_master_a_bits_mask   ),
		.tl_master_a_bits_data   (tl_master_a_bits_data   ),
		.tl_master_a_bits_corrupt(tl_master_a_bits_corrupt),
		.tl_master_d_ready       (tl_master_d_ready       ),
		.tl_master_d_valid       (tl_master_d_valid       ),
		.tl_master_d_bits_opcode (tl_master_d_bits_opcode ),
		.tl_master_d_bits_param  (tl_master_d_bits_param  ),
		.tl_master_d_bits_size   (tl_master_d_bits_size   ),
		.tl_master_d_bits_source (tl_master_d_bits_source ),
		.tl_master_d_bits_sink   (tl_master_d_bits_sink   ),
		.tl_master_d_bits_denied (tl_master_d_bits_denied ),
		.tl_master_d_bits_data   (tl_master_d_bits_data   ),
		.tl_master_d_bits_corrupt(tl_master_d_bits_corrupt)
	);

	(* keep *) rvfi_channel #(.CHANNEL_IDX(0)) rvfi_channel_0 (`RVFI_CONN);
	(* keep *) rvfi_channel #(.CHANNEL_IDX(1)) rvfi_channel_1 (`RVFI_CONN);
endmodule

module rocket_pma_map (
	input [`RISCV_FORMAL_XLEN-1:0] address,
	input [1:0] log2len,
	output reg A, R, W, X, C
);
	reg [4:0] modes_first, modes_last;
	wire [`RISCV_FORMAL_XLEN-1:0] address_first = address;
	wire [`RISCV_FORMAL_XLEN-1:0] address_last = address + (1 << log2len) - 1;

	always @* begin
		// Generated Address Map
		//         0 -     1000 ARWX  debug-controller@0
		//      3000 -     4000 ARWX  error-device@3000
		//     10000 -    20000  R XC rom@10000
		//   2000000 -  2010000 ARW   clint@2000000
		//   c000000 - 10000000 ARW   interrupt-controller@c000000
		//  60000000 - 80000000  RWX  mmio@60000000
		//  80000000 - 80004000 ARWX  dtim@80000000

		modes_first = 5'b 00000;
		// if (64'h 00000000 <= address_first && address_first < 64'h 00001000) modes_first = 5'b 11110;
		if (64'h 00003000 <= address_first && address_first < 64'h 00004000) modes_first = 5'b 11110;
		if (64'h 00010000 <= address_first && address_first < 64'h 00020000) modes_first = 5'b 01010;
		if (64'h 02000000 <= address_first && address_first < 64'h 02010000) modes_first = 5'b 11100;
		if (64'h 0c000000 <= address_first && address_first < 64'h 10000000) modes_first = 5'b 11100;
		if (64'h 60000000 <= address_first && address_first < 64'h 80000000) modes_first = 5'b 01110;
		if (64'h 80000000 <= address_first && address_first < 64'h 80004000) modes_first = 5'b 11110;

		modes_last = 5'b 00000;
		// if (64'h 00000000 <= address_last && address_last < 64'h 00001000) modes_last = 5'b 11110;
		if (64'h 00003000 <= address_last && address_last < 64'h 00004000) modes_last = 5'b 11110;
		if (64'h 00010000 <= address_last && address_last < 64'h 00020000) modes_last = 5'b 01010;
		if (64'h 02000000 <= address_last && address_last < 64'h 02010000) modes_last = 5'b 11100;
		if (64'h 0c000000 <= address_last && address_last < 64'h 10000000) modes_last = 5'b 11100;
		if (64'h 60000000 <= address_last && address_last < 64'h 80000000) modes_last = 5'b 01110;
		if (64'h 80000000 <= address_last && address_last < 64'h 80004000) modes_last = 5'b 11110;

		{A, R, W, X, C} = modes_first & modes_last;

		if (log2len == 1 && address[0:0]) {A, R, W, C} = 0;
		if (log2len == 2 && address[1:0]) {A, R, W, C} = 0;
		if (log2len == 3 && address[2:0]) {A, R, W, C} = 0;
	end
endmodule

module tilelink_ad_dummy (
	input clock,
	input reset,

	output                          channel_a_ready,
	input                           channel_a_valid,
	input  [                   2:0] channel_a_bits_opcode,
	input  [                   2:0] channel_a_bits_param,
	input  [                   3:0] channel_a_bits_size,
	input                           channel_a_bits_source,
	input  [                  31:0] channel_a_bits_address,
	input  [       `XLEN_BYTES-1:0] channel_a_bits_mask,
	input  [`RISCV_FORMAL_XLEN-1:0] channel_a_bits_data,

	input                               channel_d_ready,
	output                              channel_d_valid,
	output reg [                   2:0] channel_d_bits_opcode,
	output reg [                   1:0] channel_d_bits_param,
	output reg [                   3:0] channel_d_bits_size,
	output reg                          channel_d_bits_source,
	output reg                          channel_d_bits_sink,
	output reg [`RISCV_FORMAL_XLEN-1:0] channel_d_bits_data,
	output reg                          channel_d_bits_denied,
	output reg                          channel_d_bits_corrupt
);
	reg busy = 0, ready, last;
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

	reg [                   2:0] op_opcode;
	reg [                   2:0] op_param;
	reg [                   3:0] op_size;
	reg                          op_source;
	reg [`RISCV_FORMAL_XLEN-1:0] op_address;
	reg [       `XLEN_BYTES-1:0] op_mask;
	reg [`RISCV_FORMAL_XLEN-1:0] op_data;

`ifdef ROCKET_INIT
	integer cycle = 0;
	always @(posedge clock) cycle <= cycle+1;

  `ifdef ROCKET_INITHACK
	wire delay_a = 0, delay_d = 0;
  `else
	wire delay_a = 1, delay_d = 1;
  `endif

	wire [                   2:0] channel_d_bits_opcode_nd  = 0;
	wire [                   1:0] channel_d_bits_param_nd   = 0;
	wire [                   3:0] channel_d_bits_size_nd    = 0;
	wire                          channel_d_bits_source_nd  = 0;
	wire                          channel_d_bits_sink_nd    = 0;
	wire [`RISCV_FORMAL_XLEN-1:0] channel_d_bits_data_nd    = op_address > 32'h 0001_0100 && cycle > 250 ? 64'h_f05ff06f_f05ff06f : 64'h_00000013_00000013;
	wire                          channel_d_bits_denied_nd  = 0;
	wire                          channel_d_bits_corrupt_nd = 0;
`else
	`rvformal_rand_reg delay_a_nd;
	`rvformal_rand_reg delay_d_nd;

  `ifdef RISCV_FORMAL_FAIRNESS
	wire delay_a = 0, delay_d = 0;
  `else
	wire delay_a = delay_a_nd, delay_d = delay_d_nd;
  `endif

	`rvformal_rand_reg [                   2:0] channel_d_bits_opcode_nd;
	`rvformal_rand_reg [                   1:0] channel_d_bits_param_nd;
	`rvformal_rand_reg [                   3:0] channel_d_bits_size_nd;
	`rvformal_rand_reg                          channel_d_bits_source_nd;
	`rvformal_rand_reg                          channel_d_bits_sink_nd;
	`rvformal_rand_reg [`RISCV_FORMAL_XLEN-1:0] channel_d_bits_data_nd;
	`rvformal_rand_reg                          channel_d_bits_denied_nd;
	`rvformal_rand_reg                          channel_d_bits_corrupt_nd;
`endif

	assign channel_a_ready = (!busy || (last && channel_d_ready && channel_d_valid)) && !reset && !delay_a;
	assign channel_d_valid = ready && !reset && !delay_d;

	always @* begin
		last = 1;
		ready = 0;
		next_count = count;

		channel_d_bits_opcode = 0; // channel_d_bits_opcode_nd
		channel_d_bits_param = channel_d_bits_param_nd;
		channel_d_bits_size = channel_d_bits_size_nd;
		channel_d_bits_source = channel_d_bits_source_nd;
		channel_d_bits_sink = channel_d_bits_sink_nd;
		channel_d_bits_data = channel_d_bits_data_nd;
		channel_d_bits_denied = 1; // channel_d_bits_denied_nd
		channel_d_bits_corrupt = 1; // channel_d_bits_corrupt_nd

		if (busy) begin
			if (op_opcode == opcode_a_get) begin
				channel_d_bits_opcode = opcode_d_accessackdata;
				channel_d_bits_param = 0;
				channel_d_bits_size = op_size;
				channel_d_bits_source = op_source;
				channel_d_bits_denied = 0;
				channel_d_bits_corrupt = 0;
				next_count = (count + (`RISCV_FORMAL_XLEN / 8)) & 16'hffff;
				last = next_count >= (1 << op_size);
				ready = 1;
			end

			if (op_opcode == opcode_a_putfulldata) begin
				channel_d_bits_opcode = opcode_d_accessack;
				channel_d_bits_param = 0;
				channel_d_bits_size = op_size;
				channel_d_bits_source = op_source;
				channel_d_bits_denied = 0;
				channel_d_bits_corrupt = 0;
				last = 1;
				ready = 1;
			end

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

`ifndef ROCKET_INIT
module MulDiv (
	input         clock,
	input         reset,
	output        io__req_ready,
	input         io__req_valid,
	input  [ 3:0] io__req_bits_fn,
	input         io__req_bits_dw,
	input  [63:0] io__req_bits_in1,
	input  [63:0] io__req_bits_in2,
	input  [ 4:0] io__req_bits_tag,
	input         io__kill,
	input         io__resp_ready,
	output        io__resp_valid,
	output [63:0] io__resp_bits_data,
	output [ 4:0] io__resp_bits_tag,
	output        io_resp_valid,
	output        io_resp_ready
);
	reg [63:0] internal_data;
	reg [ 4:0] internal_tag;
	reg        internal_busy = 0;
	reg        internal_done = 0;

	reg [63:0] result;

	always @* begin
		result = 123456789;
		case (io__req_bits_fn)
			0: result = (io__req_bits_in1 + io__req_bits_in2) ^ 64'h 2cdf52a55876063e; // MUL
			1: result = (io__req_bits_in1 + io__req_bits_in2) ^ 64'h 15d01651f6583fb7; // MULH
			2: result = (io__req_bits_in1 - io__req_bits_in2) ^ 64'h ea3969edecfbe137; // MULHSU
			3: result = (io__req_bits_in1 + io__req_bits_in2) ^ 64'h d13db50d949ce5e8; // MULHU
			4: result = (io__req_bits_in1 - io__req_bits_in2) ^ 64'h 29bbf66f7f8529ec; // DIV
			5: result = (io__req_bits_in1 - io__req_bits_in2) ^ 64'h 8c629acb10e8fd70; // DIVU
			6: result = (io__req_bits_in1 - io__req_bits_in2) ^ 64'h f5b7d8538da68fa5; // REM
			7: result = (io__req_bits_in1 - io__req_bits_in2) ^ 64'h bc4402413138d0e1; // REMU
		endcase
		if (!io__req_bits_dw) begin
			result = $signed(result << 32) >>> 32;
		end
	end

`ifdef RISCV_FORMAL_FAIRNESS
	assign io__req_ready = !internal_busy;
`else
	assign io__req_ready = $anyseq(1) && !internal_busy;
`endif

	assign io__resp_valid = internal_done;
	assign io__resp_bits_data = internal_done ? internal_data : $anyseq(64);
	assign io__resp_bits_tag = internal_done ? internal_tag : $anyseq(5);

	assign io_resp_valid = io__resp_valid;
	assign io_resp_ready = io__resp_ready;

	always @(posedge clock) begin
		if (reset || io__kill) begin
			internal_busy <= 0;
			internal_done <= 0;
		end else begin
			if (io__req_ready && io__req_valid) begin
				internal_data <= result;
				internal_tag <= io__req_bits_tag;
				internal_busy <= 1;
			end

`ifdef RISCV_FORMAL_FAIRNESS
			if (internal_busy) begin
				internal_done <= 1;
			end
`else
			if (internal_busy && $anyseq(1)) begin
				internal_done <= 1;
			end
`endif

			if (io__resp_ready && io__resp_valid) begin
				internal_busy <= 0;
				internal_done <= 0;
			end
		end
	end

	reg [2:0] done_cnt = 0;

	always @(posedge clock) begin
		done_cnt <= done_cnt + |{done_cnt, internal_done};
		// cover(done_cnt == 7);
	end
endmodule
`endif
