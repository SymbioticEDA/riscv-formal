`define RISCV_FORMAL
`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ILEN 32
`define RISCV_FORMAL_ALIGNED_MEM
`include "rvfi_macros.vh"
`include "rvfi_channel.sv"
`include "rvfi_dmem_check.sv"

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

	(* keep *) wire [31:0] dmem_addr;
	(* keep *) reg [31:0] dmem_data;

	rvfi_dmem_check checker_inst (
		.clock     (clk      ),
		.reset     (reset  ),
		.enable    (1'b1     ),
		.dmem_addr (dmem_addr),
		`RVFI_CONN
	);

	(* keep *) reg dmem_last_valid;
	(* keep *) wire [3:0] dBus_cmd_payload_mask;

	assign dBus_cmd_payload_mask = ((1 << (1 << dBus_cmd_payload_size))-1) << dBus_cmd_payload_address[1:0];

	


	always @(posedge clk) begin
		if (reset) begin
			dmem_last_valid <= 0;
		end else begin
			if(dmem_last_valid) begin
				assume(dBus_rsp_data == dmem_data);
			end
			if(dBus_rsp_ready) begin
				dmem_last_valid <= 0;
			end
			if(dBus_cmd_valid && dBus_cmd_ready) begin
				if((dBus_cmd_payload_address >> 2) == (dmem_addr >> 2)) begin
					if(!dBus_cmd_payload_wr) begin
						dmem_last_valid <= 1;
					end else begin
						if (dBus_cmd_payload_mask[0]) dmem_data[ 7: 0] <= dBus_cmd_payload_data[ 7: 0];
						if (dBus_cmd_payload_mask[1]) dmem_data[15: 8] <= dBus_cmd_payload_data[15: 8];
						if (dBus_cmd_payload_mask[2]) dmem_data[23:16] <= dBus_cmd_payload_data[23:16];
						if (dBus_cmd_payload_mask[3]) dmem_data[31:24] <= dBus_cmd_payload_data[31:24];
					end
				end
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

