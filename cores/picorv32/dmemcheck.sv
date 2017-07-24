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

	wire [31:0] dmem_addr;
	reg [31:0] dmem_data;

	rvfi_dmem_check checker_inst (
		.clock     (clk      ),
		.reset     (!resetn  ),
		.enable    (1'b1     ),
		.dmem_addr (dmem_addr),
		`RVFI_CONN
	);

	always @(posedge clk) begin
		if (resetn && mem_valid && mem_ready && mem_addr == dmem_addr) begin
			if (mem_wstrb[0]) dmem_data[ 7: 0] <= mem_wdata[ 7: 0];
			if (mem_wstrb[1]) dmem_data[15: 8] <= mem_wdata[15: 8];
			if (mem_wstrb[2]) dmem_data[23:16] <= mem_wdata[23:16];
			if (mem_wstrb[3]) dmem_data[31:24] <= mem_wdata[31:24];
		end
	end

	always @* begin
		if (resetn && mem_valid && mem_ready && mem_addr == dmem_addr && !mem_wstrb)
			assume(dmem_data == mem_rdata);
	end

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

