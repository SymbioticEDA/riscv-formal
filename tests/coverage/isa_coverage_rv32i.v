// DO NOT EDIT -- auto-generated from generate.py

`define ISA_COVERAGE_LEN_RV32I 37
module isa_coverage_rv32i (input [31:0] insn, output [36:0] valid);
  rvfi_insn_add insn_add (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[0]),
  );
  rvfi_insn_addi insn_addi (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[1]),
  );
  rvfi_insn_and insn_and (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[2]),
  );
  rvfi_insn_andi insn_andi (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[3]),
  );
  rvfi_insn_auipc insn_auipc (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[4]),
  );
  rvfi_insn_beq insn_beq (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[5]),
  );
  rvfi_insn_bge insn_bge (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[6]),
  );
  rvfi_insn_bgeu insn_bgeu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[7]),
  );
  rvfi_insn_blt insn_blt (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[8]),
  );
  rvfi_insn_bltu insn_bltu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[9]),
  );
  rvfi_insn_bne insn_bne (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[10]),
  );
  rvfi_insn_jal insn_jal (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[11]),
  );
  rvfi_insn_jalr insn_jalr (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[12]),
  );
  rvfi_insn_lb insn_lb (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[13]),
  );
  rvfi_insn_lbu insn_lbu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[14]),
  );
  rvfi_insn_lh insn_lh (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[15]),
  );
  rvfi_insn_lhu insn_lhu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[16]),
  );
  rvfi_insn_lui insn_lui (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[17]),
  );
  rvfi_insn_lw insn_lw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[18]),
  );
  rvfi_insn_or insn_or (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[19]),
  );
  rvfi_insn_ori insn_ori (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[20]),
  );
  rvfi_insn_sb insn_sb (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[21]),
  );
  rvfi_insn_sh insn_sh (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[22]),
  );
  rvfi_insn_sll insn_sll (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[23]),
  );
  rvfi_insn_slli insn_slli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[24]),
  );
  rvfi_insn_slt insn_slt (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[25]),
  );
  rvfi_insn_slti insn_slti (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[26]),
  );
  rvfi_insn_sltiu insn_sltiu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[27]),
  );
  rvfi_insn_sltu insn_sltu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[28]),
  );
  rvfi_insn_sra insn_sra (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[29]),
  );
  rvfi_insn_srai insn_srai (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[30]),
  );
  rvfi_insn_srl insn_srl (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[31]),
  );
  rvfi_insn_srli insn_srli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[32]),
  );
  rvfi_insn_sub insn_sub (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[33]),
  );
  rvfi_insn_sw insn_sw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[34]),
  );
  rvfi_insn_xor insn_xor (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[35]),
  );
  rvfi_insn_xori insn_xori (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[36]),
  );
endmodule
