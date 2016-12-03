module testbench (
	input clk,
	input mem_ready,
	input [31:0] any_rdata
);
	reg resetn = 0;
	wire trap;

	always @(posedge clk)
		resetn <= 1;

	wire        mem_valid;
	wire        mem_instr;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0]  mem_wstrb;
	wire [31:0] mem_rdata;

	wire        rvfi_valid;
	wire [4:0]  rvfi_rs1;
	wire [4:0]  rvfi_rs2;
	wire [4:0]  rvfi_rd;
	wire [31:0] rvfi_insn;
	wire [31:0] rvfi_pre_pc;
	wire [31:0] rvfi_pre_rs1;
	wire [31:0] rvfi_pre_rs2;
	wire [31:0] rvfi_post_pc;
	wire [31:0] rvfi_post_rd;

`ifdef NAIVE_IMPLEMENTATION
	reg [15:0] memory [0:1023];

	assign mem_rdata = (mem_ready && mem_valid) ? {memory[mem_addr[10:1]+10'd1], memory[mem_addr[10:1]]} : any_rdata;

	always @(posedge clk) begin
		if (resetn && rvfi_valid) begin
			if (rvfi_insn[1:0] == 2'b11)
				assert(rvfi_insn[31:16] == memory[rvfi_pre_pc[10:1]+10'd1]);
			assert(rvfi_insn[15:0] == memory[rvfi_pre_pc[10:1]]);
		end
	end
`else
	reg [15:0] selected_halfword_value = $anyconst;
	reg [31:0] selected_halfword_addr = $anyconst;

	always @(posedge clk) begin
		if (resetn) begin
			if (mem_ready && mem_valid) begin
				if (mem_addr == selected_halfword_addr)
					assume(selected_halfword_value == mem_rdata[15:0]);
				if (mem_addr+2 == selected_halfword_addr)
					assume(selected_halfword_value == mem_rdata[31:16]);
			end
			if (rvfi_valid) begin
				if (rvfi_pre_pc == selected_halfword_addr)
					assert(selected_halfword_value == rvfi_insn[15:0]);
				if (rvfi_pre_pc+2 == selected_halfword_addr && rvfi_insn[1:0] == 2'b11)
					assert(selected_halfword_value == rvfi_insn[31:16]);
			end
		end
	end
`endif

	picorv32 #(
		.COMPRESSED_ISA(0),
		.BARREL_SHIFTER(1)
	) uut (
		.clk          (clk         ),
		.resetn       (resetn      ),
		.trap         (trap        ),

		.mem_valid    (mem_valid   ),
		.mem_instr    (mem_instr   ),
		.mem_ready    (mem_ready   ),
		.mem_addr     (mem_addr    ),
		.mem_wdata    (mem_wdata   ),
		.mem_wstrb    (mem_wstrb   ),
		.mem_rdata    (mem_rdata   ),

		.rvfi_valid   (rvfi_valid  ),
		.rvfi_rs1     (rvfi_rs1    ),
		.rvfi_rs2     (rvfi_rs2    ),
		.rvfi_rd      (rvfi_rd     ),
		.rvfi_insn    (rvfi_insn   ),
		.rvfi_pre_pc  (rvfi_pre_pc ),
		.rvfi_pre_rs1 (rvfi_pre_rs1),
		.rvfi_pre_rs2 (rvfi_pre_rs2),
		.rvfi_post_pc (rvfi_post_pc),
		.rvfi_post_rd (rvfi_post_rd)
	);

	reg [4:0] mem_wait = 0;
	always @(posedge clk) begin
		mem_wait <= {mem_wait, mem_valid && !mem_ready};
		// restrict(~mem_wait && !trap);
	end
endmodule

