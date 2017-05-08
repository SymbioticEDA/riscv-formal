// DO NOT EDIT -- auto-generated from generate.py

`define ISA_COVERAGE_LEN_RV32IC 63
module isa_coverage_rv32ic (input [31:0] insn, output [62:0] valid);
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
  rvfi_insn_c_add insn_c_add (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[11]),
  );
  rvfi_insn_c_addi insn_c_addi (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[12]),
  );
  rvfi_insn_c_addi16sp insn_c_addi16sp (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[13]),
  );
  rvfi_insn_c_addi4spn insn_c_addi4spn (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[14]),
  );
  rvfi_insn_c_and insn_c_and (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[15]),
  );
  rvfi_insn_c_andi insn_c_andi (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[16]),
  );
  rvfi_insn_c_beqz insn_c_beqz (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[17]),
  );
  rvfi_insn_c_bnez insn_c_bnez (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[18]),
  );
  rvfi_insn_c_j insn_c_j (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[19]),
  );
  rvfi_insn_c_jal insn_c_jal (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[20]),
  );
  rvfi_insn_c_jalr insn_c_jalr (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[21]),
  );
  rvfi_insn_c_jr insn_c_jr (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[22]),
  );
  rvfi_insn_c_li insn_c_li (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[23]),
  );
  rvfi_insn_c_lui insn_c_lui (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[24]),
  );
  rvfi_insn_c_lw insn_c_lw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[25]),
  );
  rvfi_insn_c_lwsp insn_c_lwsp (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[26]),
  );
  rvfi_insn_c_mv insn_c_mv (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[27]),
  );
  rvfi_insn_c_nop insn_c_nop (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[28]),
  );
  rvfi_insn_c_or insn_c_or (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[29]),
  );
  rvfi_insn_c_slli insn_c_slli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[30]),
  );
  rvfi_insn_c_srai insn_c_srai (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[31]),
  );
  rvfi_insn_c_srli insn_c_srli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[32]),
  );
  rvfi_insn_c_sub insn_c_sub (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[33]),
  );
  rvfi_insn_c_sw insn_c_sw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[34]),
  );
  rvfi_insn_c_swsp insn_c_swsp (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[35]),
  );
  rvfi_insn_c_xor insn_c_xor (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[36]),
  );
  rvfi_insn_jal insn_jal (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[37]),
  );
  rvfi_insn_jalr insn_jalr (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[38]),
  );
  rvfi_insn_lb insn_lb (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[39]),
  );
  rvfi_insn_lbu insn_lbu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[40]),
  );
  rvfi_insn_lh insn_lh (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[41]),
  );
  rvfi_insn_lhu insn_lhu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[42]),
  );
  rvfi_insn_lui insn_lui (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[43]),
  );
  rvfi_insn_lw insn_lw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[44]),
  );
  rvfi_insn_or insn_or (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[45]),
  );
  rvfi_insn_ori insn_ori (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[46]),
  );
  rvfi_insn_sb insn_sb (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[47]),
  );
  rvfi_insn_sh insn_sh (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[48]),
  );
  rvfi_insn_sll insn_sll (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[49]),
  );
  rvfi_insn_slli insn_slli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[50]),
  );
  rvfi_insn_slt insn_slt (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[51]),
  );
  rvfi_insn_slti insn_slti (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[52]),
  );
  rvfi_insn_sltiu insn_sltiu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[53]),
  );
  rvfi_insn_sltu insn_sltu (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[54]),
  );
  rvfi_insn_sra insn_sra (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[55]),
  );
  rvfi_insn_srai insn_srai (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[56]),
  );
  rvfi_insn_srl insn_srl (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[57]),
  );
  rvfi_insn_srli insn_srli (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[58]),
  );
  rvfi_insn_sub insn_sub (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[59]),
  );
  rvfi_insn_sw insn_sw (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[60]),
  );
  rvfi_insn_xor insn_xor (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[61]),
  );
  rvfi_insn_xori insn_xori (
    .rvfi_valid(1'b1),
    .rvfi_insn(insn),
    .rvfi_pc_rdata(32'h00000000),
    .rvfi_rs1_rdata(32'h00000000),
    .rvfi_rs2_rdata(32'h00000000),
    .rvfi_mem_rdata(32'h00000000),
    .spec_valid(valid[62]),
  );
endmodule
