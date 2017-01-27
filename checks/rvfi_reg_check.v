module rvfi_reg_check #(
	parameter [0:0] ZERO_INIT = 0
) (
	input clk,
	input resetn,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,
	input [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order,
	input [`RISCV_FORMAL_NRET *                 32   - 1 : 0] rvfi_insn,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs1,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pre_rs2,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_pc,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_post_rd,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
	wire [4:0] register_index = $anyconst;
	reg [`RISCV_FORMAL_XLEN-1:0] register_shadow = 0;
	reg register_written = ZERO_INIT;

	integer channel_idx;
	always @(posedge clk) begin
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (resetn && rvfi_valid[channel_idx]) begin
				if (register_written) begin
					if (register_index == rvfi_rs1[channel_idx*5 +: 5])
						assert(register_shadow == rvfi_pre_rs1[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
					if (register_index == rvfi_rs2[channel_idx*5 +: 5])
						assert(register_shadow == rvfi_pre_rs2[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN]);
				end
				if (register_index == rvfi_rd[channel_idx*5 +: 5]) begin
					register_shadow = rvfi_post_rd[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
					register_written = 1;
				end
			end
		end
	end
endmodule
