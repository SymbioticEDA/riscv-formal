`define RISCV_FORMAL
`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ILEN 32
`include "rvfi_macros.vh"
`include "rvfi_channel.sv"
`include "rvfi_imem_check.sv"

module testbench (
	input clk
);
	reg reset = 1;

	always @(posedge clk)
		reset <= 0;




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



	`RVFI_WIRES

	(* keep *) wire [31:0] imem_addr;
	(* keep *) wire [15:0] imem_data;

	rvfi_imem_check checker_inst (
		.clock     (clk      ),
		.reset     (reset  ),
		.enable    (1'b1     ),
		.imem_addr (imem_addr),
		.imem_data (imem_data),
		`RVFI_CONN
	);

	(* keep *) wire imem_last_valid;
	(* keep *) wire [31:0] imem_last_addr;

	always @(posedge clk) begin
		if (reset) begin
			imem_last_valid <= 0;
		end else begin
			if(imem_last_valid) begin
				if (imem_last_addr == imem_addr)
					assume(iBus_rsp_inst[15:0] == imem_data);
				if (imem_last_addr+2 == imem_addr)
					assume(iBus_rsp_inst[31:16] == imem_data);
			end
			if(iBus_rsp_ready) begin
				imem_last_valid <= 0;
			end
			if(iBus_cmd_valid && iBus_cmd_ready) begin
				imem_last_valid <= 1;
				imem_last_addr <= iBus_cmd_payload_pc;
			end
		end
		
	end





	VexRiscv uut (
		.clk       (clk    ),
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

endmodule

