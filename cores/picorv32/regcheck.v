module testbench (
	input clk,
	input [4:0] regselect,

	input         mem_ready,
	output        mem_valid,
	output        mem_instr,
	output [31:0] mem_addr,
	output [31:0] mem_wdata,
	output [3:0]  mem_wstrb,
	input  [31:0] mem_rdata,

);
	reg resetn = 0;
	wire trap;

	always @(posedge clk)
		resetn <= 1;

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
	integer i;
	reg [31:0] pc = 0;
	reg [31:0] cpuregs [0:31];

	initial begin
		for (i = 0; i < 32; i=i+1)
			cpuregs[i] = 0;
	end

	always @(posedge clk) begin
		if (resetn && rvfi_valid) begin
			assert(pc == rvfi_pre_pc);
			assert(cpuregs[rvfi_rs1] == rvfi_pre_rs1);
			assert(cpuregs[rvfi_rs2] == rvfi_pre_rs2);

			pc <= rvfi_post_pc;
			cpuregs[rvfi_rd] <= rvfi_post_rd;
		end
	end
`else
	reg [31:0] pc = 0;
	reg [4:0] selected_reg = 0;
	reg [31:0] selected_reg_val = 0;

	always @(posedge clk) begin
		if (!resetn) begin
			selected_reg <= regselect;
		end else
		if (rvfi_valid) begin
			assert(pc == rvfi_pre_pc);

			if (rvfi_rs1 == selected_reg)
				assert(selected_reg_val == rvfi_pre_rs1);

			if (rvfi_rs2 == selected_reg)
				assert(selected_reg_val == rvfi_pre_rs2);

			pc <= rvfi_post_pc;

			if (rvfi_rd == selected_reg)
				selected_reg_val <= rvfi_post_rd;
		end
	end
`endif

	picorv32 #(
		.REGS_INIT_ZERO(1),
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

