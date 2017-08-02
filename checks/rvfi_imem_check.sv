module rvfi_imem_check (
	input clock, reset, enable,
	output [`RISCV_FORMAL_XLEN-1:0] imem_addr,
	output [15:0] imem_data,
	`RVFI_INPUTS
);
	`formal_anyconst [`RISCV_FORMAL_XLEN-1:0] imem_addr_randval;
	`formal_anyconst [15:0] imem_data_randval;
	assign imem_addr = imem_addr_randval;
	assign imem_data = imem_data_randval;

	reg [`RISCV_FORMAL_XLEN-1:0] pc;
	reg [`RISCV_FORMAL_ILEN-1:0] insn;

	integer channel_idx;
	integer i;

	always @(posedge clock) begin
		if (reset) begin
		end else begin
			for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin
				if (enable && rvfi_valid[channel_idx]) begin
					pc = rvfi_pc_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
					insn = rvfi_insn[channel_idx*`RISCV_FORMAL_ILEN +: `RISCV_FORMAL_ILEN];

					if (pc == imem_addr)
						assert(insn[15:0] == imem_data);

					if (insn[1:0] == 2'b11 && pc+2 == imem_addr)
						assert(insn[31:16] == imem_data);
				end
			end
		end
	end
endmodule
