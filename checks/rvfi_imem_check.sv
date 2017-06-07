module rvfi_imem_check (
	input clk,
	input resetn,
	output [`RISCV_FORMAL_XLEN-1:0] imem_addr, 
	output [15:0] imem_data, 
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_valid,
	input [`RISCV_FORMAL_NRET *                  8   - 1 : 0] rvfi_order,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_ILEN   - 1 : 0] rvfi_insn,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_trap,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_halt,
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_intr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs1_addr,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rs2_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs1_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rs2_rdata,
	input [`RISCV_FORMAL_NRET *                  5   - 1 : 0] rvfi_rd_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_rd_wdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_pc_wdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
	checker assign_free_variables;
		rand const bit [`RISCV_FORMAL_XLEN-1:0] imem_addr_randval;
		rand const bit [15:0] imem_data_randval;
		assign imem_addr = imem_addr_randval;
		assign imem_data = imem_data_randval;
	endchecker

	reg [`RISCV_FORMAL_XLEN-1:0] pc;
	reg [`RISCV_FORMAL_ILEN-1:0] insn;

	integer channel_idx;
	integer i;

	always @(posedge clk) begin
		for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
			if (resetn && rvfi_valid[channel_idx]) begin
				pc = rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
				insn = rvfi_insn[channel_idx*`RISCV_FORMAL_ILEN +: `RISCV_FORMAL_ILEN];

				if (pc == imem_addr)
					assert(insn[15:0] == imem_data);

				if (insn[1:0] == 2'b11 && pc+2 == imem_addr)
					assert(insn[31:16] == imem_data);
			end
		end
	end
endmodule
