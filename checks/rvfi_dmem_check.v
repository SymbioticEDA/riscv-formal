module rvfi_dmem_check (
	input clk,
	input resetn,
	output [`RISCV_FORMAL_XLEN-1:0] dmem_addr, 
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
	assign dmem_addr = $anyconst;
	reg [`RISCV_FORMAL_XLEN-1:0] dmem_shadow;
	reg [`RISCV_FORMAL_XLEN/8-1:0] dmem_written = 0;

	integer channel_idx;
	integer i;

	always @(posedge clk) begin
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (resetn && rvfi_valid[channel_idx] && rvfi_mem_addr[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN] == dmem_addr) begin
				for (i = 0; i < `RISCV_FORMAL_XLEN/8; i = i+1) begin
					if (rvfi_mem_rmask[channel_idx*`RISCV_FORMAL_XLEN/8 + i] && dmem_written[i])
						assert(dmem_shadow[i*8 +: 8] == rvfi_mem_rdata[i*8 +: 8]);
					if (rvfi_mem_wmask[channel_idx*`RISCV_FORMAL_XLEN/8 + i]) begin
						dmem_shadow[i*8 +: 8] = rvfi_mem_wdata[i*8 +: 8];
						dmem_written[i] = 1;
					end
				end
			end
		end
	end
endmodule
