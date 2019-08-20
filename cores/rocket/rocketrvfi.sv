module RocketTileWithRVFI (
	input         clock,
	input         reset,
	`RVFI_OUTPUTS,

	input         intsink_sync_0,
	input         int_1_sync_0,
	input         int_0_sync_0,
	input         int_0_sync_1,

	output        tl_slave_a_ready,
	input         tl_slave_a_valid,
	input  [2:0]  tl_slave_a_bits_opcode,
	input  [2:0]  tl_slave_a_bits_param,
	input  [2:0]  tl_slave_a_bits_size,
	input  [4:0]  tl_slave_a_bits_source,
	input  [31:0] tl_slave_a_bits_address,
	input  [7:0]  tl_slave_a_bits_mask,
	input  [63:0] tl_slave_a_bits_data,
	input         tl_slave_d_ready,
	output        tl_slave_d_valid,
	output [2:0]  tl_slave_d_bits_opcode,
	output [1:0]  tl_slave_d_bits_param,
	output [2:0]  tl_slave_d_bits_size,
	output [4:0]  tl_slave_d_bits_source,
	output        tl_slave_d_bits_sink,
	output        tl_slave_d_bits_denied,
	output [63:0] tl_slave_d_bits_data,
	output        tl_slave_d_bits_corrupt,

	input         tl_master_a_ready,
	output        tl_master_a_valid,
	output [2:0]  tl_master_a_bits_opcode,
	output [2:0]  tl_master_a_bits_param,
	output [3:0]  tl_master_a_bits_size,
	output        tl_master_a_bits_source,
	output [31:0] tl_master_a_bits_address,
	output [7:0]  tl_master_a_bits_mask,
	output [63:0] tl_master_a_bits_data,
	output        tl_master_a_bits_corrupt,
	output        tl_master_d_ready,
	input         tl_master_d_valid,
	input  [2:0]  tl_master_d_bits_opcode,
	input  [1:0]  tl_master_d_bits_param,
	input  [3:0]  tl_master_d_bits_size,
	input         tl_master_d_bits_source,
	input         tl_master_d_bits_sink,
	input         tl_master_d_bits_denied,
	input  [63:0] tl_master_d_bits_data,
	input         tl_master_d_bits_corrupt
);
	RocketTile rocket_tile (
		.clock                                  (clock                    ),
		.reset                                  (reset                    ),

		.auto_intsink_in_sync_0                 (intsink_sync_0           ),
		.auto_int_in_xing_in_1_sync_0           (int_1_sync_0             ),
		.auto_int_in_xing_in_0_sync_0           (int_0_sync_0             ),
		.auto_int_in_xing_in_0_sync_1           (int_0_sync_1             ),

		.auto_tl_slave_xing_in_a_ready          (tl_slave_a_ready         ),
		.auto_tl_slave_xing_in_a_valid          (tl_slave_a_valid         ),
		.auto_tl_slave_xing_in_a_bits_opcode    (tl_slave_a_bits_opcode   ),
		.auto_tl_slave_xing_in_a_bits_param     (tl_slave_a_bits_param    ),
		.auto_tl_slave_xing_in_a_bits_size      (tl_slave_a_bits_size     ),
		.auto_tl_slave_xing_in_a_bits_source    (tl_slave_a_bits_source   ),
		.auto_tl_slave_xing_in_a_bits_address   (tl_slave_a_bits_address  ),
		.auto_tl_slave_xing_in_a_bits_mask      (tl_slave_a_bits_mask     ),
		.auto_tl_slave_xing_in_a_bits_data      (tl_slave_a_bits_data     ),
		.auto_tl_slave_xing_in_d_ready          (tl_slave_d_ready         ),
		.auto_tl_slave_xing_in_d_valid          (tl_slave_d_valid         ),
		.auto_tl_slave_xing_in_d_bits_opcode    (tl_slave_d_bits_opcode   ),
		.auto_tl_slave_xing_in_d_bits_param     (tl_slave_d_bits_param    ),
		.auto_tl_slave_xing_in_d_bits_size      (tl_slave_d_bits_size     ),
		.auto_tl_slave_xing_in_d_bits_source    (tl_slave_d_bits_source   ),
		.auto_tl_slave_xing_in_d_bits_sink      (tl_slave_d_bits_sink     ),
		.auto_tl_slave_xing_in_d_bits_denied    (tl_slave_d_bits_denied   ),
		.auto_tl_slave_xing_in_d_bits_data      (tl_slave_d_bits_data     ),
		.auto_tl_slave_xing_in_d_bits_corrupt   (tl_slave_d_bits_corrupt  ),

		.auto_tl_master_xing_out_a_ready        (tl_master_a_ready        ),
		.auto_tl_master_xing_out_a_valid        (tl_master_a_valid        ),
		.auto_tl_master_xing_out_a_bits_opcode  (tl_master_a_bits_opcode  ),
		.auto_tl_master_xing_out_a_bits_param   (tl_master_a_bits_param   ),
		.auto_tl_master_xing_out_a_bits_size    (tl_master_a_bits_size    ),
		.auto_tl_master_xing_out_a_bits_source  (tl_master_a_bits_source  ),
		.auto_tl_master_xing_out_a_bits_address (tl_master_a_bits_address ),
		.auto_tl_master_xing_out_a_bits_mask    (tl_master_a_bits_mask    ),
		.auto_tl_master_xing_out_a_bits_data    (tl_master_a_bits_data    ),
		.auto_tl_master_xing_out_a_bits_corrupt (tl_master_a_bits_corrupt ),
		.auto_tl_master_xing_out_d_ready        (tl_master_d_ready        ),
		.auto_tl_master_xing_out_d_valid        (tl_master_d_valid        ),
		.auto_tl_master_xing_out_d_bits_opcode  (tl_master_d_bits_opcode  ),
		.auto_tl_master_xing_out_d_bits_param   (tl_master_d_bits_param   ),
		.auto_tl_master_xing_out_d_bits_size    (tl_master_d_bits_size    ),
		.auto_tl_master_xing_out_d_bits_source  (tl_master_d_bits_source  ),
		.auto_tl_master_xing_out_d_bits_sink    (tl_master_d_bits_sink    ),
		.auto_tl_master_xing_out_d_bits_denied  (tl_master_d_bits_denied  ),
		.auto_tl_master_xing_out_d_bits_data    (tl_master_d_bits_data    ),
		.auto_tl_master_xing_out_d_bits_corrupt (tl_master_d_bits_corrupt )
	);

	assign rvfi_valid                = rocket_tile.RVFI_valid;
	assign rvfi_order                = rocket_tile.RVFI_order;
	assign rvfi_insn                 = rocket_tile.RVFI_insn;
	assign rvfi_trap                 = rocket_tile.RVFI_trap;
	assign rvfi_halt                 = rocket_tile.RVFI_halt;
	assign rvfi_intr                 = rocket_tile.RVFI_intr;
	assign rvfi_mode                 = rocket_tile.RVFI_mode;
	assign rvfi_ixl                  = rocket_tile.RVFI_ixl;

	assign rvfi_pc_rdata             = rocket_tile.RVFI_pc_rdata;
	assign rvfi_pc_wdata             = rocket_tile.RVFI_pc_wdata;

	assign rvfi_rs1_addr             = rocket_tile.RVFI_rs1_addr;
	assign rvfi_rs1_rdata            = rocket_tile.RVFI_rs1_rdata;

	assign rvfi_rs2_addr             = rocket_tile.RVFI_rs2_addr;
	assign rvfi_rs2_rdata            = rocket_tile.RVFI_rs2_rdata;

	assign rvfi_rd_addr              = rocket_tile.RVFI_rd_addr;
	assign rvfi_rd_wdata             = rocket_tile.RVFI_rd_wdata;

	assign rvfi_mem_addr             = rocket_tile.RVFI_mem_addr;
	assign rvfi_mem_rdata            = rocket_tile.RVFI_mem_rdata;
	assign rvfi_mem_rmask            = rocket_tile.RVFI_mem_rmask;
	assign rvfi_mem_wdata            = rocket_tile.RVFI_mem_wdata;
	assign rvfi_mem_wmask            = rocket_tile.RVFI_mem_wmask;
	assign rvfi_mem_extamo           = rocket_tile.RVFI_mem_extamo;

	assign rvfi_csr_misa_wmask       = rocket_tile.RVFI_csr_misa_wmask;
	assign rvfi_csr_misa_rmask       = rocket_tile.RVFI_csr_misa_rmask;
	assign rvfi_csr_misa_wdata       = rocket_tile.RVFI_csr_misa_wdata;
	assign rvfi_csr_misa_rdata       = rocket_tile.RVFI_csr_misa_rdata;

	assign rvfi_csr_minstret_wmask   = rocket_tile.RVFI_csr_minstret_wmask;
	assign rvfi_csr_minstret_rmask   = rocket_tile.RVFI_csr_minstret_rmask;
	assign rvfi_csr_minstret_wdata   = rocket_tile.RVFI_csr_minstret_wdata;
	assign rvfi_csr_minstret_rdata   = rocket_tile.RVFI_csr_minstret_rdata;

	assign rvfi_csr_mcycle_wmask     = rocket_tile.RVFI_csr_mcycle_wmask;
	assign rvfi_csr_mcycle_rmask     = rocket_tile.RVFI_csr_mcycle_rmask;
	assign rvfi_csr_mcycle_wdata     = rocket_tile.RVFI_csr_mcycle_wdata;
	assign rvfi_csr_mcycle_rdata     = rocket_tile.RVFI_csr_mcycle_rdata;
endmodule
