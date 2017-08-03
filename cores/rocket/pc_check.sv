module testbench (
	input clk, rst
);
	`RVFI_WIRES

`ifdef YOSYS
	assume property (rst == $initstate);
`endif

	reg [7:0] cycle_reg = 0;
	wire [7:0] cycle = rst ? 0 : cycle_reg;

	always @(posedge clk) begin
		cycle_reg <= rst ? 1 : cycle_reg + (cycle_reg != 255);
	end

	wire reset = cycle <= 5;

	`RISCV_FORMAL_CHECKER checker_inst (
		.clock  (clk   ),
		.reset  (cycle < `RISCV_FORMAL_BMC_START),
		.check  (cycle == `RISCV_FORMAL_BMC_DEPTH),
		`RVFI_CONN
	);

	rocket_wrapper uut (
		.clock (clk  ),
		.reset (reset),
		`RVFI_CONN
	);
endmodule

// Check PC for when we retire the insn with a higher order number in the later cycle
module rvfi_pc_check_fwd (
	input clock, reset, check,
	`RVFI_INPUTS
);

`formal_anyconst [7:0] prev_order;
wire [7:0] next_order = prev_order + 1;

reg [`RISCV_FORMAL_XLEN-1:0] next_pc_rdata;
reg next_pc_rdata_valid;

reg [`RISCV_FORMAL_XLEN-1:0] prev_pc_wdata;
reg prev_pc_wdata_valid;

always @(posedge clock) begin
	if (!reset && check) begin
		assume (rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
		assume (next_order == rvfi_order[8*`RISCV_FORMAL_CHANNEL_IDX +: 8]);
		next_pc_rdata <= rvfi_pc_rdata[`RISCV_FORMAL_XLEN*`RISCV_FORMAL_CHANNEL_IDX +: `RISCV_FORMAL_XLEN];
		next_pc_rdata_valid <= 1;
	end else begin
		next_pc_rdata_valid <= 0;
	end
end

integer channel_idx;
always @(posedge clock) begin
	if (reset) begin
		prev_pc_wdata <= 0;
		prev_pc_wdata_valid <= 0;
	end else begin
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (rvfi_valid[channel_idx] && prev_order == rvfi_order[8*channel_idx +: 8]) begin
				prev_pc_wdata <= rvfi_pc_wdata[`RISCV_FORMAL_XLEN*channel_idx +: `RISCV_FORMAL_XLEN];
				prev_pc_wdata_valid <= 1;
			end
		end
	end
end

always @* begin
	if (!reset && next_pc_rdata_valid && prev_pc_wdata_valid)
		assert(next_pc_rdata == prev_pc_wdata);
end
endmodule

// Check PC for when we retire the insn with a lower order number in the later cycle
module rvfi_pc_check_bwd (
	input clock, reset, check,
	`RVFI_INPUTS
);

`formal_anyconst [7:0] prev_order;
wire [7:0] next_order = prev_order + 1;

reg [`RISCV_FORMAL_XLEN-1:0] next_pc_rdata;
reg next_pc_rdata_valid;

reg [`RISCV_FORMAL_XLEN-1:0] prev_pc_wdata;
reg prev_pc_wdata_valid;

always @(posedge clock) begin
	if (!reset && check) begin
		assume (rvfi_valid[`RISCV_FORMAL_CHANNEL_IDX]);
		assume (prev_order == rvfi_order[8*`RISCV_FORMAL_CHANNEL_IDX +: 8]);
		prev_pc_wdata <= rvfi_pc_wdata[`RISCV_FORMAL_XLEN*`RISCV_FORMAL_CHANNEL_IDX +: `RISCV_FORMAL_XLEN];
		prev_pc_wdata_valid <= 1;
	end else begin
		prev_pc_wdata_valid <= 0;
	end
end

integer channel_idx;
always @(posedge clock) begin
	if (reset) begin
		next_pc_rdata <= 0;
		next_pc_rdata_valid <= 0;
	end else begin
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (rvfi_valid[channel_idx] && next_order == rvfi_order[8*channel_idx +: 8]) begin
				next_pc_rdata <= rvfi_pc_rdata[`RISCV_FORMAL_XLEN*channel_idx +: `RISCV_FORMAL_XLEN];
				next_pc_rdata_valid <= 1;
			end
		end
	end
end

always @* begin
	if (!reset && next_pc_rdata_valid && prev_pc_wdata_valid)
		assert(next_pc_rdata == prev_pc_wdata);
end
endmodule

