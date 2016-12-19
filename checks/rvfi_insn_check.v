module rvfi_insn_check (
	input clk,
	input enable,
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
	input [`RISCV_FORMAL_NRET                        - 1 : 0] rvfi_post_trap,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_addr,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_rmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN/8 - 1 : 0] rvfi_mem_wmask,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_rdata,
	input [`RISCV_FORMAL_NRET * `RISCV_FORMAL_XLEN   - 1 : 0] rvfi_mem_wdata
);
`ifdef RISCV_FORMAL_CHANNEL_IDX
	localparam integer channel_idx = `RISCV_FORMAL_CHANNEL_IDX;
`else
	genvar channel_idx;
	generate for (channel_idx = 0; channel_idx < `RISCV_FORMAL_NRET; channel_idx=channel_idx+1) begin:channel
`endif
		(* keep *) wire valid = enable && rvfi_valid[channel_idx];
		(* keep *) wire [31:0] insn = rvfi_insn[channel_idx*32 +: 32];
		(* keep *) wire [4:0] rs1 = rvfi_rs1[channel_idx*5 +: 5];
		(* keep *) wire [4:0] rs2 = rvfi_rs2[channel_idx*5 +: 5];
		(* keep *) wire [4:0] rd = rvfi_rd[channel_idx*5 +: 5];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] pre_pc = rvfi_pre_pc[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] pre_rs1 = rvfi_pre_rs1[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] pre_rs2 = rvfi_pre_rs2[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] post_pc = rvfi_post_pc[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] post_rd = rvfi_post_rd[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire post_trap = rvfi_post_trap[channel_idx];

		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] mem_addr = rvfi_mem_addr[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8-1:0] mem_rmask = rvfi_mem_rmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN/8-1:0] mem_wmask = rvfi_mem_wmask[channel_idx*`RISCV_FORMAL_XLEN/8 +: `RISCV_FORMAL_XLEN/8];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] mem_rdata = rvfi_mem_rdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];
		(* keep *) wire [`RISCV_FORMAL_XLEN-1:0] mem_wdata = rvfi_mem_wdata[channel_idx*`RISCV_FORMAL_XLEN +: `RISCV_FORMAL_XLEN];

		(* keep *) reg ref_valid;
		(* keep *) reg [4:0] ref_rs1;
		(* keep *) reg [4:0] ref_rs2;
		(* keep *) reg [4:0] ref_rd;
		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] ref_post_rd;
		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] ref_post_pc;
		(* keep *) reg ref_post_trap;

		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] ref_mem_addr;
		(* keep *) reg [`RISCV_FORMAL_XLEN/8-1:0] ref_mem_rmask;
		(* keep *) reg [`RISCV_FORMAL_XLEN/8-1:0] ref_mem_wmask;
		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] ref_mem_wdata;

		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] insn_imm;
		(* keep *) reg [4:0] insn_rs1;
		(* keep *) reg [4:0] insn_rs2;
		(* keep *) reg [4:0] insn_rd;
		(* keep *) reg [6:0] insn_opcode;
		(* keep *) reg [4:0] insn_funct3;
		(* keep *) reg [6:0] insn_funct7;
		(* keep *) reg [4:0] insn_shamt;

		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] addr;
		(* keep *) reg [`RISCV_FORMAL_XLEN-1:0] result;
		(* keep *) reg cond;

		integer i;

		always @* begin
			ref_valid = 0;
			ref_rs1 = 0;
			ref_rs2 = 0;
			ref_rd = 0;
			ref_post_pc = 0;
			ref_post_rd = 0;
			ref_post_trap = 0;

			ref_mem_addr = 0;
			ref_mem_rmask = 0;
			ref_mem_wmask = 0;
			ref_mem_wdata = 0;

			insn_imm = 'bx;
			insn_rs1 = 'bx;
			insn_rs2 = 'bx;
			insn_rd = 'bx;
			insn_opcode = 'bx;
			insn_funct3 = 'bx;
			insn_funct7 = 'bx;
			insn_shamt = 'bx;

			addr = 'bx;
			result = 'bx;
			cond = 'bx;

			`include `RISCV_FORMAL_INSN_VH

			if (ref_valid) begin
				if (ref_rs1)
					assert(ref_rs1 == rs1);

				if (ref_rs2)
					assert(ref_rs2 == rs2);

				if (!ref_post_trap) begin
					assert(ref_rd == rd);
					assert(ref_post_rd == post_rd);
					assert(ref_post_pc == post_pc);

					if (ref_mem_wmask || ref_mem_rmask) begin
						assert(ref_mem_addr == mem_addr);
					end

					for (i = 0; i < `RISCV_FORMAL_XLEN/8; i = i+1) begin
						if (ref_mem_wmask[i]) begin
							assert(mem_wmask[i]);
							assert(ref_mem_wdata[i*8 +: 8] == mem_wdata[i*8 +: 8]);
						end else if (mem_wmask[i]) begin
							assert(mem_rmask[i]);
							assert(mem_rdata[i*8 +: 8] == mem_wdata[i*8 +: 8]);
						end
						if (ref_mem_rmask[i]) begin
							assert(mem_rmask[i]);
						end
					end
				end

				assert(ref_post_trap == post_trap);
			end
		end
`ifndef RISCV_FORMAL_CHANNEL_IDX
	end endgenerate
`endif
endmodule
