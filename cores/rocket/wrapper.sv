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
	(* keep *) wire        io_dmem_ordered = $anyseq;
	(* keep *) wire        io_dmem_replay_next = $anyseq;
	(* keep *) wire        io_dmem_req_ready = $anyseq;
	(* keep *) wire [31:0] io_dmem_resp_bits_data = $anyseq;
	(* keep *) wire [31:0] io_dmem_resp_bits_data_word_bypass = $anyseq;
	(* keep *) wire        io_dmem_resp_bits_has_data = $anyseq;
	(* keep *) wire        io_dmem_resp_bits_replay = $anyseq;
	(* keep *) wire [6:0]  io_dmem_resp_bits_tag = $anyseq;
	(* keep *) wire        io_dmem_resp_valid = $anyseq;
	(* keep *) wire        io_dmem_s2_nack = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_ae_ld = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_ae_st = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_ma_ld = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_ma_st = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_pf_ld = $anyseq;
	(* keep *) wire        io_dmem_s2_xcpt_pf_st = $anyseq;
	(* keep *) wire        io_fpu_dec_ren1 = $anyseq;
	(* keep *) wire        io_fpu_dec_ren2 = $anyseq;
	(* keep *) wire        io_fpu_dec_ren3 = $anyseq;
	(* keep *) wire        io_fpu_dec_wen = $anyseq;
	(* keep *) wire [4:0]  io_fpu_fcsr_flags_bits = $anyseq;
	(* keep *) wire        io_fpu_fcsr_flags_valid = $anyseq;
	(* keep *) wire        io_fpu_fcsr_rdy = $anyseq;
	(* keep *) wire        io_fpu_illegal_rm = $anyseq;
	(* keep *) wire        io_fpu_nack_mem = $anyseq;
	(* keep *) wire        io_fpu_sboard_clr = $anyseq;
	(* keep *) wire [4:0]  io_fpu_sboard_clra = $anyseq;
	(* keep *) wire        io_fpu_sboard_set = $anyseq;
	(* keep *) wire [31:0] io_fpu_store_data = $anyseq;
	(* keep *) wire [31:0] io_fpu_toint_data = $anyseq;
	(* keep *) wire        io_hartid = $anyseq;
	(* keep *) wire        io_imem_resp_bits_ae = $anyseq;
	(* keep *) wire [6:0]  io_imem_resp_bits_btb_bits_bht_history = $anyseq;
	(* keep *) wire [1:0]  io_imem_resp_bits_btb_bits_bht_value = $anyseq;
	(* keep *) wire        io_imem_resp_bits_btb_bits_bridx = $anyseq;
	(* keep *) wire [5:0]  io_imem_resp_bits_btb_bits_entry = $anyseq;
	(* keep *) wire        io_imem_resp_bits_btb_bits_taken = $anyseq;
	(* keep *) wire        io_imem_resp_bits_btb_valid = $anyseq;
	(* keep *) wire [31:0] io_imem_resp_bits_data = $anyseq;
	(* keep *) wire [31:0] io_imem_resp_bits_pc = $anyseq;
	(* keep *) wire        io_imem_resp_bits_pf = $anyseq;
	(* keep *) wire        io_imem_resp_bits_replay = $anyseq;
	(* keep *) wire        io_imem_resp_valid = $anyseq;
	(* keep *) wire        io_interrupts_debug = $anyseq;
	(* keep *) wire        io_interrupts_meip = $anyseq;
	(* keep *) wire        io_interrupts_msip = $anyseq;
	(* keep *) wire        io_interrupts_mtip = $anyseq;
	(* keep *) wire        io_interrupts_seip = $anyseq;
	(* keep *) wire        io_rocc_cmd_ready = $anyseq;
	(* keep *) wire        io_rocc_interrupt = $anyseq;

	(* keep *) wire        io_dmem_invalidate_lr;
	(* keep *) wire [31:0] io_dmem_req_bits_addr;
	(* keep *) wire [4:0]  io_dmem_req_bits_cmd;
	(* keep *) wire        io_dmem_req_bits_phys;
	(* keep *) wire [6:0]  io_dmem_req_bits_tag;
	(* keep *) wire [2:0]  io_dmem_req_bits_typ;
	(* keep *) wire        io_dmem_req_valid;
	(* keep *) wire [31:0] io_dmem_s1_data_data;
	(* keep *) wire [3:0]  io_dmem_s1_data_mask;
	(* keep *) wire        io_dmem_s1_kill;
	(* keep *) wire [31:0] io_fpu_dmem_resp_data;
	(* keep *) wire [4:0]  io_fpu_dmem_resp_tag;
	(* keep *) wire        io_fpu_dmem_resp_val;
	(* keep *) wire [2:0]  io_fpu_fcsr_rm;
	(* keep *) wire [31:0] io_fpu_fromint_data;
	(* keep *) wire [31:0] io_fpu_inst;
	(* keep *) wire        io_fpu_killm;
	(* keep *) wire        io_fpu_killx;
	(* keep *) wire        io_fpu_valid;
	(* keep *) wire        io_imem_bht_update_bits_mispredict;
	(* keep *) wire [31:0] io_imem_bht_update_bits_pc;
	(* keep *) wire [6:0]  io_imem_bht_update_bits_prediction_bits_bht_history;
	(* keep *) wire [1:0]  io_imem_bht_update_bits_prediction_bits_bht_value;
	(* keep *) wire        io_imem_bht_update_bits_prediction_valid;
	(* keep *) wire        io_imem_bht_update_bits_taken;
	(* keep *) wire        io_imem_bht_update_valid;
	(* keep *) wire [31:0] io_imem_btb_update_bits_br_pc;
	(* keep *) wire [1:0]  io_imem_btb_update_bits_cfiType;
	(* keep *) wire        io_imem_btb_update_bits_isValid;
	(* keep *) wire [31:0] io_imem_btb_update_bits_pc;
	(* keep *) wire [6:0]  io_imem_btb_update_bits_prediction_bits_bht_history;
	(* keep *) wire [1:0]  io_imem_btb_update_bits_prediction_bits_bht_value;
	(* keep *) wire [5:0]  io_imem_btb_update_bits_prediction_bits_entry;
	(* keep *) wire        io_imem_btb_update_bits_prediction_valid;
	(* keep *) wire        io_imem_btb_update_valid;
	(* keep *) wire        io_imem_flush_icache;
	(* keep *) wire [31:0] io_imem_req_bits_pc;
	(* keep *) wire        io_imem_req_bits_speculative;
	(* keep *) wire        io_imem_req_valid;
	(* keep *) wire        io_imem_resp_ready;
	(* keep *) wire        io_imem_sfence_bits_rs1;
	(* keep *) wire        io_imem_sfence_bits_rs2;
	(* keep *) wire        io_imem_sfence_valid;
	(* keep *) wire        io_ptw_invalidate;
	(* keep *) wire [29:0] io_ptw_pmp_0_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_0_cfg_a;
	(* keep *) wire        io_ptw_pmp_0_cfg_l;
	(* keep *) wire        io_ptw_pmp_0_cfg_r;
	(* keep *) wire        io_ptw_pmp_0_cfg_w;
	(* keep *) wire        io_ptw_pmp_0_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_0_mask;
	(* keep *) wire [29:0] io_ptw_pmp_1_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_1_cfg_a;
	(* keep *) wire        io_ptw_pmp_1_cfg_l;
	(* keep *) wire        io_ptw_pmp_1_cfg_r;
	(* keep *) wire        io_ptw_pmp_1_cfg_w;
	(* keep *) wire        io_ptw_pmp_1_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_1_mask;
	(* keep *) wire [29:0] io_ptw_pmp_2_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_2_cfg_a;
	(* keep *) wire        io_ptw_pmp_2_cfg_l;
	(* keep *) wire        io_ptw_pmp_2_cfg_r;
	(* keep *) wire        io_ptw_pmp_2_cfg_w;
	(* keep *) wire        io_ptw_pmp_2_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_2_mask;
	(* keep *) wire [29:0] io_ptw_pmp_3_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_3_cfg_a;
	(* keep *) wire        io_ptw_pmp_3_cfg_l;
	(* keep *) wire        io_ptw_pmp_3_cfg_r;
	(* keep *) wire        io_ptw_pmp_3_cfg_w;
	(* keep *) wire        io_ptw_pmp_3_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_3_mask;
	(* keep *) wire [29:0] io_ptw_pmp_4_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_4_cfg_a;
	(* keep *) wire        io_ptw_pmp_4_cfg_l;
	(* keep *) wire        io_ptw_pmp_4_cfg_r;
	(* keep *) wire        io_ptw_pmp_4_cfg_w;
	(* keep *) wire        io_ptw_pmp_4_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_4_mask;
	(* keep *) wire [29:0] io_ptw_pmp_5_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_5_cfg_a;
	(* keep *) wire        io_ptw_pmp_5_cfg_l;
	(* keep *) wire        io_ptw_pmp_5_cfg_r;
	(* keep *) wire        io_ptw_pmp_5_cfg_w;
	(* keep *) wire        io_ptw_pmp_5_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_5_mask;
	(* keep *) wire [29:0] io_ptw_pmp_6_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_6_cfg_a;
	(* keep *) wire        io_ptw_pmp_6_cfg_l;
	(* keep *) wire        io_ptw_pmp_6_cfg_r;
	(* keep *) wire        io_ptw_pmp_6_cfg_w;
	(* keep *) wire        io_ptw_pmp_6_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_6_mask;
	(* keep *) wire [29:0] io_ptw_pmp_7_addr;
	(* keep *) wire [1:0]  io_ptw_pmp_7_cfg_a;
	(* keep *) wire        io_ptw_pmp_7_cfg_l;
	(* keep *) wire        io_ptw_pmp_7_cfg_r;
	(* keep *) wire        io_ptw_pmp_7_cfg_w;
	(* keep *) wire        io_ptw_pmp_7_cfg_x;
	(* keep *) wire [31:0] io_ptw_pmp_7_mask;
	(* keep *) wire [8:0]  io_ptw_ptbr_asid;
	(* keep *) wire        io_ptw_ptbr_mode;
	(* keep *) wire [21:0] io_ptw_ptbr_ppn;
	(* keep *) wire [1:0]  io_ptw_status_dprv;
	(* keep *) wire        io_ptw_status_mxr;
	(* keep *) wire [1:0]  io_ptw_status_prv;
	(* keep *) wire        io_ptw_status_sum;
	(* keep *) wire        io_rocc_cmd_valid;

	// ---- IMEM Constraints ----

	reg [31:0] imem_pc_fifo [0:63];
	reg [5:0] imem_pc_fifo_wptr = 0;
	reg [5:0] imem_pc_fifo_rptr = 0;

	always @(posedge clock) begin
		if (reset) begin
			imem_pc_fifo_wptr <= 0;
			imem_pc_fifo_rptr <= 0;
			assume(!io_imem_resp_valid);
		end else begin
			if (imem_pc_fifo_wptr == imem_pc_fifo_rptr) begin
				assume(!io_imem_resp_valid);
			end

			if (io_imem_resp_valid) begin
				assume(io_imem_resp_bits_pc == imem_pc_fifo[imem_pc_fifo_rptr]);
			end

			if (io_imem_resp_valid && io_imem_resp_ready) begin
				imem_pc_fifo_rptr <= imem_pc_fifo_rptr + 1;
			end

			if (io_imem_req_valid) begin
				imem_pc_fifo[imem_pc_fifo_wptr] <= io_imem_req_bits_pc;
				imem_pc_fifo_wptr <= imem_pc_fifo_wptr + 1;
			end

			if ($past(io_imem_resp_valid) && !$past(io_imem_resp_ready)) begin
				assume(io_imem_resp_valid);
				assume($stable(io_imem_resp_bits_pc));
				assume($stable(io_imem_resp_bits_data));
			end
		end
	end

	// ---- Rocket Instance ----

	RocketWithRVFI rocket (
		.clock                                              (clock                                              ),
		.reset                                              (reset                                              ),

		.io_dmem_invalidate_lr                              (io_dmem_invalidate_lr                              ),
		.io_dmem_ordered                                    (io_dmem_ordered                                    ),
		.io_dmem_replay_next                                (io_dmem_replay_next                                ),
		.io_dmem_req_bits_addr                              (io_dmem_req_bits_addr                              ),
		.io_dmem_req_bits_cmd                               (io_dmem_req_bits_cmd                               ),
		.io_dmem_req_bits_phys                              (io_dmem_req_bits_phys                              ),
		.io_dmem_req_bits_tag                               (io_dmem_req_bits_tag                               ),
		.io_dmem_req_bits_typ                               (io_dmem_req_bits_typ                               ),
		.io_dmem_req_ready                                  (io_dmem_req_ready                                  ),
		.io_dmem_req_valid                                  (io_dmem_req_valid                                  ),
		.io_dmem_resp_bits_data                             (io_dmem_resp_bits_data                             ),
		.io_dmem_resp_bits_data_word_bypass                 (io_dmem_resp_bits_data_word_bypass                 ),
		.io_dmem_resp_bits_has_data                         (io_dmem_resp_bits_has_data                         ),
		.io_dmem_resp_bits_replay                           (io_dmem_resp_bits_replay                           ),
		.io_dmem_resp_bits_tag                              (io_dmem_resp_bits_tag                              ),
		.io_dmem_resp_valid                                 (io_dmem_resp_valid                                 ),
		.io_dmem_s1_data_data                               (io_dmem_s1_data_data                               ),
		.io_dmem_s1_data_mask                               (io_dmem_s1_data_mask                               ),
		.io_dmem_s1_kill                                    (io_dmem_s1_kill                                    ),
		.io_dmem_s2_nack                                    (io_dmem_s2_nack                                    ),
		.io_dmem_s2_xcpt_ae_ld                              (io_dmem_s2_xcpt_ae_ld                              ),
		.io_dmem_s2_xcpt_ae_st                              (io_dmem_s2_xcpt_ae_st                              ),
		.io_dmem_s2_xcpt_ma_ld                              (io_dmem_s2_xcpt_ma_ld                              ),
		.io_dmem_s2_xcpt_ma_st                              (io_dmem_s2_xcpt_ma_st                              ),
		.io_dmem_s2_xcpt_pf_ld                              (io_dmem_s2_xcpt_pf_ld                              ),
		.io_dmem_s2_xcpt_pf_st                              (io_dmem_s2_xcpt_pf_st                              ),
		.io_fpu_dec_ren1                                    (io_fpu_dec_ren1                                    ),
		.io_fpu_dec_ren2                                    (io_fpu_dec_ren2                                    ),
		.io_fpu_dec_ren3                                    (io_fpu_dec_ren3                                    ),
		.io_fpu_dec_wen                                     (io_fpu_dec_wen                                     ),
		.io_fpu_dmem_resp_data                              (io_fpu_dmem_resp_data                              ),
		.io_fpu_dmem_resp_tag                               (io_fpu_dmem_resp_tag                               ),
		.io_fpu_dmem_resp_val                               (io_fpu_dmem_resp_val                               ),
		.io_fpu_fcsr_flags_bits                             (io_fpu_fcsr_flags_bits                             ),
		.io_fpu_fcsr_flags_valid                            (io_fpu_fcsr_flags_valid                            ),
		.io_fpu_fcsr_rdy                                    (io_fpu_fcsr_rdy                                    ),
		.io_fpu_fcsr_rm                                     (io_fpu_fcsr_rm                                     ),
		.io_fpu_fromint_data                                (io_fpu_fromint_data                                ),
		.io_fpu_illegal_rm                                  (io_fpu_illegal_rm                                  ),
		.io_fpu_inst                                        (io_fpu_inst                                        ),
		.io_fpu_killm                                       (io_fpu_killm                                       ),
		.io_fpu_killx                                       (io_fpu_killx                                       ),
		.io_fpu_nack_mem                                    (io_fpu_nack_mem                                    ),
		.io_fpu_sboard_clr                                  (io_fpu_sboard_clr                                  ),
		.io_fpu_sboard_clra                                 (io_fpu_sboard_clra                                 ),
		.io_fpu_sboard_set                                  (io_fpu_sboard_set                                  ),
		.io_fpu_store_data                                  (io_fpu_store_data                                  ),
		.io_fpu_toint_data                                  (io_fpu_toint_data                                  ),
		.io_fpu_valid                                       (io_fpu_valid                                       ),
		.io_hartid                                          (io_hartid                                          ),
		.io_imem_bht_update_bits_mispredict                 (io_imem_bht_update_bits_mispredict                 ),
		.io_imem_bht_update_bits_pc                         (io_imem_bht_update_bits_pc                         ),
		.io_imem_bht_update_bits_prediction_bits_bht_history(io_imem_bht_update_bits_prediction_bits_bht_history),
		.io_imem_bht_update_bits_prediction_bits_bht_value  (io_imem_bht_update_bits_prediction_bits_bht_value  ),
		.io_imem_bht_update_bits_prediction_valid           (io_imem_bht_update_bits_prediction_valid           ),
		.io_imem_bht_update_bits_taken                      (io_imem_bht_update_bits_taken                      ),
		.io_imem_bht_update_valid                           (io_imem_bht_update_valid                           ),
		.io_imem_btb_update_bits_br_pc                      (io_imem_btb_update_bits_br_pc                      ),
		.io_imem_btb_update_bits_cfiType                    (io_imem_btb_update_bits_cfiType                    ),
		.io_imem_btb_update_bits_isValid                    (io_imem_btb_update_bits_isValid                    ),
		.io_imem_btb_update_bits_pc                         (io_imem_btb_update_bits_pc                         ),
		.io_imem_btb_update_bits_prediction_bits_bht_history(io_imem_btb_update_bits_prediction_bits_bht_history),
		.io_imem_btb_update_bits_prediction_bits_bht_value  (io_imem_btb_update_bits_prediction_bits_bht_value  ),
		.io_imem_btb_update_bits_prediction_bits_entry      (io_imem_btb_update_bits_prediction_bits_entry      ),
		.io_imem_btb_update_bits_prediction_valid           (io_imem_btb_update_bits_prediction_valid           ),
		.io_imem_btb_update_valid                           (io_imem_btb_update_valid                           ),
		.io_imem_flush_icache                               (io_imem_flush_icache                               ),
		.io_imem_req_bits_pc                                (io_imem_req_bits_pc                                ),
		.io_imem_req_bits_speculative                       (io_imem_req_bits_speculative                       ),
		.io_imem_req_valid                                  (io_imem_req_valid                                  ),
		.io_imem_resp_bits_ae                               (io_imem_resp_bits_ae                               ),
		.io_imem_resp_bits_btb_bits_bht_history             (io_imem_resp_bits_btb_bits_bht_history             ),
		.io_imem_resp_bits_btb_bits_bht_value               (io_imem_resp_bits_btb_bits_bht_value               ),
		.io_imem_resp_bits_btb_bits_bridx                   (io_imem_resp_bits_btb_bits_bridx                   ),
		.io_imem_resp_bits_btb_bits_entry                   (io_imem_resp_bits_btb_bits_entry                   ),
		.io_imem_resp_bits_btb_bits_taken                   (io_imem_resp_bits_btb_bits_taken                   ),
		.io_imem_resp_bits_btb_valid                        (io_imem_resp_bits_btb_valid                        ),
		.io_imem_resp_bits_data                             (io_imem_resp_bits_data                             ),
		.io_imem_resp_bits_pc                               (io_imem_resp_bits_pc                               ),
		.io_imem_resp_bits_pf                               (io_imem_resp_bits_pf                               ),
		.io_imem_resp_bits_replay                           (io_imem_resp_bits_replay                           ),
		.io_imem_resp_ready                                 (io_imem_resp_ready                                 ),
		.io_imem_resp_valid                                 (io_imem_resp_valid                                 ),
		.io_imem_sfence_bits_rs1                            (io_imem_sfence_bits_rs1                            ),
		.io_imem_sfence_bits_rs2                            (io_imem_sfence_bits_rs2                            ),
		.io_imem_sfence_valid                               (io_imem_sfence_valid                               ),
		.io_interrupts_debug                                (io_interrupts_debug                                ),
		.io_interrupts_meip                                 (io_interrupts_meip                                 ),
		.io_interrupts_msip                                 (io_interrupts_msip                                 ),
		.io_interrupts_mtip                                 (io_interrupts_mtip                                 ),
		.io_interrupts_seip                                 (io_interrupts_seip                                 ),
		.io_ptw_invalidate                                  (io_ptw_invalidate                                  ),
		.io_ptw_pmp_0_addr                                  (io_ptw_pmp_0_addr                                  ),
		.io_ptw_pmp_0_cfg_a                                 (io_ptw_pmp_0_cfg_a                                 ),
		.io_ptw_pmp_0_cfg_l                                 (io_ptw_pmp_0_cfg_l                                 ),
		.io_ptw_pmp_0_cfg_r                                 (io_ptw_pmp_0_cfg_r                                 ),
		.io_ptw_pmp_0_cfg_w                                 (io_ptw_pmp_0_cfg_w                                 ),
		.io_ptw_pmp_0_cfg_x                                 (io_ptw_pmp_0_cfg_x                                 ),
		.io_ptw_pmp_0_mask                                  (io_ptw_pmp_0_mask                                  ),
		.io_ptw_pmp_1_addr                                  (io_ptw_pmp_1_addr                                  ),
		.io_ptw_pmp_1_cfg_a                                 (io_ptw_pmp_1_cfg_a                                 ),
		.io_ptw_pmp_1_cfg_l                                 (io_ptw_pmp_1_cfg_l                                 ),
		.io_ptw_pmp_1_cfg_r                                 (io_ptw_pmp_1_cfg_r                                 ),
		.io_ptw_pmp_1_cfg_w                                 (io_ptw_pmp_1_cfg_w                                 ),
		.io_ptw_pmp_1_cfg_x                                 (io_ptw_pmp_1_cfg_x                                 ),
		.io_ptw_pmp_1_mask                                  (io_ptw_pmp_1_mask                                  ),
		.io_ptw_pmp_2_addr                                  (io_ptw_pmp_2_addr                                  ),
		.io_ptw_pmp_2_cfg_a                                 (io_ptw_pmp_2_cfg_a                                 ),
		.io_ptw_pmp_2_cfg_l                                 (io_ptw_pmp_2_cfg_l                                 ),
		.io_ptw_pmp_2_cfg_r                                 (io_ptw_pmp_2_cfg_r                                 ),
		.io_ptw_pmp_2_cfg_w                                 (io_ptw_pmp_2_cfg_w                                 ),
		.io_ptw_pmp_2_cfg_x                                 (io_ptw_pmp_2_cfg_x                                 ),
		.io_ptw_pmp_2_mask                                  (io_ptw_pmp_2_mask                                  ),
		.io_ptw_pmp_3_addr                                  (io_ptw_pmp_3_addr                                  ),
		.io_ptw_pmp_3_cfg_a                                 (io_ptw_pmp_3_cfg_a                                 ),
		.io_ptw_pmp_3_cfg_l                                 (io_ptw_pmp_3_cfg_l                                 ),
		.io_ptw_pmp_3_cfg_r                                 (io_ptw_pmp_3_cfg_r                                 ),
		.io_ptw_pmp_3_cfg_w                                 (io_ptw_pmp_3_cfg_w                                 ),
		.io_ptw_pmp_3_cfg_x                                 (io_ptw_pmp_3_cfg_x                                 ),
		.io_ptw_pmp_3_mask                                  (io_ptw_pmp_3_mask                                  ),
		.io_ptw_pmp_4_addr                                  (io_ptw_pmp_4_addr                                  ),
		.io_ptw_pmp_4_cfg_a                                 (io_ptw_pmp_4_cfg_a                                 ),
		.io_ptw_pmp_4_cfg_l                                 (io_ptw_pmp_4_cfg_l                                 ),
		.io_ptw_pmp_4_cfg_r                                 (io_ptw_pmp_4_cfg_r                                 ),
		.io_ptw_pmp_4_cfg_w                                 (io_ptw_pmp_4_cfg_w                                 ),
		.io_ptw_pmp_4_cfg_x                                 (io_ptw_pmp_4_cfg_x                                 ),
		.io_ptw_pmp_4_mask                                  (io_ptw_pmp_4_mask                                  ),
		.io_ptw_pmp_5_addr                                  (io_ptw_pmp_5_addr                                  ),
		.io_ptw_pmp_5_cfg_a                                 (io_ptw_pmp_5_cfg_a                                 ),
		.io_ptw_pmp_5_cfg_l                                 (io_ptw_pmp_5_cfg_l                                 ),
		.io_ptw_pmp_5_cfg_r                                 (io_ptw_pmp_5_cfg_r                                 ),
		.io_ptw_pmp_5_cfg_w                                 (io_ptw_pmp_5_cfg_w                                 ),
		.io_ptw_pmp_5_cfg_x                                 (io_ptw_pmp_5_cfg_x                                 ),
		.io_ptw_pmp_5_mask                                  (io_ptw_pmp_5_mask                                  ),
		.io_ptw_pmp_6_addr                                  (io_ptw_pmp_6_addr                                  ),
		.io_ptw_pmp_6_cfg_a                                 (io_ptw_pmp_6_cfg_a                                 ),
		.io_ptw_pmp_6_cfg_l                                 (io_ptw_pmp_6_cfg_l                                 ),
		.io_ptw_pmp_6_cfg_r                                 (io_ptw_pmp_6_cfg_r                                 ),
		.io_ptw_pmp_6_cfg_w                                 (io_ptw_pmp_6_cfg_w                                 ),
		.io_ptw_pmp_6_cfg_x                                 (io_ptw_pmp_6_cfg_x                                 ),
		.io_ptw_pmp_6_mask                                  (io_ptw_pmp_6_mask                                  ),
		.io_ptw_pmp_7_addr                                  (io_ptw_pmp_7_addr                                  ),
		.io_ptw_pmp_7_cfg_a                                 (io_ptw_pmp_7_cfg_a                                 ),
		.io_ptw_pmp_7_cfg_l                                 (io_ptw_pmp_7_cfg_l                                 ),
		.io_ptw_pmp_7_cfg_r                                 (io_ptw_pmp_7_cfg_r                                 ),
		.io_ptw_pmp_7_cfg_w                                 (io_ptw_pmp_7_cfg_w                                 ),
		.io_ptw_pmp_7_cfg_x                                 (io_ptw_pmp_7_cfg_x                                 ),
		.io_ptw_pmp_7_mask                                  (io_ptw_pmp_7_mask                                  ),
		.io_ptw_ptbr_asid                                   (io_ptw_ptbr_asid                                   ),
		.io_ptw_ptbr_mode                                   (io_ptw_ptbr_mode                                   ),
		.io_ptw_ptbr_ppn                                    (io_ptw_ptbr_ppn                                    ),
		.io_ptw_status_dprv                                 (io_ptw_status_dprv                                 ),
		.io_ptw_status_mxr                                  (io_ptw_status_mxr                                  ),
		.io_ptw_status_prv                                  (io_ptw_status_prv                                  ),
		.io_ptw_status_sum                                  (io_ptw_status_sum                                  ),
		.io_rocc_cmd_ready                                  (io_rocc_cmd_ready                                  ),
		.io_rocc_cmd_valid                                  (io_rocc_cmd_valid                                  ),
		.io_rocc_interrupt                                  (io_rocc_interrupt                                  ),

		.rvfi_insn                                          (rvfi_insn                                          ),
		.rvfi_mem_addr                                      (rvfi_mem_addr                                      ),
		.rvfi_mem_rdata                                     (rvfi_mem_rdata                                     ),
		.rvfi_mem_rmask                                     (rvfi_mem_rmask                                     ),
		.rvfi_mem_wdata                                     (rvfi_mem_wdata                                     ),
		.rvfi_mem_wmask                                     (rvfi_mem_wmask                                     ),
		.rvfi_order                                         (rvfi_order                                         ),
		.rvfi_pc_rdata                                      (rvfi_pc_rdata                                      ),
		.rvfi_pc_wdata                                      (rvfi_pc_wdata                                      ),
		.rvfi_rd_addr                                       (rvfi_rd_addr                                       ),
		.rvfi_rd_wdata                                      (rvfi_rd_wdata                                      ),
		.rvfi_rs1_addr                                      (rvfi_rs1_addr                                      ),
		.rvfi_rs1_rdata                                     (rvfi_rs1_rdata                                     ),
		.rvfi_rs2_addr                                      (rvfi_rs2_addr                                      ),
		.rvfi_rs2_rdata                                     (rvfi_rs2_rdata                                     ),
		.rvfi_trap                                          (rvfi_trap                                          ),
		.rvfi_valid                                         (rvfi_valid                                         )
	);
endmodule
