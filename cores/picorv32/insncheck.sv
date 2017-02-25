module testbench (
	input         clk,
	input         mem_ready,
	output        mem_valid,
	output        mem_instr,
	output [31:0] mem_addr,
	output [31:0] mem_wdata,
	output [3:0]  mem_wstrb,
	input  [31:0] mem_rdata
);
	`RFVI_WIRES

	reg resetn = 0;
	wire trap;

	always @(posedge clk)
		resetn <= 1;

	reg enable = 0;
	reg [7:0] cycle = 0;

	always @(posedge clk) begin
		if (~cycle)
			cycle <= cycle + 1;
		enable <= cycle == `RISCV_FORMAL_BMC_DEPTH;
	end

	rvfi_insn_check checker_inst (
		.clk    (clk   ),
		.enable (enable),
		`RFVI_CONN
	);

	picorv32 #(
		.COMPRESSED_ISA(1),
		.BARREL_SHIFTER(1)
	) uut (
		.clk       (clk      ),
		.resetn    (resetn   ),
		.trap      (trap     ),

		.mem_valid (mem_valid),
		.mem_instr (mem_instr),
		.mem_ready (mem_ready),
		.mem_addr  (mem_addr ),
		.mem_wdata (mem_wdata),
		.mem_wstrb (mem_wstrb),
		.mem_rdata (mem_rdata),

		`RFVI_CONN
	);

	reg [4:0] mem_wait = 0;
	always @(posedge clk) begin
		mem_wait <= {mem_wait, mem_valid && !mem_ready};
		// restrict(~mem_wait && !trap);
	end
endmodule

