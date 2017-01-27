module rvfi_pc_check (
	input clk,
	input resetn,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,
	input [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order,
	input [`RISCV_FORMAL_NRET *                 32   - 1 : 0] rvfi_insn,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
	reg [`RISCV_FORMAL_XLEN-1:0] pc_shadow = 0;
	reg pc_written = 0;

	integer channel_idx;
	always @(posedge clk) begin
		if (!resetn) begin
			pc_written = 0;
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (rvfi_valid[channel_idx]) begin
					if (pc_written)
						assert(pc_shadow == rvfi_pre_pc[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
					pc_shadow = rvfi_post_pc[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
					pc_written = 1;
				end
			end
		end
	end
endmodule
