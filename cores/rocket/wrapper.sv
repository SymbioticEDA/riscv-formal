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
		reset_cnt <= reset ? 5 : reset_cnt - |reset_cnt;
	end
`endif

	// Rocket Tile Inputs

	(* keep *) wire                           io_master_0_a_ready;
	(* keep *) wire                           io_master_0_d_valid;
	(* keep *) wire  [                   2:0] io_master_0_d_bits_opcode;
	(* keep *) wire  [                   1:0] io_master_0_d_bits_param;
	(* keep *) wire  [                   3:0] io_master_0_d_bits_size;
	(* keep *) wire                           io_master_0_d_bits_source;
	(* keep *) wire                           io_master_0_d_bits_sink;
	(* keep *) wire  [`RISCV_FORMAL_XLEN-1:0] io_master_0_d_bits_data;
	(* keep *) wire                           io_master_0_d_bits_error;

	(* keep *) wire                           io_slave_0_a_valid = 0;
	(* keep *) wire  [                   2:0] io_slave_0_a_bits_opcode = 0;
	(* keep *) wire  [                   2:0] io_slave_0_a_bits_param = 0;
	(* keep *) wire  [                   2:0] io_slave_0_a_bits_size = 0;
	(* keep *) wire  [                   4:0] io_slave_0_a_bits_source = 0;
	(* keep *) wire  [                  31:0] io_slave_0_a_bits_address = 0;
	(* keep *) wire  [       `XLEN_BYTES-1:0] io_slave_0_a_bits_mask = 0;
	(* keep *) wire  [`RISCV_FORMAL_XLEN-1:0] io_slave_0_a_bits_data = 0;
	(* keep *) wire                           io_slave_0_d_ready = 0;

	// Rocket Tile Outputs

	(* keep *) wire                          io_master_0_a_valid;
	(* keep *) wire [                   2:0] io_master_0_a_bits_opcode;
	(* keep *) wire [                   2:0] io_master_0_a_bits_param;
	(* keep *) wire [                   3:0] io_master_0_a_bits_size;
	(* keep *) wire                          io_master_0_a_bits_source;
	(* keep *) wire [                  31:0] io_master_0_a_bits_address;
	(* keep *) wire [       `XLEN_BYTES-1:0] io_master_0_a_bits_mask;
	(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] io_master_0_a_bits_data;
	(* keep *) wire                          io_master_0_d_ready;

	(* keep *) wire                          io_slave_0_a_ready;
	(* keep *) wire                          io_slave_0_d_valid;
	(* keep *) wire [                   2:0] io_slave_0_d_bits_opcode;
	(* keep *) wire [                   1:0] io_slave_0_d_bits_param;
	(* keep *) wire [                   2:0] io_slave_0_d_bits_size;
	(* keep *) wire [                   4:0] io_slave_0_d_bits_source;
	(* keep *) wire                          io_slave_0_d_bits_sink;
	(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] io_slave_0_d_bits_data;
	(* keep *) wire                          io_slave_0_d_bits_error;

`ifdef ROCKET_INIT
	assign io_master_0_a_ready = 0;
	assign io_master_0_d_valid = 0;
	assign io_master_0_d_bits_opcode = 0;
	assign io_master_0_d_bits_param = 0;
	assign io_master_0_d_bits_size = 0;
	assign io_master_0_d_bits_source = 0;
	assign io_master_0_d_bits_sink = 0;
	assign io_master_0_d_bits_data = 0;
	assign io_master_0_d_bits_error = 0;
`else
	// TileLink A-D Dummy Slave

`ifndef NO_TL_AD_DUMMY
	tilelink_ad_dummy TL_AD_DUMMY (
		.clock                  (clock                     ),
		.reset                  (actual_reset              ),

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
		.channel_d_bits_data    (io_master_0_d_bits_data   ),
		.channel_d_bits_error   (io_master_0_d_bits_error  ),
		.channel_d_bits_opcode  (io_master_0_d_bits_opcode ),
		.channel_d_bits_param   (io_master_0_d_bits_param  ),
		.channel_d_bits_sink    (io_master_0_d_bits_sink   ),
		.channel_d_bits_size    (io_master_0_d_bits_size   ),
		.channel_d_bits_source  (io_master_0_d_bits_source )
	);
`endif
`endif

	// Rocket Tile

	RocketTile_tile uut (
		.clock (clock       ),
		.reset (actual_reset),

`ifndef ROCKET_HIER_REF
		`RVFI_CONN,
`endif

		.auto_anon_in_3_sync_0 (1'b0),
		.auto_anon_in_2_sync_0 (1'b0),
		.auto_anon_in_2_sync_1 (1'b0),
		.auto_anon_in_1_sync_0 (1'b0),

		.auto_anon_out_a_ready        (io_master_0_a_ready       ),
		.auto_anon_out_a_valid        (io_master_0_a_valid       ),
		.auto_anon_out_a_bits_opcode  (io_master_0_a_bits_opcode ),
		.auto_anon_out_a_bits_param   (io_master_0_a_bits_param  ),
		.auto_anon_out_a_bits_size    (io_master_0_a_bits_size   ),
		.auto_anon_out_a_bits_source  (io_master_0_a_bits_source ),
		.auto_anon_out_a_bits_address (io_master_0_a_bits_address),
		.auto_anon_out_a_bits_mask    (io_master_0_a_bits_mask   ),
		.auto_anon_out_a_bits_data    (io_master_0_a_bits_data   ),

		.auto_anon_out_d_ready        (io_master_0_d_ready       ),
		.auto_anon_out_d_valid        (io_master_0_d_valid       ),
		.auto_anon_out_d_bits_opcode  (io_master_0_d_bits_opcode ),
		.auto_anon_out_d_bits_param   (io_master_0_d_bits_param  ),
		.auto_anon_out_d_bits_size    (io_master_0_d_bits_size   ),
		.auto_anon_out_d_bits_source  (io_master_0_d_bits_source ),
		.auto_anon_out_d_bits_sink    (io_master_0_d_bits_sink   ),
		.auto_anon_out_d_bits_data    (io_master_0_d_bits_data   ),
		.auto_anon_out_d_bits_error   (io_master_0_d_bits_error  ),

		.auto_anon_in_0_a_ready          (io_slave_0_a_ready        ),
		.auto_anon_in_0_a_valid          (io_slave_0_a_valid        ),
		.auto_anon_in_0_a_bits_opcode    (io_slave_0_a_bits_opcode  ),
		.auto_anon_in_0_a_bits_param     (io_slave_0_a_bits_param   ),
		.auto_anon_in_0_a_bits_size      (io_slave_0_a_bits_size    ),
		.auto_anon_in_0_a_bits_source    (io_slave_0_a_bits_source  ),
		.auto_anon_in_0_a_bits_address   (io_slave_0_a_bits_address ),
		.auto_anon_in_0_a_bits_mask      (io_slave_0_a_bits_mask    ),
		.auto_anon_in_0_a_bits_data      (io_slave_0_a_bits_data    ),

		.auto_anon_in_0_d_ready          (io_slave_0_d_ready        ),
		.auto_anon_in_0_d_valid          (io_slave_0_d_valid        ),
		.auto_anon_in_0_d_bits_opcode    (io_slave_0_d_bits_opcode  ),
		.auto_anon_in_0_d_bits_param     (io_slave_0_d_bits_param   ),
		.auto_anon_in_0_d_bits_size      (io_slave_0_d_bits_size    ),
		.auto_anon_in_0_d_bits_source    (io_slave_0_d_bits_source  ),
		.auto_anon_in_0_d_bits_sink      (io_slave_0_d_bits_sink    ),
		.auto_anon_in_0_d_bits_data      (io_slave_0_d_bits_data    ),
		.auto_anon_in_0_d_bits_error     (io_slave_0_d_bits_error   )
	);

`ifdef ROCKET_HIER_REF
	assign rvfi_insn = uut.core.rvfi_mon.rvfi_insn;
	assign rvfi_mem_addr = uut.core.rvfi_mon.rvfi_mem_addr;
	assign rvfi_mem_rdata = uut.core.rvfi_mon.rvfi_mem_rdata;
	assign rvfi_mem_rmask = uut.core.rvfi_mon.rvfi_mem_rmask;
	assign rvfi_mem_wdata = uut.core.rvfi_mon.rvfi_mem_wdata;
	assign rvfi_mem_wmask = uut.core.rvfi_mon.rvfi_mem_wmask;
	assign rvfi_order = uut.core.rvfi_mon.rvfi_order;
	assign rvfi_pc_rdata = uut.core.rvfi_mon.rvfi_pc_rdata;
	assign rvfi_pc_wdata = uut.core.rvfi_mon.rvfi_pc_wdata;
	assign rvfi_rd_addr = uut.core.rvfi_mon.rvfi_rd_addr;
	assign rvfi_rd_wdata = uut.core.rvfi_mon.rvfi_rd_wdata;
	assign rvfi_rs1_addr = uut.core.rvfi_mon.rvfi_rs1_addr;
	assign rvfi_rs1_rdata = uut.core.rvfi_mon.rvfi_rs1_rdata;
	assign rvfi_rs2_addr = uut.core.rvfi_mon.rvfi_rs2_addr;
	assign rvfi_rs2_rdata = uut.core.rvfi_mon.rvfi_rs2_rdata;
	assign rvfi_trap = uut.core.rvfi_mon.rvfi_trap;
	assign rvfi_halt = uut.core.rvfi_mon.rvfi_halt;
	assign rvfi_intr = uut.core.rvfi_mon.rvfi_intr;
	assign rvfi_valid = uut.core.rvfi_mon.rvfi_valid;
`endif

`ifdef NO_LDX0
	always @* begin
		if (rvfi_valid[0] && rvfi_insn[6:0] == 7'b0000011) begin
			assume (rvfi_insn[11:7] != 0);
		end
		if (rvfi_valid[1] && rvfi_insn[38:32] == 7'b0000011) begin
			assume (rvfi_insn[43:39] != 0);
		end
	end
`endif

`ifdef NO_MISA
	always @* begin
		if (rvfi_valid[0] && rvfi_insn[13:12] && rvfi_insn[6:0] == 7'b1110011) begin
			assume (rvfi_insn[31:20] != 12'h301);
		end
		if (rvfi_valid[1] && rvfi_insn[45:44] && rvfi_insn[38:32] == 7'b1110011) begin
			assume (rvfi_insn[63:52] != 12'h301);
		end
	end
`endif

`ifdef NO_UNALIGNED_MISA
	always @* begin
		if (rvfi_valid[0] && rvfi_insn[13:12] && rvfi_insn[6:0] == 7'b1110011) begin
			assume (rvfi_insn[31:20] != 12'h301 || rvfi_pc_rdata[0 +: 2] == 0);
		end
		if (rvfi_valid[1] && rvfi_insn[45:44] && rvfi_insn[38:32] == 7'b1110011) begin
			assume (rvfi_insn[63:52] != 12'h301 || rvfi_pc_rdata[`RISCV_FORMAL_XLEN +: 2] == 0);
		end
	end
`endif

`ifdef NO_SYSTEM
	wire riscv_rv32i_valid_ch0;
	wire riscv_rv32i_valid_ch1;

	riscv_rv32i_insn riscv_rv32i_insn_ch0 (
		.insn(rvfi_insn[31:0]),
		.valid(riscv_rv32i_valid_ch0)
	);

	riscv_rv32i_insn riscv_rv32i_insn_ch1 (
		.insn(rvfi_insn[63:32]),
		.valid(riscv_rv32i_valid_ch1)
	);

	always @* begin
		if (rvfi_valid[0]) begin
			assume (!rvfi_trap[0]);
			assume (!rvfi_halt[0]);
			assume (!rvfi_intr[0]);
			assume (rvfi_insn[6:0] != 7'b1110011); // no SYSTEM instructions
			assume (riscv_rv32i_valid_ch0); // no illegal instructions
		end
		if (rvfi_valid[1]) begin
			assume (!rvfi_trap[1]);
			assume (!rvfi_halt[1]);
			assume (!rvfi_intr[1]);
			assume (rvfi_insn[38:32] != 7'b1110011); // no SYSTEM instructions
			assume (riscv_rv32i_valid_ch1); // no illegal instructions
		end
	end
`endif

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
		if (64'h 00000000 <= address_first && address_first < 64'h 00001000) modes_first = 5'b 11110;
		if (64'h 00003000 <= address_first && address_first < 64'h 00004000) modes_first = 5'b 11110;
		if (64'h 00010000 <= address_first && address_first < 64'h 00020000) modes_first = 5'b 01010;
		if (64'h 02000000 <= address_first && address_first < 64'h 02010000) modes_first = 5'b 11100;
		if (64'h 0c000000 <= address_first && address_first < 64'h 10000000) modes_first = 5'b 11100;
		if (64'h 60000000 <= address_first && address_first < 64'h 80000000) modes_first = 5'b 01110;
		if (64'h 80000000 <= address_first && address_first < 64'h 80004000) modes_first = 5'b 11110;

		modes_last = 5'b 00000;
		if (64'h 00000000 <= address_last && address_last < 64'h 00001000) modes_last = 5'b 11110;
		if (64'h 00003000 <= address_last && address_last < 64'h 00004000) modes_last = 5'b 11110;
		if (64'h 00010000 <= address_last && address_last < 64'h 00020000) modes_last = 5'b 01010;
		if (64'h 02000000 <= address_last && address_last < 64'h 02010000) modes_last = 5'b 11100;
		if (64'h 0c000000 <= address_last && address_last < 64'h 10000000) modes_last = 5'b 11100;
		if (64'h 60000000 <= address_last && address_last < 64'h 80000000) modes_last = 5'b 01110;
		if (64'h 80000000 <= address_last && address_last < 64'h 80004000) modes_last = 5'b 11110;

		{A, R, W, X, C} = modes_first & modes_last;
	end
endmodule

`ifndef ROCKET_INIT
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
	output reg                          channel_d_bits_error
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

	`rvformal_rand_reg delay_a_nd;
	`rvformal_rand_reg delay_d_nd;

	`rvformal_rand_reg [                   2:0] channel_d_bits_opcode_nd;
	`rvformal_rand_reg [                   1:0] channel_d_bits_param_nd;
	`rvformal_rand_reg [                   3:0] channel_d_bits_size_nd;
	`rvformal_rand_reg                          channel_d_bits_source_nd;
	`rvformal_rand_reg                          channel_d_bits_sink_nd;
	`rvformal_rand_reg [`RISCV_FORMAL_XLEN-1:0] channel_d_bits_data_nd;
	`rvformal_rand_reg                          channel_d_bits_error_nd;

`ifdef FAST_MEM
	wire delay_a = 0, delay_d = 0;
`else
	wire delay_a = delay_a_nd, delay_d = delay_d_nd;
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
		channel_d_bits_error = 1; // channel_d_bits_error_nd

		if (busy) begin
			if (op_opcode == opcode_a_get) begin
				channel_d_bits_opcode = opcode_d_accessackdata;
				channel_d_bits_param = 0;
				channel_d_bits_size = op_size;
				channel_d_bits_source = op_source;
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
`endif

`ifdef ROCKET_HIER_REF
module RVFIMonitor (
	input clock,
	input reset,
	`RVFI_INPUTS,
	output errcode
);
	assign errcode = 0;
endmodule
`endif
