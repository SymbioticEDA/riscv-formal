module testbench (
	input clk,

	input         mem_ready,
	output        mem_valid,
	output        mem_instr,
	output [31:0] mem_addr,
	output [31:0] mem_wdata,
	output [3:0]  mem_wstrb,
	input  [31:0] mem_rdata
);
	reg resetn = 0;
	wire trap;

	always @(posedge clk)
		resetn <= 1;

	`RVFI_WIRES

	rvfi_reg_check #(
		.ZERO_INIT(1)
	) checker_inst (
		.clk    (clk   ),
		.resetn (resetn),
		`RVFI_CONN
	);

	picorv32 #(
		.REGS_INIT_ZERO(1),
		.COMPRESSED_ISA(1),
		.BARREL_SHIFTER(1)
	) uut (
		.clk            (clk           ),
		.resetn         (resetn        ),
		.trap           (trap          ),

		.mem_valid      (mem_valid     ),
		.mem_instr      (mem_instr     ),
		.mem_ready      (mem_ready     ),
		.mem_addr       (mem_addr      ),
		.mem_wdata      (mem_wdata     ),
		.mem_wstrb      (mem_wstrb     ),
		.mem_rdata      (mem_rdata     ),

		`RVFI_CONN
	);

	reg [4:0] mem_wait = 0;
	always @(posedge clk) begin
		mem_wait <= {mem_wait, mem_valid && !mem_ready};
		// restrict(~mem_wait && !trap);
	end
endmodule

