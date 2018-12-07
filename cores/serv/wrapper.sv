module rvfi_wrapper (
	input clock,
	input reset,
	`RVFI_OUTPUTS
);
	// I-MEM
	(* keep *)      wire [31:0] ibus_adr;
	(* keep *)      wire        ibus_cyc;
	(* keep *) rand reg  [31:0] ibus_rdt;
	(* keep *) rand reg         ibus_ack;

	// D-MEM
	(* keep *)      wire [31:0] dbus_adr;
	(* keep *)      wire [31:0] dbus_dat;
	(* keep *)      wire [3:0]  dbus_sel;
	(* keep *)      wire        dbus_we;
	(* keep *)      wire        dbus_cyc;
	(* keep *) rand reg  [31:0] dbus_rdt;
	(* keep *) rand reg         dbus_ack;

	serv_top uut (
		.clk(clock),
		.i_rst(reset),
		.i_timer_irq(1'b0),

		`RVFI_CONN,

		.o_ibus_adr(ibus_adr),
		.o_ibus_cyc(ibus_cyc),
		.i_ibus_rdt(ibus_rdt),
		.i_ibus_ack(ibus_ack),
		.o_dbus_adr(dbus_adr),
		.o_dbus_dat(dbus_dat),
		.o_dbus_sel(dbus_sel),
		.o_dbus_we (dbus_we ),
		.o_dbus_cyc(dbus_cyc),
		.i_dbus_rdt(dbus_rdt),
		.i_dbus_ack(dbus_ack)
	);

	// I-MEM
	always @(posedge clock) begin
		if (reset) begin
			assume (!ibus_ack);
		end
		if (!ibus_cyc) begin
			assume (!ibus_ack);
		end
	end

	// D-MEM
	always @(posedge clock) begin
		if (reset) begin
			assume (!dbus_ack);
		end
		if (!dbus_cyc) begin
			assume (!dbus_ack);
		end
	end

`ifdef MEMIO_FAIRNESS
	reg [2:0] timeout_ibus = 0;
	reg [2:0] timeout_dbus = 0;

	always @(posedge clock) begin
		timeout_ibus <= 0;
		timeout_dbus <= 0;

		if (ibus_cyc && !ibus_ack)
			timeout_ibus <= timeout_ibus + 1;

		if (dbus_cyc && !dbus_ack)
			timeout_dbus <= timeout_dbus + 1;

		assume (!timeout_ibus[2]);
		assume (!timeout_dbus[2]);
	end
`endif
endmodule
