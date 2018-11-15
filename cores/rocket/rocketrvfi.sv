module RocketTileWithRVFI (
	input         clock,
	input         reset,
	`RVFI_OUTPUTS,

	input         auto_intsink_in_sync_0,
	input         auto_int_xing_in_1_sync_0,
	input         auto_int_xing_in_0_sync_0,
	input         auto_int_xing_in_0_sync_1,
	output        auto_tl_slave_xing_in_a_ready,
	input         auto_tl_slave_xing_in_a_valid,
	input  [2:0]  auto_tl_slave_xing_in_a_bits_opcode,
	input  [2:0]  auto_tl_slave_xing_in_a_bits_param,
	input  [2:0]  auto_tl_slave_xing_in_a_bits_size,
	input  [4:0]  auto_tl_slave_xing_in_a_bits_source,
	input  [31:0] auto_tl_slave_xing_in_a_bits_address,
	input  [7:0]  auto_tl_slave_xing_in_a_bits_mask,
	input  [63:0] auto_tl_slave_xing_in_a_bits_data,
	input         auto_tl_slave_xing_in_d_ready,
	output        auto_tl_slave_xing_in_d_valid,
	output [2:0]  auto_tl_slave_xing_in_d_bits_opcode,
	output [2:0]  auto_tl_slave_xing_in_d_bits_size,
	output [4:0]  auto_tl_slave_xing_in_d_bits_source,
	output [63:0] auto_tl_slave_xing_in_d_bits_data,
	input         auto_tl_master_xing_out_a_ready,
	output        auto_tl_master_xing_out_a_valid,
	output [2:0]  auto_tl_master_xing_out_a_bits_opcode,
	output [2:0]  auto_tl_master_xing_out_a_bits_param,
	output [3:0]  auto_tl_master_xing_out_a_bits_size,
	output        auto_tl_master_xing_out_a_bits_source,
	output [31:0] auto_tl_master_xing_out_a_bits_address,
	output [7:0]  auto_tl_master_xing_out_a_bits_mask,
	output [63:0] auto_tl_master_xing_out_a_bits_data,
	output        auto_tl_master_xing_out_a_bits_corrupt,
	output        auto_tl_master_xing_out_d_ready,
	input         auto_tl_master_xing_out_d_valid,
	input  [2:0]  auto_tl_master_xing_out_d_bits_opcode,
	input  [1:0]  auto_tl_master_xing_out_d_bits_param,
	input  [3:0]  auto_tl_master_xing_out_d_bits_size,
	input         auto_tl_master_xing_out_d_bits_source,
	input         auto_tl_master_xing_out_d_bits_sink,
	input         auto_tl_master_xing_out_d_bits_denied,
	input  [63:0] auto_tl_master_xing_out_d_bits_data,
	input         auto_tl_master_xing_out_d_bits_corrupt,
	input         constants_hartid,
	input  [31:0] constants_reset_vector
);
	RocketTile uut (
		.clock                                  (clock                                 ),
		.reset                                  (reset                                 ),
		.auto_intsink_in_sync_0                 (auto_intsink_in_sync_0                ),
		.auto_int_xing_in_1_sync_0              (auto_int_xing_in_1_sync_0             ),
		.auto_int_xing_in_0_sync_0              (auto_int_xing_in_0_sync_0             ),
		.auto_int_xing_in_0_sync_1              (auto_int_xing_in_0_sync_1             ),
		.auto_tl_slave_xing_in_a_ready          (auto_tl_slave_xing_in_a_ready         ),
		.auto_tl_slave_xing_in_a_valid          (auto_tl_slave_xing_in_a_valid         ),
		.auto_tl_slave_xing_in_a_bits_opcode    (auto_tl_slave_xing_in_a_bits_opcode   ),
		.auto_tl_slave_xing_in_a_bits_param     (auto_tl_slave_xing_in_a_bits_param    ),
		.auto_tl_slave_xing_in_a_bits_size      (auto_tl_slave_xing_in_a_bits_size     ),
		.auto_tl_slave_xing_in_a_bits_source    (auto_tl_slave_xing_in_a_bits_source   ),
		.auto_tl_slave_xing_in_a_bits_address   (auto_tl_slave_xing_in_a_bits_address  ),
		.auto_tl_slave_xing_in_a_bits_mask      (auto_tl_slave_xing_in_a_bits_mask     ),
		.auto_tl_slave_xing_in_a_bits_data      (auto_tl_slave_xing_in_a_bits_data     ),
		.auto_tl_slave_xing_in_d_ready          (auto_tl_slave_xing_in_d_ready         ),
		.auto_tl_slave_xing_in_d_valid          (auto_tl_slave_xing_in_d_valid         ),
		.auto_tl_slave_xing_in_d_bits_opcode    (auto_tl_slave_xing_in_d_bits_opcode   ),
		.auto_tl_slave_xing_in_d_bits_size      (auto_tl_slave_xing_in_d_bits_size     ),
		.auto_tl_slave_xing_in_d_bits_source    (auto_tl_slave_xing_in_d_bits_source   ),
		.auto_tl_slave_xing_in_d_bits_data      (auto_tl_slave_xing_in_d_bits_data     ),
		.auto_tl_master_xing_out_a_ready        (auto_tl_master_xing_out_a_ready       ),
		.auto_tl_master_xing_out_a_valid        (auto_tl_master_xing_out_a_valid       ),
		.auto_tl_master_xing_out_a_bits_opcode  (auto_tl_master_xing_out_a_bits_opcode ),
		.auto_tl_master_xing_out_a_bits_param   (auto_tl_master_xing_out_a_bits_param  ),
		.auto_tl_master_xing_out_a_bits_size    (auto_tl_master_xing_out_a_bits_size   ),
		.auto_tl_master_xing_out_a_bits_source  (auto_tl_master_xing_out_a_bits_source ),
		.auto_tl_master_xing_out_a_bits_address (auto_tl_master_xing_out_a_bits_address),
		.auto_tl_master_xing_out_a_bits_mask    (auto_tl_master_xing_out_a_bits_mask   ),
		.auto_tl_master_xing_out_a_bits_data    (auto_tl_master_xing_out_a_bits_data   ),
		.auto_tl_master_xing_out_a_bits_corrupt (auto_tl_master_xing_out_a_bits_corrupt),
		.auto_tl_master_xing_out_d_ready        (auto_tl_master_xing_out_d_ready       ),
		.auto_tl_master_xing_out_d_valid        (auto_tl_master_xing_out_d_valid       ),
		.auto_tl_master_xing_out_d_bits_opcode  (auto_tl_master_xing_out_d_bits_opcode ),
		.auto_tl_master_xing_out_d_bits_param   (auto_tl_master_xing_out_d_bits_param  ),
		.auto_tl_master_xing_out_d_bits_size    (auto_tl_master_xing_out_d_bits_size   ),
		.auto_tl_master_xing_out_d_bits_source  (auto_tl_master_xing_out_d_bits_source ),
		.auto_tl_master_xing_out_d_bits_sink    (auto_tl_master_xing_out_d_bits_sink   ),
		.auto_tl_master_xing_out_d_bits_denied  (auto_tl_master_xing_out_d_bits_denied ),
		.auto_tl_master_xing_out_d_bits_data    (auto_tl_master_xing_out_d_bits_data   ),
		.auto_tl_master_xing_out_d_bits_corrupt (auto_tl_master_xing_out_d_bits_corrupt),
		.constants_hartid                       (constants_hartid                      ),
		.constants_reset_vector                 (constants_reset_vector                )
	);

	assign rvfi_valid = uut.core.rvfi_mon.rvfi_valid;
	assign rvfi_order = uut.core.rvfi_mon.rvfi_order;
	assign rvfi_insn = uut.core.rvfi_mon.rvfi_insn;
	assign rvfi_trap = uut.core.rvfi_mon.rvfi_trap;
	assign rvfi_halt = uut.core.rvfi_mon.rvfi_halt;
	assign rvfi_intr = uut.core.rvfi_mon.rvfi_intr;
	assign rvfi_mode = uut.core.rvfi_mon.rvfi_mode;

	assign rvfi_pc_rdata = uut.core.rvfi_mon.rvfi_pc_rdata;
	assign rvfi_pc_wdata = uut.core.rvfi_mon.rvfi_pc_wdata;

	assign rvfi_rs1_addr = uut.core.rvfi_mon.rvfi_rs1_addr;
	assign rvfi_rs1_rdata = uut.core.rvfi_mon.rvfi_rs1_rdata;

	assign rvfi_rs2_addr = uut.core.rvfi_mon.rvfi_rs2_addr;
	assign rvfi_rs2_rdata = uut.core.rvfi_mon.rvfi_rs2_rdata;

	assign rvfi_rd_addr = uut.core.rvfi_mon.rvfi_rd_addr;
	assign rvfi_rd_wdata = uut.core.rvfi_mon.rvfi_rd_wdata;

	assign rvfi_mem_addr = uut.core.rvfi_mon.rvfi_mem_addr;
	assign rvfi_mem_rdata = uut.core.rvfi_mon.rvfi_mem_rdata;
	assign rvfi_mem_rmask = uut.core.rvfi_mon.rvfi_mem_rmask;
	assign rvfi_mem_wdata = uut.core.rvfi_mon.rvfi_mem_wdata;
	assign rvfi_mem_wmask = uut.core.rvfi_mon.rvfi_mem_wmask;
	assign rvfi_mem_extamo = uut.core.rvfi_mon.rvfi_mem_extamo;

	assign rvfi_csr_misa_wmask     = uut.core.rvfi_mon.rvfi_csr_misa_wmask;
	assign rvfi_csr_misa_rmask     = uut.core.rvfi_mon.rvfi_csr_misa_rmask;
	assign rvfi_csr_misa_wdata     = uut.core.rvfi_mon.rvfi_csr_misa_wdata;
	assign rvfi_csr_misa_rdata     = uut.core.rvfi_mon.rvfi_csr_misa_rdata;

	assign rvfi_csr_minstret_wmask = uut.core.rvfi_mon.rvfi_csr_minstret_wmask;
	assign rvfi_csr_minstret_rmask = uut.core.rvfi_mon.rvfi_csr_minstret_rmask;
	assign rvfi_csr_minstret_wdata = uut.core.rvfi_mon.rvfi_csr_minstret_wdata;
	assign rvfi_csr_minstret_rdata = uut.core.rvfi_mon.rvfi_csr_minstret_rdata;

	assign rvfi_csr_mcycle_wmask   = uut.core.rvfi_mon.rvfi_csr_mcycle_wmask;
	assign rvfi_csr_mcycle_rmask   = uut.core.rvfi_mon.rvfi_csr_mcycle_rmask;
	assign rvfi_csr_mcycle_wdata   = uut.core.rvfi_mon.rvfi_csr_mcycle_wdata;
	assign rvfi_csr_mcycle_rdata   = uut.core.rvfi_mon.rvfi_csr_mcycle_rdata;
endmodule

module RVFIMonitor (
	input clock,
	input reset,
	`RVFI_INPUTS,
	output errcode
);
	assign errcode = 0;
endmodule
