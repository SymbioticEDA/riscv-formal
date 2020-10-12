// Generator : SpinalHDL v0.11.3    git head : 4d8502333f4f7d6be245912fd85227ba7847abbd
// Date      : 26/11/2017, 14:03:00
// Component : VexRiscv


`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_FOUR 2'b10

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

module VexRiscv (
      output  rvfi_valid,
      output [63:0] rvfi_order,
      output [31:0] rvfi_insn,
      output reg  rvfi_trap,
      output  rvfi_halt,
      output  rvfi_intr,
      output [1:0] rvfi_mode,
      output [1:0] rvfi_ixl,
      output [4:0] rvfi_rs1_addr,
      output [31:0] rvfi_rs1_rdata,
      output [4:0] rvfi_rs2_addr,
      output [31:0] rvfi_rs2_rdata,
      output [4:0] rvfi_rd_addr,
      output [31:0] rvfi_rd_wdata,
      output [31:0] rvfi_pc_rdata,
      output [31:0] rvfi_pc_wdata,
      output [31:0] rvfi_mem_addr,
      output [3:0] rvfi_mem_rmask,
      output [3:0] rvfi_mem_wmask,
      output [31:0] rvfi_mem_rdata,
      output [31:0] rvfi_mem_wdata,
      output  iBus_cmd_valid,
      input   iBus_cmd_ready,
      output [31:0] iBus_cmd_payload_pc,
      input   iBus_rsp_ready,
      input   iBus_rsp_error,
      input  [31:0] iBus_rsp_inst,
      output  dBus_cmd_valid,
      input   dBus_cmd_ready,
      output  dBus_cmd_payload_wr,
      output [31:0] dBus_cmd_payload_address,
      output [31:0] dBus_cmd_payload_data,
      output [1:0] dBus_cmd_payload_size,
      input   dBus_rsp_ready,
      input   dBus_rsp_error,
      input  [31:0] dBus_rsp_data,
      input   clk,
      input   reset);
  reg [31:0] zz_205;
  reg [31:0] zz_206;
  reg  zz_207;
  reg  zz_208;
  wire  zz_209;
  wire [1:0] zz_210;
  wire [31:0] zz_211;
  wire  zz_212;
  wire  zz_213;
  wire [31:0] zz_214;
  wire [1:0] zz_215;
  wire [31:0] zz_216;
  wire [0:0] zz_217;
  wire [0:0] zz_218;
  wire [0:0] zz_219;
  wire [0:0] zz_220;
  wire [0:0] zz_221;
  wire [0:0] zz_222;
  wire [0:0] zz_223;
  wire [0:0] zz_224;
  wire [11:0] zz_225;
  wire [11:0] zz_226;
  wire [31:0] zz_227;
  wire [31:0] zz_228;
  wire [31:0] zz_229;
  wire [31:0] zz_230;
  wire [31:0] zz_231;
  wire [1:0] zz_232;
  wire [1:0] zz_233;
  wire [1:0] zz_234;
  wire [32:0] zz_235;
  wire [31:0] zz_236;
  wire [32:0] zz_237;
  wire [19:0] zz_238;
  wire [11:0] zz_239;
  wire [11:0] zz_240;
  wire [31:0] writeBack_FORMAL_MEM_ADDR;
  wire [31:0] memory_FORMAL_MEM_ADDR;
  wire [31:0] execute_FORMAL_MEM_ADDR;
  wire  execute_BRANCH_DO;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type zz_1;
  wire `BranchCtrlEnum_binary_sequancial_type zz_2;
  wire `BranchCtrlEnum_binary_sequancial_type zz_3;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  decode_SRC_LESS_UNSIGNED;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type zz_4;
  wire `AluCtrlEnum_binary_sequancial_type zz_5;
  wire `AluCtrlEnum_binary_sequancial_type zz_6;
  wire [31:0] memory_PC;
  wire [31:0] fetch_PC;
  wire [31:0] execute_SHIFT_RIGHT;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_7;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_8;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_9;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_10;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_11;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire [31:0] fetch_FORMAL_PC_NEXT;
  wire [31:0] prefetch_FORMAL_PC_NEXT;
  wire [31:0] decode_SRC2;
  wire [3:0] writeBack_FORMAL_MEM_RMASK;
  wire [3:0] memory_FORMAL_MEM_RMASK;
  wire [3:0] execute_FORMAL_MEM_RMASK;
  wire  writeBack_RS2_USE;
  wire  memory_RS2_USE;
  wire  execute_RS2_USE;
  wire [31:0] writeBack_RS1;
  wire [31:0] memory_RS1;
  wire [31:0] decode_RS1;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire [31:0] writeBack_FORMAL_MEM_WDATA;
  wire [31:0] memory_FORMAL_MEM_WDATA;
  wire [31:0] execute_FORMAL_MEM_WDATA;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] fetch_INSTRUCTION;
  wire  writeBack_RS1_USE;
  wire  memory_RS1_USE;
  wire  execute_RS1_USE;
  wire [31:0] writeBack_RS2;
  wire [31:0] memory_RS2;
  wire [31:0] decode_RS2;
  wire [3:0] writeBack_FORMAL_MEM_WMASK;
  wire [3:0] memory_FORMAL_MEM_WMASK;
  wire [3:0] execute_FORMAL_MEM_WMASK;
  wire  decode_SRC_USE_SUB_LESS;
  wire  writeBack_FORMAL_HALT;
  wire  memory_FORMAL_HALT;
  wire  execute_FORMAL_HALT;
  wire  decode_FORMAL_HALT;
  wire  fetch_FORMAL_HALT;
  wire  prefetch_FORMAL_HALT;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_FORMAL_MEM_RDATA;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] decode_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_12;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_13;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_14;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] zz_15;
  wire [31:0] execute_PC;
  wire [31:0] execute_RS1;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type zz_16;
  wire  zz_17;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] zz_18;
  wire `ShiftCtrlEnum_binary_sequancial_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_19;
  wire [31:0] zz_20;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_21;
  wire  zz_22;
  wire [31:0] zz_23;
  wire [31:0] zz_24;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] zz_25;
  wire [31:0] zz_26;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type zz_27;
  wire [31:0] zz_28;
  wire [31:0] zz_29;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type zz_30;
  wire [31:0] zz_31;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type zz_32;
  wire [31:0] zz_33;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_34;
  reg  zz_35;
  wire [31:0] zz_36;
  wire [31:0] zz_37;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire `Src1CtrlEnum_binary_sequancial_type zz_38;
  wire  zz_39;
  wire `Src2CtrlEnum_binary_sequancial_type zz_40;
  wire  zz_41;
  wire  zz_42;
  wire  zz_43;
  wire  zz_44;
  wire  zz_45;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_46;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_47;
  wire  zz_48;
  wire  zz_49;
  wire `BranchCtrlEnum_binary_sequancial_type zz_50;
  wire `AluCtrlEnum_binary_sequancial_type zz_51;
  wire  zz_52;
  wire [31:0] zz_53;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  memory_ALIGNEMENT_FAULT;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] zz_54;
  wire [31:0] zz_55;
  wire [3:0] zz_56;
  wire [3:0] zz_57;
  wire [31:0] zz_58;
  wire [1:0] zz_59;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  zz_60;
  wire  zz_61;
  wire [31:0] zz_62;
  wire [31:0] zz_63;
  reg [31:0] zz_64;
  wire [31:0] zz_65;
  reg [31:0] zz_66;
  wire [31:0] prefetch_PC;
  wire [31:0] zz_67;
  wire [31:0] zz_68;
  wire [31:0] prefetch_PC_CALC_WITHOUT_JUMP;
  wire [31:0] zz_69;
  wire  zz_70;
  reg  zz_71;
  wire  zz_72;
  reg  zz_73;
  wire  zz_74;
  wire  zz_75;
  reg [31:0] zz_76;
  wire  zz_77;
  wire  zz_78;
  wire  zz_79;
  wire [31:0] zz_80;
  wire [31:0] writeBack_PC/* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION/* verilator public */ ;
  wire [31:0] decode_PC/* verilator public */ ;
  wire [31:0] decode_INSTRUCTION/* verilator public */ ;
  reg  prefetch_arbitration_haltItself;
  wire  prefetch_arbitration_haltByOther;
  wire  prefetch_arbitration_removeIt;
  wire  prefetch_arbitration_flushAll;
  reg  prefetch_arbitration_isValid;
  wire  prefetch_arbitration_isStuck;
  wire  prefetch_arbitration_isStuckByOthers;
  wire  prefetch_arbitration_isFlushed;
  wire  prefetch_arbitration_isFiring;
  reg  fetch_arbitration_haltItself;
  wire  fetch_arbitration_haltByOther;
  reg  fetch_arbitration_removeIt;
  wire  fetch_arbitration_flushAll;
  reg  fetch_arbitration_isValid;
  wire  fetch_arbitration_isStuck;
  wire  fetch_arbitration_isStuckByOthers;
  wire  fetch_arbitration_isFlushed;
  wire  fetch_arbitration_isFiring;
  reg  decode_arbitration_haltItself/* verilator public */ ;
  wire  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushAll;
  reg  decode_arbitration_isValid/* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  wire  memory_arbitration_flushAll;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  reg  writeBack_arbitration_isValid/* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isFiring/* verilator public */ ;
  reg  zz_81;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  zz_82;
  wire [31:0] zz_83;
  reg [63:0] writeBack_FomalPlugin_order;
  reg  writeBack_FomalPlugin_haltRequest;
  wire  zz_84;
  reg  zz_85;
  reg  zz_86;
  reg  zz_87;
  reg  zz_88;
  reg  zz_89;
  reg  writeBack_FomalPlugin_haltFired;
  reg [31:0] prefetch_PcManagerSimplePlugin_pcReg/* verilator public */ ;
  reg  prefetch_PcManagerSimplePlugin_inc;
  wire [31:0] prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  reg [31:0] prefetch_PcManagerSimplePlugin_pc;
  reg  prefetch_PcManagerSimplePlugin_samplePcNext;
  wire  prefetch_PcManagerSimplePlugin_jump_pcLoad_valid;
  wire [31:0] prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
  reg  prefetch_IBusSimplePlugin_pendingCmd;
  reg  zz_90;
  reg [31:0] zz_91;
  reg [31:0] zz_92;
  reg [3:0] zz_93;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  zz_94;
  reg [31:0] zz_95;
  wire  zz_96;
  reg [31:0] zz_97;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [19:0] zz_98;
  wire  zz_99;
  wire  zz_100;
  wire  zz_101;
  wire  zz_102;
  wire  zz_103;
  wire  zz_104;
  wire  zz_105;
  wire  zz_106;
  wire `AluCtrlEnum_binary_sequancial_type zz_107;
  wire `BranchCtrlEnum_binary_sequancial_type zz_108;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_109;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_110;
  wire `Src2CtrlEnum_binary_sequancial_type zz_111;
  wire `Src1CtrlEnum_binary_sequancial_type zz_112;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  zz_113;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  zz_114;
  reg  writeBack_RegFilePlugin_regFileWrite_valid/* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address/* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data/* verilator public */ ;
  reg  zz_115;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] zz_116;
  reg [31:0] zz_117;
  wire  zz_118;
  reg [19:0] zz_119;
  wire  zz_120;
  reg [19:0] zz_121;
  reg [31:0] zz_122;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrielShifterPlugin_amplitude;
  reg [31:0] zz_123;
  wire [31:0] execute_FullBarrielShifterPlugin_reversed;
  reg [31:0] zz_124;
  reg  zz_125;
  reg  zz_126;
  reg  zz_127;
  reg [4:0] zz_128;
  wire  execute_BranchPlugin_eq;
  wire [2:0] zz_129;
  reg  zz_130;
  reg  zz_131;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  zz_132;
  reg [10:0] zz_133;
  wire  zz_134;
  reg [19:0] zz_135;
  wire  zz_136;
  reg [18:0] zz_137;
  reg [31:0] zz_138;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type zz_139;
  reg [31:0] zz_140;
  reg [31:0] zz_141;
  reg  zz_142;
  reg  zz_143;
  reg  zz_144;
  reg [1:0] zz_145;
  reg [1:0] zz_146;
  reg  zz_147;
  reg  zz_148;
  reg  zz_149;
  reg  zz_150;
  reg  zz_151;
  reg  zz_152;
  reg  zz_153;
  reg  zz_154;
  reg  zz_155;
  reg [3:0] zz_156;
  reg [3:0] zz_157;
  reg [31:0] zz_158;
  reg [31:0] zz_159;
  reg [31:0] zz_160;
  reg  zz_161;
  reg  zz_162;
  reg  zz_163;
  reg  zz_164;
  reg [31:0] zz_165;
  reg [31:0] zz_166;
  reg [31:0] zz_167;
  reg [31:0] zz_168;
  reg  zz_169;
  reg  zz_170;
  reg  zz_171;
  reg [31:0] zz_172;
  reg [31:0] zz_173;
  reg [31:0] zz_174;
  reg [31:0] zz_175;
  reg [31:0] zz_176;
  reg [31:0] zz_177;
  reg  zz_178;
  reg  zz_179;
  reg  zz_180;
  reg [3:0] zz_181;
  reg [3:0] zz_182;
  reg [31:0] zz_183;
  reg [31:0] zz_184;
  reg [31:0] zz_185;
  reg [31:0] zz_186;
  reg [31:0] zz_187;
  reg [31:0] zz_188;
  reg `ShiftCtrlEnum_binary_sequancial_type zz_189;
  reg `ShiftCtrlEnum_binary_sequancial_type zz_190;
  reg [31:0] zz_191;
  reg [31:0] zz_192;
  reg [31:0] zz_193;
  reg [31:0] zz_194;
  reg [31:0] zz_195;
  reg [31:0] zz_196;
  reg `AluCtrlEnum_binary_sequancial_type zz_197;
  reg  zz_198;
  reg [31:0] zz_199;
  reg [31:0] zz_200;
  reg `BranchCtrlEnum_binary_sequancial_type zz_201;
  reg  zz_202;
  reg [31:0] zz_203;
  reg [31:0] zz_204;
  reg [31:0] RegFilePlugin_regFile [0:31]/* verilator public */ ;
  assign rvfi_valid = zz_207;
  assign rvfi_halt = zz_208;
  assign iBus_cmd_valid = zz_209;
  assign dBus_cmd_payload_size = zz_210;
  assign dBus_cmd_payload_address = zz_211;
  assign dBus_cmd_valid = zz_212;
  assign dBus_cmd_payload_wr = zz_213;
  assign dBus_cmd_payload_data = zz_214;
  assign zz_215 = writeBack_INSTRUCTION[13 : 12];
  assign zz_216 = {29'd0, {prefetch_PcManagerSimplePlugin_inc,(2'b00)}};
  assign zz_217 = zz_98[4 : 4];
  assign zz_218 = zz_98[5 : 5];
  assign zz_219 = zz_98[10 : 10];
  assign zz_220 = zz_98[11 : 11];
  assign zz_221 = zz_98[12 : 12];
  assign zz_222 = zz_98[13 : 13];
  assign zz_223 = zz_98[14 : 14];
  assign zz_224 = zz_98[17 : 17];
  assign zz_225 = decode_INSTRUCTION[31 : 20];
  assign zz_226 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign zz_227 = ($signed(zz_228) + $signed(zz_231));
  assign zz_228 = ($signed(zz_229) + $signed(zz_230));
  assign zz_229 = execute_SRC1;
  assign zz_230 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign zz_231 = {{30{zz_232[1]}}, zz_232};
  assign zz_232 = (execute_SRC_USE_SUB_LESS ? zz_233 : zz_234);
  assign zz_233 = (2'b01);
  assign zz_234 = (2'b00);
  assign zz_235 = ($signed(zz_237) >>> execute_FullBarrielShifterPlugin_amplitude);
  assign zz_236 = zz_235[31 : 0];
  assign zz_237 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_FullBarrielShifterPlugin_reversed[31]),execute_FullBarrielShifterPlugin_reversed};
  assign zz_238 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign zz_239 = execute_INSTRUCTION[31 : 20];
  assign zz_240 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  always @ (posedge clk)
  begin
    if(zz_35) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk)
  begin
    if(zz_113) begin
      zz_205 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk)
  begin
    if(zz_114) begin
      zz_206 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  assign writeBack_FORMAL_MEM_ADDR = zz_204;
  assign memory_FORMAL_MEM_ADDR = zz_203;
  assign execute_FORMAL_MEM_ADDR = zz_58;
  assign execute_BRANCH_DO = zz_17;
  assign decode_BRANCH_CTRL = zz_1;
  assign zz_2 = zz_3;
  assign writeBack_REGFILE_WRITE_DATA = zz_200;
  assign execute_REGFILE_WRITE_DATA = zz_33;
  assign decode_SRC_LESS_UNSIGNED = zz_43;
  assign decode_ALU_CTRL = zz_4;
  assign zz_5 = zz_6;
  assign memory_PC = zz_195;
  assign fetch_PC = zz_192;
  assign execute_SHIFT_RIGHT = zz_20;
  assign zz_7 = zz_8;
  assign decode_SHIFT_CTRL = zz_9;
  assign zz_10 = zz_11;
  assign writeBack_FORMAL_PC_NEXT = zz_188;
  assign memory_FORMAL_PC_NEXT = zz_187;
  assign execute_FORMAL_PC_NEXT = zz_186;
  assign decode_FORMAL_PC_NEXT = zz_185;
  assign fetch_FORMAL_PC_NEXT = zz_184;
  assign prefetch_FORMAL_PC_NEXT = zz_67;
  assign decode_SRC2 = zz_28;
  assign writeBack_FORMAL_MEM_RMASK = zz_182;
  assign memory_FORMAL_MEM_RMASK = zz_181;
  assign execute_FORMAL_MEM_RMASK = zz_56;
  assign writeBack_RS2_USE = zz_180;
  assign memory_RS2_USE = zz_179;
  assign execute_RS2_USE = zz_178;
  assign writeBack_RS1 = zz_177;
  assign memory_RS1 = zz_176;
  assign decode_RS1 = zz_37;
  assign memory_MEMORY_READ_DATA = zz_54;
  assign writeBack_FORMAL_MEM_WDATA = zz_173;
  assign memory_FORMAL_MEM_WDATA = zz_172;
  assign execute_FORMAL_MEM_WDATA = zz_55;
  assign decode_MEMORY_ENABLE = zz_45;
  assign fetch_INSTRUCTION = zz_64;
  assign writeBack_RS1_USE = zz_164;
  assign memory_RS1_USE = zz_163;
  assign execute_RS1_USE = zz_162;
  assign writeBack_RS2 = zz_160;
  assign memory_RS2 = zz_159;
  assign decode_RS2 = zz_36;
  assign writeBack_FORMAL_MEM_WMASK = zz_157;
  assign memory_FORMAL_MEM_WMASK = zz_156;
  assign execute_FORMAL_MEM_WMASK = zz_57;
  assign decode_SRC_USE_SUB_LESS = zz_49;
  assign writeBack_FORMAL_HALT = zz_151;
  assign memory_FORMAL_HALT = zz_150;
  assign execute_FORMAL_HALT = zz_149;
  assign decode_FORMAL_HALT = zz_148;
  assign fetch_FORMAL_HALT = zz_147;
  assign prefetch_FORMAL_HALT = zz_70;
  assign memory_MEMORY_ADDRESS_LOW = zz_145;
  assign execute_MEMORY_ADDRESS_LOW = zz_59;
  assign writeBack_FORMAL_MEM_RDATA = zz_53;
  assign decode_BYPASSABLE_EXECUTE_STAGE = zz_41;
  assign execute_BYPASSABLE_MEMORY_STAGE = zz_142;
  assign decode_BYPASSABLE_MEMORY_STAGE = zz_48;
  assign execute_BRANCH_CALC = zz_15;
  assign decode_SRC1 = zz_31;
  assign decode_ALU_BITWISE_CTRL = zz_12;
  assign zz_13 = zz_14;
  assign memory_BRANCH_CALC = zz_141;
  assign memory_BRANCH_DO = zz_202;
  assign execute_PC = zz_194;
  assign execute_RS1 = zz_175;
  assign execute_BRANCH_CTRL = zz_16;
  assign decode_RS2_USE = zz_44;
  assign decode_RS1_USE = zz_42;
  assign execute_REGFILE_WRITE_VALID = zz_153;
  assign execute_BYPASSABLE_EXECUTE_STAGE = zz_144;
  assign memory_REGFILE_WRITE_VALID = zz_154;
  assign memory_BYPASSABLE_MEMORY_STAGE = zz_143;
  assign writeBack_REGFILE_WRITE_VALID = zz_155;
  assign memory_SHIFT_RIGHT = zz_191;
  always @ (memory_REGFILE_WRITE_DATA or memory_SHIFT_CTRL or zz_124 or memory_SHIFT_RIGHT)
  begin
    zz_18 = memory_REGFILE_WRITE_DATA;
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        zz_18 = zz_124;
      end
      `ShiftCtrlEnum_binary_sequancial_SRL_1, `ShiftCtrlEnum_binary_sequancial_SRA_1 : begin
        zz_18 = memory_SHIFT_RIGHT;
      end
      default : begin
      end
    endcase
  end

  assign memory_SHIFT_CTRL = zz_19;
  assign execute_SHIFT_CTRL = zz_21;
  assign execute_SRC_LESS_UNSIGNED = zz_198;
  assign execute_SRC_USE_SUB_LESS = zz_152;
  assign zz_25 = decode_PC;
  assign zz_26 = decode_RS2;
  assign decode_SRC2_CTRL = zz_27;
  assign zz_29 = decode_RS1;
  assign decode_SRC1_CTRL = zz_30;
  assign execute_SRC_ADD_SUB = zz_24;
  assign execute_SRC_LESS = zz_22;
  assign execute_ALU_CTRL = zz_32;
  assign execute_SRC2 = zz_183;
  assign execute_SRC1 = zz_140;
  assign execute_ALU_BITWISE_CTRL = zz_34;
  always @ (writeBack_RegFilePlugin_regFileWrite_valid)
  begin
    zz_35 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      zz_35 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = zz_63;
  always @ (zz_39 or decode_INSTRUCTION)
  begin
    decode_REGFILE_WRITE_VALID = zz_39;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = zz_52;
  assign decode_INSTRUCTION_READY = zz_61;
  assign writeBack_MEMORY_ENABLE = zz_171;
  assign writeBack_MEMORY_ADDRESS_LOW = zz_146;
  assign writeBack_MEMORY_READ_DATA = zz_174;
  assign memory_REGFILE_WRITE_DATA = zz_199;
  assign memory_ALIGNEMENT_FAULT = zz_161;
  assign memory_INSTRUCTION = zz_167;
  assign memory_MEMORY_ENABLE = zz_170;
  assign execute_RS2 = zz_158;
  assign execute_SRC_ADD = zz_23;
  assign execute_INSTRUCTION = zz_166;
  assign execute_ALIGNEMENT_FAULT = zz_60;
  assign execute_MEMORY_ENABLE = zz_169;
  assign zz_62 = fetch_INSTRUCTION;
  assign zz_65 = prefetch_PC;
  always @ (memory_FORMAL_PC_NEXT or zz_82 or zz_83)
  begin
    zz_66 = memory_FORMAL_PC_NEXT;
    if(zz_82)begin
      zz_66 = zz_83;
    end
  end

  assign prefetch_PC = zz_68;
  assign prefetch_PC_CALC_WITHOUT_JUMP = zz_69;
  always @ (memory_FORMAL_HALT or zz_81 or memory_arbitration_isValid or memory_BRANCH_DO or zz_83 or memory_MEMORY_ENABLE or memory_INSTRUCTION or dBus_rsp_ready)
  begin
    zz_71 = memory_FORMAL_HALT;
    memory_arbitration_haltItself = 1'b0;
    if((zz_81 || ((memory_arbitration_isValid && memory_BRANCH_DO) && (zz_83[1 : 0] != (2'b00)))))begin
      zz_71 = 1'b1;
      memory_arbitration_haltItself = 1'b1;
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign zz_72 = execute_FORMAL_HALT;
  always @ (decode_FORMAL_HALT or decodeExceptionPort_valid or decode_arbitration_isValid or zz_125 or zz_126)
  begin
    zz_73 = decode_FORMAL_HALT;
    decode_arbitration_haltItself = 1'b0;
    if(decodeExceptionPort_valid)begin
      zz_73 = 1'b1;
      decode_arbitration_haltItself = 1'b1;
    end
    if((decode_arbitration_isValid && (zz_125 || zz_126)))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  assign zz_74 = fetch_FORMAL_HALT;
  assign zz_75 = prefetch_FORMAL_HALT;
  always @ (writeBack_REGFILE_WRITE_DATA or writeBack_arbitration_isValid or writeBack_MEMORY_ENABLE or writeBack_DBusSimplePlugin_rspFormated)
  begin
    zz_76 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      zz_76 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign zz_77 = writeBack_REGFILE_WRITE_VALID;
  assign zz_78 = writeBack_RS2_USE;
  assign zz_79 = writeBack_RS1_USE;
  assign zz_80 = writeBack_INSTRUCTION;
  assign writeBack_PC = zz_196;
  assign writeBack_INSTRUCTION = zz_168;
  assign decode_PC = zz_193;
  assign decode_INSTRUCTION = zz_165;
  always @ (iBus_cmd_ready or prefetch_IBusSimplePlugin_pendingCmd or iBus_rsp_ready)
  begin
    prefetch_arbitration_haltItself = 1'b0;
    if(((! iBus_cmd_ready) || (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))))begin
      prefetch_arbitration_haltItself = 1'b1;
    end
  end

  assign prefetch_arbitration_haltByOther = 1'b0;
  assign prefetch_arbitration_removeIt = 1'b0;
  assign prefetch_arbitration_flushAll = 1'b0;
  always @ (fetch_arbitration_isValid or iBus_rsp_ready or zz_90)
  begin
    fetch_arbitration_haltItself = 1'b0;
    if(((fetch_arbitration_isValid && (! iBus_rsp_ready)) && (! zz_90)))begin
      fetch_arbitration_haltItself = 1'b1;
    end
  end

  assign fetch_arbitration_haltByOther = 1'b0;
  always @ (fetch_arbitration_isFlushed)
  begin
    fetch_arbitration_removeIt = 1'b0;
    if(fetch_arbitration_isFlushed)begin
      fetch_arbitration_removeIt = 1'b1;
    end
  end

  assign fetch_arbitration_flushAll = 1'b0;
  assign decode_arbitration_haltByOther = 1'b0;
  always @ (decode_arbitration_isFlushed)
  begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushAll = 1'b0;
  always @ (execute_arbitration_isValid or execute_MEMORY_ENABLE or dBus_cmd_ready or execute_ALIGNEMENT_FAULT)
  begin
    execute_arbitration_haltItself = 1'b0;
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = 1'b1;
    end
  end

  assign execute_arbitration_haltByOther = 1'b0;
  always @ (execute_arbitration_isFlushed)
  begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (zz_82)
  begin
    execute_arbitration_flushAll = 1'b0;
    if(zz_82)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (memory_arbitration_isFlushed)
  begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (writeBack_arbitration_isFlushed)
  begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushAll = 1'b0;
  always @ (writeBack_arbitration_isFiring or zz_89 or writeBack_FomalPlugin_haltFired)
  begin
    zz_207 = writeBack_arbitration_isFiring;
    rvfi_trap = 1'b0;
    zz_208 = 1'b0;
    if(zz_89)begin
      zz_207 = 1'b1;
      rvfi_trap = 1'b1;
      zz_208 = 1'b1;
    end
    if(writeBack_FomalPlugin_haltFired)begin
      zz_207 = 1'b0;
    end
  end

  assign rvfi_order = writeBack_FomalPlugin_order;
  assign rvfi_insn = zz_80;
  assign rvfi_intr = 1'b0;
  assign rvfi_mode = 2'd3;
  assign rvfi_ixl = 2'd1;
  assign rvfi_rs1_addr = (zz_79 ? zz_80[19 : 15] : (5'b00000));
  assign rvfi_rs2_addr = (zz_78 ? zz_80[24 : 20] : (5'b00000));
  assign rvfi_rs1_rdata = (zz_79 ? writeBack_RS1 : (32'b00000000000000000000000000000000));
  assign rvfi_rs2_rdata = (zz_78 ? writeBack_RS2 : (32'b00000000000000000000000000000000));
  assign rvfi_rd_addr = (zz_77 ? zz_80[11 : 7] : (5'b00000));
  assign rvfi_rd_wdata = (zz_77 ? zz_76 : (32'b00000000000000000000000000000000));
  assign rvfi_pc_rdata = writeBack_PC;
  assign rvfi_pc_wdata = writeBack_FORMAL_PC_NEXT;
  assign rvfi_mem_addr = writeBack_FORMAL_MEM_ADDR;
  assign rvfi_mem_rmask = writeBack_FORMAL_MEM_RMASK;
  assign rvfi_mem_wmask = writeBack_FORMAL_MEM_WMASK;
  assign rvfi_mem_rdata = writeBack_FORMAL_MEM_RDATA;
  assign rvfi_mem_wdata = writeBack_FORMAL_MEM_WDATA;
  always @ (prefetch_arbitration_isValid or zz_75 or fetch_arbitration_isValid or decode_arbitration_isValid or execute_arbitration_isValid or memory_arbitration_isValid or writeBack_arbitration_isValid or zz_74 or zz_73 or zz_72 or zz_71 or writeBack_FORMAL_HALT)
  begin
    writeBack_FomalPlugin_haltRequest = 1'b0;
    if((prefetch_arbitration_isValid && zz_75))begin
      if((((((1'b1 && (! fetch_arbitration_isValid)) && (! decode_arbitration_isValid)) && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
    if((fetch_arbitration_isValid && zz_74))begin
      if(((((1'b1 && (! decode_arbitration_isValid)) && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
    if((decode_arbitration_isValid && zz_73))begin
      if((((1'b1 && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
    if((execute_arbitration_isValid && zz_72))begin
      if(((1'b1 && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
    if((memory_arbitration_isValid && zz_71))begin
      if((1'b1 && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_FORMAL_HALT))begin
      if(1'b1)begin
        writeBack_FomalPlugin_haltRequest = 1'b1;
      end
    end
  end

  assign zz_84 = 1'b0;
  assign zz_70 = 1'b0;
  assign prefetch_PcManagerSimplePlugin_pcBeforeJumps = (prefetch_PcManagerSimplePlugin_pcReg + zz_216);
  assign zz_69 = prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  always @ (prefetch_PC_CALC_WITHOUT_JUMP or prefetch_PcManagerSimplePlugin_jump_pcLoad_valid or prefetch_PcManagerSimplePlugin_jump_pcLoad_payload or prefetch_arbitration_isFiring)
  begin
    prefetch_PcManagerSimplePlugin_pc = prefetch_PC_CALC_WITHOUT_JUMP;
    prefetch_PcManagerSimplePlugin_samplePcNext = 1'b0;
    if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
      prefetch_PcManagerSimplePlugin_pc = prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
    end
    if(prefetch_arbitration_isFiring)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
    end
  end

  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_valid = zz_82;
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_payload = zz_83;
  assign zz_68 = prefetch_PcManagerSimplePlugin_pc;
  assign zz_67 = (prefetch_PC + (32'b00000000000000000000000000000100));
  assign zz_209 = (((prefetch_arbitration_isValid && (! prefetch_arbitration_removeIt)) && (! prefetch_arbitration_isStuckByOthers)) && (! (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))));
  assign iBus_cmd_payload_pc = zz_65;
  always @ (iBus_rsp_inst or zz_90 or zz_91)
  begin
    zz_64 = iBus_rsp_inst;
    if(zz_90)begin
      zz_64 = zz_91;
    end
  end

  assign zz_63 = (decode_arbitration_isStuck ? decode_INSTRUCTION : zz_62);
  assign zz_61 = 1'b1;
  assign zz_60 = (((zz_210 == (2'b10)) && (zz_211[1 : 0] != (2'b00))) || ((zz_210 == (2'b01)) && (zz_211[0 : 0] != (1'b0))));
  assign zz_212 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign zz_213 = execute_INSTRUCTION[5];
  assign zz_211 = execute_SRC_ADD;
  assign zz_210 = execute_INSTRUCTION[13 : 12];
  always @ (zz_210 or execute_RS2)
  begin
    case(zz_210)
      2'b00 : begin
        zz_92 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        zz_92 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        zz_92 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign zz_214 = zz_92;
  assign zz_59 = zz_211[1 : 0];
  always @ (zz_210)
  begin
    case(zz_210)
      2'b00 : begin
        zz_93 = (4'b0001);
      end
      2'b01 : begin
        zz_93 = (4'b0011);
      end
      default : begin
        zz_93 = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (zz_93 <<< zz_211[1 : 0]);
  assign zz_58 = (zz_211 & (32'b11111111111111111111111111111100));
  assign zz_57 = ((zz_212 && zz_213) ? execute_DBusSimplePlugin_formalMask : (4'b0000));
  assign zz_56 = ((zz_212 && (! zz_213)) ? execute_DBusSimplePlugin_formalMask : (4'b0000));
  assign zz_55 = zz_214;
  assign zz_54 = dBus_rsp_data;
  always @ (memory_ALIGNEMENT_FAULT or memory_arbitration_isValid or memory_MEMORY_ENABLE)
  begin
    zz_81 = memory_ALIGNEMENT_FAULT;
    if((! (memory_arbitration_isValid && memory_MEMORY_ENABLE)))begin
      zz_81 = 1'b0;
    end
  end

  always @ (writeBack_MEMORY_READ_DATA or writeBack_MEMORY_ADDRESS_LOW)
  begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign zz_94 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (zz_94 or writeBack_DBusSimplePlugin_rspShifted)
  begin
    zz_95[31] = zz_94;
    zz_95[30] = zz_94;
    zz_95[29] = zz_94;
    zz_95[28] = zz_94;
    zz_95[27] = zz_94;
    zz_95[26] = zz_94;
    zz_95[25] = zz_94;
    zz_95[24] = zz_94;
    zz_95[23] = zz_94;
    zz_95[22] = zz_94;
    zz_95[21] = zz_94;
    zz_95[20] = zz_94;
    zz_95[19] = zz_94;
    zz_95[18] = zz_94;
    zz_95[17] = zz_94;
    zz_95[16] = zz_94;
    zz_95[15] = zz_94;
    zz_95[14] = zz_94;
    zz_95[13] = zz_94;
    zz_95[12] = zz_94;
    zz_95[11] = zz_94;
    zz_95[10] = zz_94;
    zz_95[9] = zz_94;
    zz_95[8] = zz_94;
    zz_95[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign zz_96 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (zz_96 or writeBack_DBusSimplePlugin_rspShifted)
  begin
    zz_97[31] = zz_96;
    zz_97[30] = zz_96;
    zz_97[29] = zz_96;
    zz_97[28] = zz_96;
    zz_97[27] = zz_96;
    zz_97[26] = zz_96;
    zz_97[25] = zz_96;
    zz_97[24] = zz_96;
    zz_97[23] = zz_96;
    zz_97[22] = zz_96;
    zz_97[21] = zz_96;
    zz_97[20] = zz_96;
    zz_97[19] = zz_96;
    zz_97[18] = zz_96;
    zz_97[17] = zz_96;
    zz_97[16] = zz_96;
    zz_97[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (zz_215 or zz_95 or zz_97 or writeBack_DBusSimplePlugin_rspShifted)
  begin
    case(zz_215)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = zz_95;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = zz_97;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign zz_53 = writeBack_MEMORY_READ_DATA;
  assign zz_99 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign zz_100 = ((decode_INSTRUCTION & (32'b00000000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign zz_101 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign zz_102 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign zz_103 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign zz_104 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000000000));
  assign zz_105 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign zz_106 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign zz_98 = {({zz_100,zz_99} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100)) != (1'b0)),{({zz_100,{zz_102,{zz_103,{zz_106,((decode_INSTRUCTION & (32'b00000000000000000100000001000000)) == (32'b00000000000000000100000000000000))}}}} != (5'b00000)),{({zz_100,{zz_103,zz_105}} != (3'b000)),{({zz_100,{zz_103,zz_106}} != (3'b000)),{({zz_103,{((decode_INSTRUCTION & (32'b00000000000000000010000000100000)) == (32'b00000000000000000010000000100000)),{((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000010000)),{((decode_INSTRUCTION & (32'b00000000000000000001000000100000)) == (32'b00000000000000000000000000100000)),((decode_INSTRUCTION & (32'b00000000000000000001000000010000)) == (32'b00000000000000000000000000010000))}}}} != (5'b00000)),{({((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000000)),{zz_104,((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000))}} != (3'b000)),{({((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000000000)),((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000001000000000000))} != (2'b00)),{({zz_101,{((decode_INSTRUCTION & (32'b00000000000000000000000000100100)) == (32'b00000000000000000000000000100000)),zz_105}} != (3'b000)),{(zz_104 != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000)),zz_103} != (2'b00)),{({zz_103,((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000101000000010000)),((decode_INSTRUCTION & (32'b00000000000000000111000001100100)) == (32'b00000000000000000101000000100000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b01000000000000000011000000010100)) == (32'b01000000000000000001000000010000)),{((decode_INSTRUCTION & (32'b01000000000000000100000001100100)) == (32'b01000000000000000100000000100000)),((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000001000000010000))}} != (3'b000)),{({zz_102,((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000100000))} != (2'b00)),{({zz_101,{((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000)),((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000))}} != (3'b000)),{({zz_100,zz_99} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001000000)) != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000100000001100000)) == (32'b00000000000000000100000000100000)),{((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100)),((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000100000000010000))}} != (3'b000)),(((decode_INSTRUCTION & (32'b00000000000000000110000000010100)) == (32'b00000000000000000010000000010000)) != (1'b0))}}}}}}}}}}}}}}}}}}};
  assign zz_52 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011)),{((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000111000001111011)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & (32'b11111110000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & (32'b11111100000000000011000001111111)) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011)),((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011))}}}}}}}}}}}}}}} != (16'b0000000000000000));
  assign zz_107 = zz_98[1 : 0];
  assign zz_51 = zz_107;
  assign zz_108 = zz_98[3 : 2];
  assign zz_50 = zz_108;
  assign zz_49 = zz_217[0];
  assign zz_48 = zz_218[0];
  assign zz_109 = zz_98[7 : 6];
  assign zz_47 = zz_109;
  assign zz_110 = zz_98[9 : 8];
  assign zz_46 = zz_110;
  assign zz_45 = zz_219[0];
  assign zz_44 = zz_220[0];
  assign zz_43 = zz_221[0];
  assign zz_42 = zz_222[0];
  assign zz_41 = zz_223[0];
  assign zz_111 = zz_98[16 : 15];
  assign zz_40 = zz_111;
  assign zz_39 = zz_224[0];
  assign zz_112 = zz_98[19 : 18];
  assign zz_38 = zz_112;
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign zz_113 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = zz_205;
  assign zz_114 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = zz_206;
  assign zz_37 = decode_RegFilePlugin_rs1Data;
  assign zz_36 = decode_RegFilePlugin_rs2Data;
  always @ (zz_77 or writeBack_arbitration_isFiring or zz_115)
  begin
    writeBack_RegFilePlugin_regFileWrite_valid = (zz_77 && writeBack_arbitration_isFiring);
    if(zz_115)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = zz_80[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = zz_76;
  always @ (execute_ALU_BITWISE_CTRL or execute_SRC1 or execute_SRC2)
  begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequancial_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_XOR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = execute_SRC1;
      end
    endcase
  end

  always @ (execute_ALU_CTRL or execute_IntAluPlugin_bitwise or execute_SRC_LESS or execute_SRC_ADD_SUB)
  begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequancial_BITWISE : begin
        zz_116 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        zz_116 = {31'd0, execute_SRC_LESS};
      end
      default : begin
        zz_116 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign zz_33 = zz_116;
  always @ (decode_SRC1_CTRL or zz_29 or decode_INSTRUCTION)
  begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        zz_117 = zz_29;
      end
      `Src1CtrlEnum_binary_sequancial_FOUR : begin
        zz_117 = (32'b00000000000000000000000000000100);
      end
      default : begin
        zz_117 = {decode_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign zz_31 = zz_117;
  assign zz_118 = zz_225[11];
  always @ (zz_118)
  begin
    zz_119[19] = zz_118;
    zz_119[18] = zz_118;
    zz_119[17] = zz_118;
    zz_119[16] = zz_118;
    zz_119[15] = zz_118;
    zz_119[14] = zz_118;
    zz_119[13] = zz_118;
    zz_119[12] = zz_118;
    zz_119[11] = zz_118;
    zz_119[10] = zz_118;
    zz_119[9] = zz_118;
    zz_119[8] = zz_118;
    zz_119[7] = zz_118;
    zz_119[6] = zz_118;
    zz_119[5] = zz_118;
    zz_119[4] = zz_118;
    zz_119[3] = zz_118;
    zz_119[2] = zz_118;
    zz_119[1] = zz_118;
    zz_119[0] = zz_118;
  end

  assign zz_120 = zz_226[11];
  always @ (zz_120)
  begin
    zz_121[19] = zz_120;
    zz_121[18] = zz_120;
    zz_121[17] = zz_120;
    zz_121[16] = zz_120;
    zz_121[15] = zz_120;
    zz_121[14] = zz_120;
    zz_121[13] = zz_120;
    zz_121[12] = zz_120;
    zz_121[11] = zz_120;
    zz_121[10] = zz_120;
    zz_121[9] = zz_120;
    zz_121[8] = zz_120;
    zz_121[7] = zz_120;
    zz_121[6] = zz_120;
    zz_121[5] = zz_120;
    zz_121[4] = zz_120;
    zz_121[3] = zz_120;
    zz_121[2] = zz_120;
    zz_121[1] = zz_120;
    zz_121[0] = zz_120;
  end

  always @ (decode_SRC2_CTRL or zz_26 or zz_119 or decode_INSTRUCTION or zz_121 or zz_25)
  begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        zz_122 = zz_26;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        zz_122 = {zz_119,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        zz_122 = {zz_121,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        zz_122 = zz_25;
      end
    endcase
  end

  assign zz_28 = zz_122;
  assign execute_SrcPlugin_addSub = zz_227;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign zz_24 = execute_SrcPlugin_addSub;
  assign zz_23 = execute_SrcPlugin_addSub;
  assign zz_22 = execute_SrcPlugin_less;
  assign execute_FullBarrielShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (execute_SRC1)
  begin
    zz_123[0] = execute_SRC1[31];
    zz_123[1] = execute_SRC1[30];
    zz_123[2] = execute_SRC1[29];
    zz_123[3] = execute_SRC1[28];
    zz_123[4] = execute_SRC1[27];
    zz_123[5] = execute_SRC1[26];
    zz_123[6] = execute_SRC1[25];
    zz_123[7] = execute_SRC1[24];
    zz_123[8] = execute_SRC1[23];
    zz_123[9] = execute_SRC1[22];
    zz_123[10] = execute_SRC1[21];
    zz_123[11] = execute_SRC1[20];
    zz_123[12] = execute_SRC1[19];
    zz_123[13] = execute_SRC1[18];
    zz_123[14] = execute_SRC1[17];
    zz_123[15] = execute_SRC1[16];
    zz_123[16] = execute_SRC1[15];
    zz_123[17] = execute_SRC1[14];
    zz_123[18] = execute_SRC1[13];
    zz_123[19] = execute_SRC1[12];
    zz_123[20] = execute_SRC1[11];
    zz_123[21] = execute_SRC1[10];
    zz_123[22] = execute_SRC1[9];
    zz_123[23] = execute_SRC1[8];
    zz_123[24] = execute_SRC1[7];
    zz_123[25] = execute_SRC1[6];
    zz_123[26] = execute_SRC1[5];
    zz_123[27] = execute_SRC1[4];
    zz_123[28] = execute_SRC1[3];
    zz_123[29] = execute_SRC1[2];
    zz_123[30] = execute_SRC1[1];
    zz_123[31] = execute_SRC1[0];
  end

  assign execute_FullBarrielShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SLL_1) ? zz_123 : execute_SRC1);
  assign zz_20 = zz_236;
  always @ (memory_SHIFT_RIGHT)
  begin
    zz_124[0] = memory_SHIFT_RIGHT[31];
    zz_124[1] = memory_SHIFT_RIGHT[30];
    zz_124[2] = memory_SHIFT_RIGHT[29];
    zz_124[3] = memory_SHIFT_RIGHT[28];
    zz_124[4] = memory_SHIFT_RIGHT[27];
    zz_124[5] = memory_SHIFT_RIGHT[26];
    zz_124[6] = memory_SHIFT_RIGHT[25];
    zz_124[7] = memory_SHIFT_RIGHT[24];
    zz_124[8] = memory_SHIFT_RIGHT[23];
    zz_124[9] = memory_SHIFT_RIGHT[22];
    zz_124[10] = memory_SHIFT_RIGHT[21];
    zz_124[11] = memory_SHIFT_RIGHT[20];
    zz_124[12] = memory_SHIFT_RIGHT[19];
    zz_124[13] = memory_SHIFT_RIGHT[18];
    zz_124[14] = memory_SHIFT_RIGHT[17];
    zz_124[15] = memory_SHIFT_RIGHT[16];
    zz_124[16] = memory_SHIFT_RIGHT[15];
    zz_124[17] = memory_SHIFT_RIGHT[14];
    zz_124[18] = memory_SHIFT_RIGHT[13];
    zz_124[19] = memory_SHIFT_RIGHT[12];
    zz_124[20] = memory_SHIFT_RIGHT[11];
    zz_124[21] = memory_SHIFT_RIGHT[10];
    zz_124[22] = memory_SHIFT_RIGHT[9];
    zz_124[23] = memory_SHIFT_RIGHT[8];
    zz_124[24] = memory_SHIFT_RIGHT[7];
    zz_124[25] = memory_SHIFT_RIGHT[6];
    zz_124[26] = memory_SHIFT_RIGHT[5];
    zz_124[27] = memory_SHIFT_RIGHT[4];
    zz_124[28] = memory_SHIFT_RIGHT[3];
    zz_124[29] = memory_SHIFT_RIGHT[2];
    zz_124[30] = memory_SHIFT_RIGHT[1];
    zz_124[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (zz_127 or zz_128 or decode_INSTRUCTION or writeBack_arbitration_isValid or writeBack_REGFILE_WRITE_VALID or writeBack_INSTRUCTION or memory_arbitration_isValid or memory_REGFILE_WRITE_VALID or memory_BYPASSABLE_MEMORY_STAGE or memory_INSTRUCTION or execute_arbitration_isValid or execute_REGFILE_WRITE_VALID or execute_BYPASSABLE_EXECUTE_STAGE or execute_INSTRUCTION or decode_RS1_USE or decode_RS2_USE)
  begin
    zz_125 = 1'b0;
    zz_126 = 1'b0;
    if(zz_127)begin
      if((zz_128 == decode_INSTRUCTION[19 : 15]))begin
        zz_125 = 1'b1;
      end
      if((zz_128 == decode_INSTRUCTION[24 : 20]))begin
        zz_126 = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! 1'b1)))begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_125 = 1'b1;
        end
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_126 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_125 = 1'b1;
        end
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_126 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_125 = 1'b1;
        end
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_126 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      zz_125 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      zz_126 = 1'b0;
    end
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign zz_129 = execute_INSTRUCTION[14 : 12];
  always @ (zz_129 or execute_BranchPlugin_eq or execute_SRC_LESS)
  begin
    if((zz_129 == (3'b000))) begin
        zz_130 = execute_BranchPlugin_eq;
    end else if((zz_129 == (3'b001))) begin
        zz_130 = (! execute_BranchPlugin_eq);
    end else if((((zz_129 & (3'b101)) == (3'b101)))) begin
        zz_130 = (! execute_SRC_LESS);
    end else begin
        zz_130 = execute_SRC_LESS;
    end
  end

  always @ (execute_BRANCH_CTRL or zz_130)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        zz_131 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        zz_131 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        zz_131 = 1'b1;
      end
      default : begin
        zz_131 = zz_130;
      end
    endcase
  end

  assign zz_17 = zz_131;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? execute_RS1 : execute_PC);
  assign zz_132 = zz_238[19];
  always @ (zz_132)
  begin
    zz_133[10] = zz_132;
    zz_133[9] = zz_132;
    zz_133[8] = zz_132;
    zz_133[7] = zz_132;
    zz_133[6] = zz_132;
    zz_133[5] = zz_132;
    zz_133[4] = zz_132;
    zz_133[3] = zz_132;
    zz_133[2] = zz_132;
    zz_133[1] = zz_132;
    zz_133[0] = zz_132;
  end

  assign zz_134 = zz_239[11];
  always @ (zz_134)
  begin
    zz_135[19] = zz_134;
    zz_135[18] = zz_134;
    zz_135[17] = zz_134;
    zz_135[16] = zz_134;
    zz_135[15] = zz_134;
    zz_135[14] = zz_134;
    zz_135[13] = zz_134;
    zz_135[12] = zz_134;
    zz_135[11] = zz_134;
    zz_135[10] = zz_134;
    zz_135[9] = zz_134;
    zz_135[8] = zz_134;
    zz_135[7] = zz_134;
    zz_135[6] = zz_134;
    zz_135[5] = zz_134;
    zz_135[4] = zz_134;
    zz_135[3] = zz_134;
    zz_135[2] = zz_134;
    zz_135[1] = zz_134;
    zz_135[0] = zz_134;
  end

  assign zz_136 = zz_240[11];
  always @ (zz_136)
  begin
    zz_137[18] = zz_136;
    zz_137[17] = zz_136;
    zz_137[16] = zz_136;
    zz_137[15] = zz_136;
    zz_137[14] = zz_136;
    zz_137[13] = zz_136;
    zz_137[12] = zz_136;
    zz_137[11] = zz_136;
    zz_137[10] = zz_136;
    zz_137[9] = zz_136;
    zz_137[8] = zz_136;
    zz_137[7] = zz_136;
    zz_137[6] = zz_136;
    zz_137[5] = zz_136;
    zz_137[4] = zz_136;
    zz_137[3] = zz_136;
    zz_137[2] = zz_136;
    zz_137[1] = zz_136;
    zz_137[0] = zz_136;
  end

  always @ (execute_BRANCH_CTRL or zz_133 or execute_INSTRUCTION or zz_135 or zz_137)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        zz_138 = {{zz_133,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        zz_138 = {zz_135,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        zz_138 = {{zz_137,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = zz_138;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign zz_15 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign zz_82 = (memory_arbitration_isFiring && memory_BRANCH_DO);
  assign zz_83 = memory_BRANCH_CALC;
  assign zz_14 = decode_ALU_BITWISE_CTRL;
  assign zz_12 = zz_46;
  assign zz_34 = zz_139;
  assign zz_27 = zz_40;
  assign zz_30 = zz_38;
  assign zz_11 = decode_SHIFT_CTRL;
  assign zz_8 = execute_SHIFT_CTRL;
  assign zz_9 = zz_47;
  assign zz_21 = zz_189;
  assign zz_19 = zz_190;
  assign zz_6 = decode_ALU_CTRL;
  assign zz_4 = zz_51;
  assign zz_32 = zz_197;
  assign zz_3 = decode_BRANCH_CTRL;
  assign zz_1 = zz_50;
  assign zz_16 = zz_201;
  assign prefetch_arbitration_isFlushed = (((((prefetch_arbitration_flushAll || fetch_arbitration_flushAll) || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign fetch_arbitration_isFlushed = ((((fetch_arbitration_flushAll || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign prefetch_arbitration_isStuckByOthers = (prefetch_arbitration_haltByOther || (((((1'b0 || fetch_arbitration_haltItself) || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign prefetch_arbitration_isStuck = (prefetch_arbitration_haltItself || prefetch_arbitration_isStuckByOthers);
  assign prefetch_arbitration_isFiring = ((prefetch_arbitration_isValid && (! prefetch_arbitration_isStuck)) && (! prefetch_arbitration_removeIt));
  assign fetch_arbitration_isStuckByOthers = (fetch_arbitration_haltByOther || ((((1'b0 || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign fetch_arbitration_isStuck = (fetch_arbitration_haltItself || fetch_arbitration_isStuckByOthers);
  assign fetch_arbitration_isFiring = ((fetch_arbitration_isValid && (! fetch_arbitration_isStuck)) && (! fetch_arbitration_removeIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_haltItself));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  always @ (posedge clk)
  begin
    if(reset) begin
      prefetch_arbitration_isValid <= 1'b0;
      fetch_arbitration_isValid <= 1'b0;
      decode_arbitration_isValid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      writeBack_FomalPlugin_order <= (64'b0000000000000000000000000000000000000000000000000000000000000000);
      zz_85 <= zz_84;
      zz_86 <= zz_84;
      zz_87 <= zz_84;
      zz_88 <= zz_84;
      zz_89 <= zz_84;
      writeBack_FomalPlugin_haltFired <= 1'b0;
      prefetch_PcManagerSimplePlugin_pcReg <= (32'b00000000000000000000000000000000);
      prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      prefetch_IBusSimplePlugin_pendingCmd <= 1'b0;
      zz_90 <= 1'b0;
      zz_115 <= 1'b1;
      zz_127 <= 1'b0;
      zz_200 <= (32'b00000000000000000000000000000000);
      zz_168 <= (32'b00000000000000000000000000000000);
    end else begin
      if(writeBack_arbitration_isFiring)begin
        writeBack_FomalPlugin_order <= (writeBack_FomalPlugin_order + (64'b0000000000000000000000000000000000000000000000000000000000000001));
      end
      zz_85 <= writeBack_FomalPlugin_haltRequest;
      zz_86 <= zz_85;
      zz_87 <= zz_86;
      zz_88 <= zz_87;
      zz_89 <= zz_88;
      if((zz_207 && zz_208))begin
        writeBack_FomalPlugin_haltFired <= 1'b1;
      end
      prefetch_arbitration_isValid <= 1'b1;
      if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      end
      if(prefetch_arbitration_isFiring)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b1;
      end
      if(prefetch_PcManagerSimplePlugin_samplePcNext)begin
        prefetch_PcManagerSimplePlugin_pcReg <= prefetch_PcManagerSimplePlugin_pc;
      end
      if(iBus_rsp_ready)begin
        prefetch_IBusSimplePlugin_pendingCmd <= 1'b0;
      end
      if((zz_209 && iBus_cmd_ready))begin
        prefetch_IBusSimplePlugin_pendingCmd <= 1'b1;
      end
      if(iBus_rsp_ready)begin
        zz_90 <= 1'b1;
      end
      if((! fetch_arbitration_isStuck))begin
        zz_90 <= 1'b0;
      end
      zz_115 <= 1'b0;
      zz_127 <= (zz_77 && writeBack_arbitration_isFiring);
      if((! writeBack_arbitration_isStuck))begin
        zz_168 <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        zz_200 <= zz_18;
      end
      if(((! fetch_arbitration_isStuck) || fetch_arbitration_removeIt))begin
        fetch_arbitration_isValid <= 1'b0;
      end
      if(((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt)))begin
        fetch_arbitration_isValid <= prefetch_arbitration_isValid;
      end
      if(((! decode_arbitration_isStuck) || decode_arbitration_removeIt))begin
        decode_arbitration_isValid <= 1'b0;
      end
      if(((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt)))begin
        decode_arbitration_isValid <= fetch_arbitration_isValid;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
    end
  end

  always @ (posedge clk)
  begin
    if((! zz_90))begin
      zz_91 <= iBus_rsp_inst;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    zz_128 <= zz_80[11 : 7];
    if((! execute_arbitration_isStuck))begin
      zz_139 <= zz_13;
    end
    if((! execute_arbitration_isStuck))begin
      zz_140 <= decode_SRC1;
    end
    if((! memory_arbitration_isStuck))begin
      zz_141 <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_142 <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_143 <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      zz_144 <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_145 <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_146 <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_147 <= zz_75;
    end
    if((! decode_arbitration_isStuck))begin
      zz_148 <= zz_74;
    end
    if((! execute_arbitration_isStuck))begin
      zz_149 <= zz_73;
    end
    if((! memory_arbitration_isStuck))begin
      zz_150 <= zz_72;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_151 <= zz_71;
    end
    if((! execute_arbitration_isStuck))begin
      zz_152 <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      zz_153 <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      zz_154 <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_155 <= memory_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      zz_156 <= execute_FORMAL_MEM_WMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_157 <= memory_FORMAL_MEM_WMASK;
    end
    if((! execute_arbitration_isStuck))begin
      zz_158 <= zz_26;
    end
    if((! memory_arbitration_isStuck))begin
      zz_159 <= execute_RS2;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_160 <= memory_RS2;
    end
    if((! memory_arbitration_isStuck))begin
      zz_161 <= execute_ALIGNEMENT_FAULT;
    end
    if((! execute_arbitration_isStuck))begin
      zz_162 <= decode_RS1_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_163 <= execute_RS1_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_164 <= memory_RS1_USE;
    end
    if((! decode_arbitration_isStuck))begin
      zz_165 <= zz_62;
    end
    if((! execute_arbitration_isStuck))begin
      zz_166 <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      zz_167 <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      zz_169 <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_170 <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_171 <= memory_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_172 <= execute_FORMAL_MEM_WDATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_173 <= memory_FORMAL_MEM_WDATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_174 <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      zz_175 <= zz_29;
    end
    if((! memory_arbitration_isStuck))begin
      zz_176 <= execute_RS1;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_177 <= memory_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      zz_178 <= decode_RS2_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_179 <= execute_RS2_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_180 <= memory_RS2_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_181 <= execute_FORMAL_MEM_RMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_182 <= memory_FORMAL_MEM_RMASK;
    end
    if((! execute_arbitration_isStuck))begin
      zz_183 <= decode_SRC2;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_184 <= prefetch_FORMAL_PC_NEXT;
    end
    if((! decode_arbitration_isStuck))begin
      zz_185 <= fetch_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      zz_186 <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      zz_187 <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_188 <= zz_66;
    end
    if((! execute_arbitration_isStuck))begin
      zz_189 <= zz_10;
    end
    if((! memory_arbitration_isStuck))begin
      zz_190 <= zz_7;
    end
    if((! memory_arbitration_isStuck))begin
      zz_191 <= execute_SHIFT_RIGHT;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_192 <= zz_65;
    end
    if((! decode_arbitration_isStuck))begin
      zz_193 <= fetch_PC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_194 <= zz_25;
    end
    if((! memory_arbitration_isStuck))begin
      zz_195 <= execute_PC;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_196 <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_197 <= zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      zz_198 <= decode_SRC_LESS_UNSIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      zz_199 <= execute_REGFILE_WRITE_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      zz_201 <= zz_2;
    end
    if((! memory_arbitration_isStuck))begin
      zz_202 <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      zz_203 <= execute_FORMAL_MEM_ADDR;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_204 <= memory_FORMAL_MEM_ADDR;
    end
    if (!(prefetch_arbitration_removeIt == 1'b0)) begin
      $display("ERROR removeIt should never be asserted on this stage");
    end
  end

endmodule


