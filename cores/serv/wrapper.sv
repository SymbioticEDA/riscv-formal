module rvfi_wrapper (
	input clock,
	input reset,
	`RVFI_OUTPUTS
);
	// I-MEM
	(* keep *)      wire [31:0] o_i_ca_adr;
	(* keep *)      wire        o_i_ca_vld;
	(* keep *) rand reg         i_i_ca_rdy;

	(* keep *) rand reg  [31:0] i_i_rd_dat;
	(* keep *) rand reg         i_i_rd_vld;
	(* keep *)      wire        o_i_rd_rdy;

	// D-MEM
	(* keep *)      wire        o_d_ca_cmd;
	(* keep *)      wire [31:0] o_d_ca_adr;
	(* keep *)      wire        o_d_ca_vld;
	(* keep *) rand reg         i_d_ca_rdy;

	(* keep *)      wire [31:0] o_d_dm_dat;
	(* keep *)      wire [3:0]  o_d_dm_msk;
	(* keep *)      wire        o_d_dm_vld;
	(* keep *) rand reg         i_d_dm_rdy;

	(* keep *) rand reg  [31:0] i_d_rd_dat;
	(* keep *) rand reg         i_d_rd_vld;
	(* keep *)      wire        o_d_rd_rdy;

	serv_top uut (
		.clk(clock),
		`RVFI_CONN,

		.o_i_ca_adr (o_i_ca_adr),
		.o_i_ca_vld (o_i_ca_vld),
		.i_i_ca_rdy (i_i_ca_rdy),

		.i_i_rd_dat (i_i_rd_dat),
		.i_i_rd_vld (i_i_rd_vld),
		.o_i_rd_rdy (o_i_rd_rdy),

		.o_d_ca_cmd (o_d_ca_cmd),
		.o_d_ca_adr (o_d_ca_adr),
		.o_d_ca_vld (o_d_ca_vld),
		.i_d_ca_rdy (i_d_ca_rdy),

		.o_d_dm_dat (o_d_dm_dat),
		.o_d_dm_msk (o_d_dm_msk),
		.o_d_dm_vld (o_d_dm_vld),
		.i_d_dm_rdy (i_d_dm_rdy),

		.i_d_rd_dat (i_d_rd_dat),
		.i_d_rd_vld (i_d_rd_vld),
		.o_d_rd_rdy (o_d_rd_rdy)
	);

	integer icnt = 0;
	integer dcnt = 0;

	// I-MEM
	always @(posedge clock) begin
		if (reset) begin
			assume (i_i_ca_rdy == 0);
			assume (i_i_rd_vld == 0);
		end

		// do not "take back" rdy
		if ($past(i_i_ca_rdy) && !$past(o_i_ca_vld)) begin
			assume (i_i_ca_rdy);
		end

		// do not send data without active request
		if (icnt == 0 && !(i_i_ca_rdy && o_i_ca_vld)) begin
			assume (!i_i_rd_vld);
		end

		// count number of active requests
		icnt <= icnt + (i_i_ca_rdy && o_i_ca_vld) - (i_i_rd_vld && o_i_rd_rdy);
	end

	// D-MEM
	always @(posedge clock) begin
		if (reset) begin
			assume (i_d_ca_rdy == 0);
			assume (i_d_dm_rdy == 0);
			assume (i_d_rd_vld == 0);
		end

		// do not "take back" rdy on ca channel
		if ($past(i_d_ca_rdy) && !$past(o_d_ca_vld)) begin
			assume (i_d_ca_rdy);
		end

		// do not "take back" rdy on dm channel
		if ($past(i_d_dm_rdy) && !$past(o_d_dm_vld)) begin
			assume (i_d_dm_rdy);
		end

		// do not send data without active read request
		if (dcnt == 0 && !(i_d_ca_rdy && o_d_ca_vld && !o_d_ca_cmd)) begin
			assume (!i_d_rd_vld);
		end

		// count number of active read requests
		dcnt <= dcnt + (i_d_ca_rdy && o_d_ca_vld && !o_d_ca_cmd) - (i_d_rd_vld && o_d_rd_rdy);
	end

`ifdef MEMIO_FAIRNESS
	reg [1:0] timeout_i_ca = 0;
	reg [1:0] timeout_i_rd = 0;
	reg [1:0] timeout_d_ca = 0;
	reg [1:0] timeout_d_dm = 0;
	reg [1:0] timeout_d_rd = 0;

	always @(posedge clock) begin
		timeout_i_ca <= 0;
		timeout_i_rd <= 0;
		timeout_d_ca <= 0;
		timeout_d_dm <= 0;
		timeout_d_rd <= 0;

		if (o_i_ca_vld && !i_i_ca_rdy)
			timeout_i_ca <= timeout_i_ca + 1;

		if (icnt && !i_i_rd_vld)
			timeout_i_rd <= timeout_i_rd + 1;

		if (o_d_ca_vld && !i_d_ca_rdy)
			timeout_d_ca <= timeout_d_ca + 1;

		if (o_d_dm_vld && !i_d_dm_rdy)
			timeout_d_dm <= timeout_d_dm + 1;

		if (dcnt && !i_d_rd_vld)
			timeout_d_rd <= timeout_d_rd + 1;

		assume (timeout_i_ca != 3);
		assume (timeout_i_rd != 3);
		assume (timeout_d_ca != 3);
		assume (timeout_d_dm != 3);
		assume (timeout_d_rd != 3);
	end
`endif
endmodule
