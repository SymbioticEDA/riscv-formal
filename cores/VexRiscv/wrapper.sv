module rvfi_wrapper (
	input         clock,
	input         reset,
	`RVFI_OUTPUTS
);
	(* keep *) wire trap;


	(* keep *) wire        iBus_cmd_valid;
	(* keep *) wire [31:0] iBus_cmd_payload_pc;
	(* keep *) `rvformal_rand_reg iBus_cmd_ready;
	(* keep *) `rvformal_rand_reg iBus_rsp_ready;
	(* keep *) `rvformal_rand_reg [31:0] iBus_rsp_inst;


	(* keep *) wire  dBus_cmd_valid;
	(* keep *) wire  dBus_cmd_payload_wr;
	(* keep *) wire [31:0] dBus_cmd_payload_address;
	(* keep *) wire [31:0] dBus_cmd_payload_data;
	(* keep *) wire [1:0] dBus_cmd_payload_size;
	(* keep *) `rvformal_rand_reg dBus_cmd_ready;
	//(* keep *) `rvformal_rand_reg    dBus_rsp_ready;
	(* keep *) `rvformal_rand_reg   [31:0] dBus_rsp_data;




	VexRiscv uut (
		.clk       (clock    ),
		.reset    (reset   ),

		.iBus_cmd_valid (iBus_cmd_valid),
		.iBus_cmd_ready (iBus_cmd_ready),
		.iBus_cmd_payload_pc  (iBus_cmd_payload_pc ),
		.iBus_rsp_ready(iBus_rsp_ready),
		.iBus_rsp_inst (iBus_rsp_inst),
		.iBus_rsp_error(1'b0),

		.dBus_cmd_valid(dBus_cmd_valid),
		.dBus_cmd_payload_wr(dBus_cmd_payload_wr),
		.dBus_cmd_payload_address(dBus_cmd_payload_address),
		.dBus_cmd_payload_data(dBus_cmd_payload_data),
		.dBus_cmd_payload_size(dBus_cmd_payload_size),
		.dBus_cmd_ready(dBus_cmd_ready),
		.dBus_rsp_ready(1'b1),
		.dBus_rsp_data(dBus_rsp_data),
		.dBus_rsp_error(1'b0),

		`RVFI_CONN
	);

`ifdef VEXRISCV_FAIRNESS
	reg [2:0] mem_wait = 0;
	always @(posedge clock) begin
		mem_wait <= {mem_wait, mem_valid && !mem_ready};
		restrict(~mem_wait || trap);
	end
`endif
endmodule

