module top (
	input [31:0] insn, pc, rdata, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
	input [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31
);
	(* keep *) wire [31:0] npc, nx1, nx2, nx3, nx4, nx5, nx6, nx7, nx8, nx9, nx10, nx11, nx12, nx13, nx14, nx15;
	(* keep *) wire [31:0] nx16, nx17, nx18, nx19, nx20, nx21, nx22, nx23, nx24, nx25, nx26, nx27, nx28, nx29, nx30, nx31;

	(* keep *) wire [ 3:0] ren;
	(* keep *) wire [31:0] raddr;

	(* keep *) wire [ 3:0] wen;
	(* keep *) wire [31:0] waddr;
	(* keep *) wire [31:0] wdata;

	(* keep *) wire        excep;

	(* keep *) wire        rvfi_valid = 1;
	(* keep *) wire [31:0] rvfi_insn = insn;
	(* keep *) wire [31:0] rvfi_pc_rdata = pc;
	(* keep *) reg  [31:0] rvfi_rs1_rdata;
	(* keep *) reg  [31:0] rvfi_rs2_rdata;
	(* keep *) wire [31:0] rvfi_mem_rdata = rdata;

	(* keep *) wire        spec_valid;
	(* keep *) wire        spec_trap;
	(* keep *) wire [ 4:0] spec_rs1_addr;
	(* keep *) wire [ 4:0] spec_rs2_addr;
	(* keep *) wire [ 4:0] spec_rd_addr;
	(* keep *) wire [31:0] spec_rd_wdata;
	(* keep *) wire [31:0] spec_pc_wdata;
	(* keep *) wire [31:0] spec_mem_addr;
	(* keep *) wire [ 3:0] spec_mem_rmask;
	(* keep *) wire [ 3:0] spec_mem_wmask;
	(* keep *) wire [31:0] spec_mem_wdata;

	always @* begin
		assume (pc[1:0] == 0);
	end

	always @* begin
		rvfi_rs1_rdata = 0;
		case (spec_rs1_addr)
			 1: rvfi_rs1_rdata =  x1;
			 2: rvfi_rs1_rdata =  x2;
			 3: rvfi_rs1_rdata =  x3;
			 4: rvfi_rs1_rdata =  x4;
			 5: rvfi_rs1_rdata =  x5;
			 6: rvfi_rs1_rdata =  x6;
			 7: rvfi_rs1_rdata =  x7;
			 8: rvfi_rs1_rdata =  x8;
			 9: rvfi_rs1_rdata =  x9;
			10: rvfi_rs1_rdata = x10;
			11: rvfi_rs1_rdata = x11;
			12: rvfi_rs1_rdata = x12;
			13: rvfi_rs1_rdata = x13;
			14: rvfi_rs1_rdata = x14;
			15: rvfi_rs1_rdata = x15;
			16: rvfi_rs1_rdata = x16;
			17: rvfi_rs1_rdata = x17;
			18: rvfi_rs1_rdata = x18;
			19: rvfi_rs1_rdata = x19;
			20: rvfi_rs1_rdata = x20;
			21: rvfi_rs1_rdata = x21;
			22: rvfi_rs1_rdata = x22;
			23: rvfi_rs1_rdata = x23;
			24: rvfi_rs1_rdata = x24;
			25: rvfi_rs1_rdata = x25;
			26: rvfi_rs1_rdata = x26;
			27: rvfi_rs1_rdata = x27;
			28: rvfi_rs1_rdata = x28;
			29: rvfi_rs1_rdata = x29;
			30: rvfi_rs1_rdata = x30;
			31: rvfi_rs1_rdata = x31;
		endcase

		rvfi_rs2_rdata = 0;
		case (spec_rs2_addr)
			 1: rvfi_rs2_rdata =  x1;
			 2: rvfi_rs2_rdata =  x2;
			 3: rvfi_rs2_rdata =  x3;
			 4: rvfi_rs2_rdata =  x4;
			 5: rvfi_rs2_rdata =  x5;
			 6: rvfi_rs2_rdata =  x6;
			 7: rvfi_rs2_rdata =  x7;
			 8: rvfi_rs2_rdata =  x8;
			 9: rvfi_rs2_rdata =  x9;
			10: rvfi_rs2_rdata = x10;
			11: rvfi_rs2_rdata = x11;
			12: rvfi_rs2_rdata = x12;
			13: rvfi_rs2_rdata = x13;
			14: rvfi_rs2_rdata = x14;
			15: rvfi_rs2_rdata = x15;
			16: rvfi_rs2_rdata = x16;
			17: rvfi_rs2_rdata = x17;
			18: rvfi_rs2_rdata = x18;
			19: rvfi_rs2_rdata = x19;
			20: rvfi_rs2_rdata = x20;
			21: rvfi_rs2_rdata = x21;
			22: rvfi_rs2_rdata = x22;
			23: rvfi_rs2_rdata = x23;
			24: rvfi_rs2_rdata = x24;
			25: rvfi_rs2_rdata = x25;
			26: rvfi_rs2_rdata = x26;
			27: rvfi_rs2_rdata = x27;
			28: rvfi_rs2_rdata = x28;
			29: rvfi_rs2_rdata = x29;
			30: rvfi_rs2_rdata = x30;
			31: rvfi_rs2_rdata = x31;
		endcase
	end

	always @* begin
		if (spec_valid) begin
			if (spec_trap) begin
				assert ( nx1 ==  x1);
				assert ( nx2 ==  x2);
				assert ( nx3 ==  x3);
				assert ( nx4 ==  x4);
				assert ( nx5 ==  x5);
				assert ( nx6 ==  x6);
				assert ( nx7 ==  x7);
				assert ( nx8 ==  x8);
				assert ( nx9 ==  x9);
				assert (nx10 == x10);
				assert (nx11 == x11);
				assert (nx12 == x12);
				assert (nx13 == x13);
				assert (nx14 == x14);
				assert (nx15 == x15);
				assert (nx16 == x16);
				assert (nx17 == x17);
				assert (nx18 == x18);
				assert (nx19 == x19);
				assert (nx20 == x20);
				assert (nx21 == x21);
				assert (nx22 == x22);
				assert (nx23 == x23);
				assert (nx24 == x24);
				assert (nx25 == x25);
				assert (nx26 == x26);
				assert (nx27 == x27);
				assert (nx28 == x28);
				assert (nx29 == x29);
				assert (nx30 == x30);
				assert (nx31 == x31);
				assert (npc == 32'h0);
				assert (ren == 1'b0);
				assert (wen == 1'b0);
				assert (excep);
			end else begin
				assert ( nx1 == (spec_rd_addr ==  1 ? spec_rd_wdata :  x1));
				assert ( nx2 == (spec_rd_addr ==  2 ? spec_rd_wdata :  x2));
				assert ( nx3 == (spec_rd_addr ==  3 ? spec_rd_wdata :  x3));
				assert ( nx4 == (spec_rd_addr ==  4 ? spec_rd_wdata :  x4));
				assert ( nx5 == (spec_rd_addr ==  5 ? spec_rd_wdata :  x5));
				assert ( nx6 == (spec_rd_addr ==  6 ? spec_rd_wdata :  x6));
				assert ( nx7 == (spec_rd_addr ==  7 ? spec_rd_wdata :  x7));
				assert ( nx8 == (spec_rd_addr ==  8 ? spec_rd_wdata :  x8));
				assert ( nx9 == (spec_rd_addr ==  9 ? spec_rd_wdata :  x9));
				assert (nx10 == (spec_rd_addr == 10 ? spec_rd_wdata : x10));
				assert (nx11 == (spec_rd_addr == 11 ? spec_rd_wdata : x11));
				assert (nx12 == (spec_rd_addr == 12 ? spec_rd_wdata : x12));
				assert (nx13 == (spec_rd_addr == 13 ? spec_rd_wdata : x13));
				assert (nx14 == (spec_rd_addr == 14 ? spec_rd_wdata : x14));
				assert (nx15 == (spec_rd_addr == 15 ? spec_rd_wdata : x15));
				assert (nx16 == (spec_rd_addr == 16 ? spec_rd_wdata : x16));
				assert (nx17 == (spec_rd_addr == 17 ? spec_rd_wdata : x17));
				assert (nx18 == (spec_rd_addr == 18 ? spec_rd_wdata : x18));
				assert (nx19 == (spec_rd_addr == 19 ? spec_rd_wdata : x19));
				assert (nx20 == (spec_rd_addr == 20 ? spec_rd_wdata : x20));
				assert (nx21 == (spec_rd_addr == 21 ? spec_rd_wdata : x21));
				assert (nx22 == (spec_rd_addr == 22 ? spec_rd_wdata : x22));
				assert (nx23 == (spec_rd_addr == 23 ? spec_rd_wdata : x23));
				assert (nx24 == (spec_rd_addr == 24 ? spec_rd_wdata : x24));
				assert (nx25 == (spec_rd_addr == 25 ? spec_rd_wdata : x25));
				assert (nx26 == (spec_rd_addr == 26 ? spec_rd_wdata : x26));
				assert (nx27 == (spec_rd_addr == 27 ? spec_rd_wdata : x27));
				assert (nx28 == (spec_rd_addr == 28 ? spec_rd_wdata : x28));
				assert (nx29 == (spec_rd_addr == 29 ? spec_rd_wdata : x29));
				assert (nx30 == (spec_rd_addr == 30 ? spec_rd_wdata : x30));
				assert (nx31 == (spec_rd_addr == 31 ? spec_rd_wdata : x31));
				assert (npc == spec_pc_wdata);
				assert (ren == spec_mem_rmask);
				assert (wen == spec_mem_wmask);
				if (spec_mem_rmask) begin
					assert (raddr == spec_mem_addr);
				end
				if (spec_mem_wmask) begin
					assert (waddr == spec_mem_addr);
					if (spec_mem_wmask[0]) assert (wdata[ 7: 0] == spec_mem_wdata[ 7: 0]);
					if (spec_mem_wmask[1]) assert (wdata[15: 8] == spec_mem_wdata[15: 8]);
					if (spec_mem_wmask[2]) assert (wdata[23:16] == spec_mem_wdata[23:16]);
					if (spec_mem_wmask[3]) assert (wdata[31:24] == spec_mem_wdata[31:24]);
				end
				assert (!excep);
			end
		end
	end

	`RISCV_FORMAL_INSN_MODEL model (
		.rvfi_valid     (rvfi_valid    ),
		.rvfi_insn      (rvfi_insn     ),
		.rvfi_pc_rdata  (rvfi_pc_rdata ),
		.rvfi_rs1_rdata (rvfi_rs1_rdata),
		.rvfi_rs2_rdata (rvfi_rs2_rdata),
		.rvfi_mem_rdata (rvfi_mem_rdata),
		.spec_valid     (spec_valid    ),
		.spec_trap      (spec_trap     ),
		.spec_rs1_addr  (spec_rs1_addr ),
		.spec_rs2_addr  (spec_rs2_addr ),
		.spec_rd_addr   (spec_rd_addr  ),
		.spec_rd_wdata  (spec_rd_wdata ),
		.spec_pc_wdata  (spec_pc_wdata ),
		.spec_mem_addr  (spec_mem_addr ),
		.spec_mem_rmask (spec_mem_rmask),
		.spec_mem_wmask (spec_mem_wmask),
		.spec_mem_wdata (spec_mem_wdata),
	);

	rvspec rvspec_inst (
		.in_instr         ( insn),
		.in_pc            (   pc),
		.out_nextPC       (  npc),
		.out_exception    (excep),

		.out_loadEnable   (  ren),
		.out_loadAddress  (raddr),
		.in_loadData      (rdata),

		.out_storeEnable  (  wen),
		.out_storeAddress (waddr),
		.out_storeData    (wdata),

		.in_registers ({
			x31, x30, x29, x28, x27, x26, x25, x24, x23, x22, x21, x20, x19, x18, x17,
			x16, x15, x14, x13, x12, x11, x10, x9, x8, x7, x6, x5, x4, x3, x2, x1
		}),

		.out_registers ({
			nx31, nx30, nx29, nx28, nx27, nx26, nx25, nx24, nx23, nx22, nx21, nx20, nx19, nx18, nx17,
			nx16, nx15, nx14, nx13, nx12, nx11, nx10, nx9, nx8, nx7, nx6, nx5, nx4, nx3, nx2, nx1
		})
	);
endmodule
