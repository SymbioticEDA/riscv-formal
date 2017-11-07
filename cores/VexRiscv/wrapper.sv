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
	(* keep *) `rvformal_rand_reg    dBus_rsp_ready;
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
		.dBus_rsp_ready(dBus_rsp_ready),
		.dBus_rsp_data(dBus_rsp_data),
		.dBus_rsp_error(1'b0),

		`RVFI_CONN
	);

`ifdef VEXRISCV_FAIRNESS
	(* keep *) reg [2:0] iBusCmdPendingCycles = 0;
	(* keep *) reg [2:0] iBusRspPendingCycles = 0;
	(* keep *) reg       iBusRspPendingValid = 0;
	(* keep *) reg [2:0] dBusCmdPendingCycles = 0;
	(* keep *) reg [2:0] dBusRspPendingCycles = 0;
	(* keep *) reg       dBusRspPendingValid = 0;
	always @(posedge clock) begin
		if(iBus_cmd_valid && !iBus_cmd_ready) begin
			iBusCmdPendingCycles <= iBusCmdPendingCycles + 1;
		end else begin
			iBusCmdPendingCycles <= 0;
		end

		if(iBusRspPendingValid <= 1) begin
			iBusRspPendingCycles <= iBusRspPendingCycles + 1;
		end
		if(iBus_rsp_ready) begin
			iBusRspPendingValid <= 0;
			iBusRspPendingCycles <= 0;
		end
		if(iBus_cmd_valid && iBus_cmd_ready && !iBus_cmd_payload_wr) begin
			iBusRspPendingValid <= 1;
		end

		if(dBus_cmd_valid && !dBus_cmd_ready) begin
			dBusCmdPendingCycles <= dBusCmdPendingCycles + 1;
		end else begin
			dBusCmdPendingCycles <= 0;
		end

		if(dBusRspPendingValid <= 1) begin
			dBusRspPendingCycles <= dBusRspPendingCycles + 1;
		end
		if(dBus_rsp_ready) begin
			dBusRspPendingValid <= 0;
			dBusRspPendingCycles <= 0;
		end
		if(dBus_cmd_valid && dBus_cmd_ready && !dBus_cmd_payload_wr) begin
			dBusRspPendingValid <= 1;
		end
		restrict(~rvfi_trap && dBusCmdPendingCycles < 4 && dBusRspPendingCycles < 4 && iBusCmdPendingCycles < 4 && iBusRspPendingCycles < 4);
	end
`endif
endmodule

