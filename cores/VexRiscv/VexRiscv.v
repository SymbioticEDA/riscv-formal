// Generator : SpinalHDL v0.11.3    git head : 4d8502333f4f7d6be245912fd85227ba7847abbd
// Date      : 24/11/2017, 12:08:46
// Component : VexRiscv


`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_FOUR 2'b10

module VexRiscv (
      output  rvfi_valid,
      output [63:0] rvfi_order,
      output [31:0] rvfi_insn,
      output reg  rvfi_trap,
      output  rvfi_halt,
      output  rvfi_intr,
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
  reg [31:0] zz_202;
  reg [31:0] zz_203;
  reg  zz_204;
  reg  zz_205;
  wire  zz_206;
  wire [1:0] zz_207;
  wire [31:0] zz_208;
  wire  zz_209;
  wire  zz_210;
  wire [31:0] zz_211;
  wire [1:0] zz_212;
  wire [31:0] zz_213;
  wire [0:0] zz_214;
  wire [0:0] zz_215;
  wire [0:0] zz_216;
  wire [0:0] zz_217;
  wire [0:0] zz_218;
  wire [0:0] zz_219;
  wire [0:0] zz_220;
  wire [0:0] zz_221;
  wire [11:0] zz_222;
  wire [11:0] zz_223;
  wire [31:0] zz_224;
  wire [31:0] zz_225;
  wire [31:0] zz_226;
  wire [31:0] zz_227;
  wire [31:0] zz_228;
  wire [1:0] zz_229;
  wire [1:0] zz_230;
  wire [1:0] zz_231;
  wire [32:0] zz_232;
  wire [31:0] zz_233;
  wire [32:0] zz_234;
  wire [19:0] zz_235;
  wire [11:0] zz_236;
  wire [11:0] zz_237;
  wire [31:0] writeBack_FORMAL_MEM_ADDR;
  wire [31:0] memory_FORMAL_MEM_ADDR;
  wire [31:0] execute_FORMAL_MEM_ADDR;
  wire  execute_BRANCH_DO;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type zz_1;
  wire `BranchCtrlEnum_binary_sequancial_type zz_2;
  wire `BranchCtrlEnum_binary_sequancial_type zz_3;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_4;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_5;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_6;
  wire [31:0] memory_PC;
  wire [31:0] fetch_PC;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
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
  wire [31:0] decode_SRC1;
  wire [3:0] writeBack_FORMAL_MEM_RMASK;
  wire [3:0] memory_FORMAL_MEM_RMASK;
  wire [3:0] execute_FORMAL_MEM_RMASK;
  wire  writeBack_RS2_USE;
  wire  memory_RS2_USE;
  wire  execute_RS2_USE;
  wire [31:0] writeBack_RS1;
  wire [31:0] memory_RS1;
  wire [31:0] decode_RS1;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
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
  wire  decode_SRC_LESS_UNSIGNED;
  wire  writeBack_FORMAL_HALT;
  wire  memory_FORMAL_HALT;
  wire  execute_FORMAL_HALT;
  wire  decode_FORMAL_HALT;
  wire  fetch_FORMAL_HALT;
  wire  prefetch_FORMAL_HALT;
  wire [31:0] writeBack_FORMAL_MEM_RDATA;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type zz_12;
  wire `AluCtrlEnum_binary_sequancial_type zz_13;
  wire `AluCtrlEnum_binary_sequancial_type zz_14;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] decode_SRC2;
  wire  decode_SRC_USE_SUB_LESS;
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
  wire  zz_40;
  wire  zz_41;
  wire  zz_42;
  wire  zz_43;
  wire  zz_44;
  wire  zz_45;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_46;
  wire `AluCtrlEnum_binary_sequancial_type zz_47;
  wire  zz_48;
  wire `BranchCtrlEnum_binary_sequancial_type zz_49;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_50;
  wire `Src2CtrlEnum_binary_sequancial_type zz_51;
  wire  zz_52;
  wire [31:0] zz_53;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
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
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  zz_81;
  wire [31:0] zz_82;
  reg [63:0] writeBack_FomalPlugin_order;
  reg  writeBack_FomalPlugin_haltRequest;
  wire  zz_83;
  reg  zz_84;
  reg  zz_85;
  reg  zz_86;
  reg  zz_87;
  reg  zz_88;
  reg  writeBack_FomalPlugin_haltFired;
  reg [31:0] prefetch_PcManagerSimplePlugin_pcReg/* verilator public */ ;
  reg  prefetch_PcManagerSimplePlugin_inc;
  wire [31:0] prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  reg [31:0] prefetch_PcManagerSimplePlugin_pc;
  reg  prefetch_PcManagerSimplePlugin_samplePcNext;
  wire  prefetch_PcManagerSimplePlugin_jump_pcLoad_valid;
  wire [31:0] prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
  reg  prefetch_IBusSimplePlugin_pendingCmd;
  reg  zz_89;
  reg [31:0] zz_90;
  reg [31:0] zz_91;
  reg [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  zz_92;
  reg [31:0] zz_93;
  wire  zz_94;
  reg [31:0] zz_95;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [19:0] zz_96;
  wire  zz_97;
  wire  zz_98;
  wire  zz_99;
  wire  zz_100;
  wire  zz_101;
  wire  zz_102;
  wire  zz_103;
  wire  zz_104;
  wire `Src2CtrlEnum_binary_sequancial_type zz_105;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type zz_106;
  wire `BranchCtrlEnum_binary_sequancial_type zz_107;
  wire `AluCtrlEnum_binary_sequancial_type zz_108;
  wire `ShiftCtrlEnum_binary_sequancial_type zz_109;
  wire `Src1CtrlEnum_binary_sequancial_type zz_110;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  zz_111;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  zz_112;
  reg  writeBack_RegFilePlugin_regFileWrite_valid/* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address/* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data/* verilator public */ ;
  reg  zz_113;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] zz_114;
  reg [31:0] zz_115;
  wire  zz_116;
  reg [19:0] zz_117;
  wire  zz_118;
  reg [19:0] zz_119;
  reg [31:0] zz_120;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrielShifterPlugin_amplitude;
  reg [31:0] zz_121;
  wire [31:0] execute_FullBarrielShifterPlugin_reversed;
  reg [31:0] zz_122;
  reg  zz_123;
  reg  zz_124;
  reg  zz_125;
  reg [4:0] zz_126;
  wire  execute_BranchPlugin_eq;
  wire [2:0] zz_127;
  reg  zz_128;
  reg  zz_129;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  zz_130;
  reg [10:0] zz_131;
  wire  zz_132;
  reg [19:0] zz_133;
  wire  zz_134;
  reg [18:0] zz_135;
  reg [31:0] zz_136;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg  zz_137;
  reg [31:0] zz_138;
  reg [31:0] zz_139;
  reg `AluCtrlEnum_binary_sequancial_type zz_140;
  reg  zz_141;
  reg  zz_142;
  reg  zz_143;
  reg  zz_144;
  reg  zz_145;
  reg  zz_146;
  reg  zz_147;
  reg  zz_148;
  reg  zz_149;
  reg  zz_150;
  reg  zz_151;
  reg [3:0] zz_152;
  reg [3:0] zz_153;
  reg [31:0] zz_154;
  reg [31:0] zz_155;
  reg [31:0] zz_156;
  reg  zz_157;
  reg  zz_158;
  reg  zz_159;
  reg [31:0] zz_160;
  reg [31:0] zz_161;
  reg [31:0] zz_162;
  reg [31:0] zz_163;
  reg  zz_164;
  reg  zz_165;
  reg  zz_166;
  reg [31:0] zz_167;
  reg [31:0] zz_168;
  reg [31:0] zz_169;
  reg  zz_170;
  reg [31:0] zz_171;
  reg [31:0] zz_172;
  reg [31:0] zz_173;
  reg  zz_174;
  reg  zz_175;
  reg  zz_176;
  reg [3:0] zz_177;
  reg [3:0] zz_178;
  reg [31:0] zz_179;
  reg [31:0] zz_180;
  reg [31:0] zz_181;
  reg [31:0] zz_182;
  reg [31:0] zz_183;
  reg [31:0] zz_184;
  reg `ShiftCtrlEnum_binary_sequancial_type zz_185;
  reg `ShiftCtrlEnum_binary_sequancial_type zz_186;
  reg [31:0] zz_187;
  reg [1:0] zz_188;
  reg [1:0] zz_189;
  reg [31:0] zz_190;
  reg [31:0] zz_191;
  reg [31:0] zz_192;
  reg [31:0] zz_193;
  reg [31:0] zz_194;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type zz_195;
  reg [31:0] zz_196;
  reg [31:0] zz_197;
  reg `BranchCtrlEnum_binary_sequancial_type zz_198;
  reg  zz_199;
  reg [31:0] zz_200;
  reg [31:0] zz_201;
  reg [31:0] RegFilePlugin_regFile [0:31]/* verilator public */ ;
  assign rvfi_valid = zz_204;
  assign rvfi_halt = zz_205;
  assign iBus_cmd_valid = zz_206;
  assign dBus_cmd_payload_size = zz_207;
  assign dBus_cmd_payload_address = zz_208;
  assign dBus_cmd_valid = zz_209;
  assign dBus_cmd_payload_wr = zz_210;
  assign dBus_cmd_payload_data = zz_211;
  assign zz_212 = writeBack_INSTRUCTION[13 : 12];
  assign zz_213 = {29'd0, {prefetch_PcManagerSimplePlugin_inc,(2'b00)}};
  assign zz_214 = zz_96[6 : 6];
  assign zz_215 = zz_96[11 : 11];
  assign zz_216 = zz_96[12 : 12];
  assign zz_217 = zz_96[13 : 13];
  assign zz_218 = zz_96[14 : 14];
  assign zz_219 = zz_96[15 : 15];
  assign zz_220 = zz_96[16 : 16];
  assign zz_221 = zz_96[17 : 17];
  assign zz_222 = decode_INSTRUCTION[31 : 20];
  assign zz_223 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign zz_224 = ($signed(zz_225) + $signed(zz_228));
  assign zz_225 = ($signed(zz_226) + $signed(zz_227));
  assign zz_226 = execute_SRC1;
  assign zz_227 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign zz_228 = {{30{zz_229[1]}}, zz_229};
  assign zz_229 = (execute_SRC_USE_SUB_LESS ? zz_230 : zz_231);
  assign zz_230 = (2'b01);
  assign zz_231 = (2'b00);
  assign zz_232 = ($signed(zz_234) >>> execute_FullBarrielShifterPlugin_amplitude);
  assign zz_233 = zz_232[31 : 0];
  assign zz_234 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_FullBarrielShifterPlugin_reversed[31]),execute_FullBarrielShifterPlugin_reversed};
  assign zz_235 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign zz_236 = execute_INSTRUCTION[31 : 20];
  assign zz_237 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  always @ (posedge clk)
  begin
    if(zz_35) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk)
  begin
    if(zz_111) begin
      zz_202 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk)
  begin
    if(zz_112) begin
      zz_203 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  assign writeBack_FORMAL_MEM_ADDR = zz_201;
  assign memory_FORMAL_MEM_ADDR = zz_200;
  assign execute_FORMAL_MEM_ADDR = zz_58;
  assign execute_BRANCH_DO = zz_17;
  assign decode_BRANCH_CTRL = zz_1;
  assign zz_2 = zz_3;
  assign writeBack_REGFILE_WRITE_DATA = zz_197;
  assign memory_REGFILE_WRITE_DATA = zz_196;
  assign execute_REGFILE_WRITE_DATA = zz_33;
  assign decode_ALU_BITWISE_CTRL = zz_4;
  assign zz_5 = zz_6;
  assign memory_PC = zz_193;
  assign fetch_PC = zz_190;
  assign memory_MEMORY_ADDRESS_LOW = zz_188;
  assign execute_MEMORY_ADDRESS_LOW = zz_59;
  assign execute_SHIFT_RIGHT = zz_20;
  assign zz_7 = zz_8;
  assign decode_SHIFT_CTRL = zz_9;
  assign zz_10 = zz_11;
  assign writeBack_FORMAL_PC_NEXT = zz_184;
  assign memory_FORMAL_PC_NEXT = zz_183;
  assign execute_FORMAL_PC_NEXT = zz_182;
  assign decode_FORMAL_PC_NEXT = zz_181;
  assign fetch_FORMAL_PC_NEXT = zz_180;
  assign prefetch_FORMAL_PC_NEXT = zz_67;
  assign decode_SRC1 = zz_31;
  assign writeBack_FORMAL_MEM_RMASK = zz_178;
  assign memory_FORMAL_MEM_RMASK = zz_177;
  assign execute_FORMAL_MEM_RMASK = zz_56;
  assign writeBack_RS2_USE = zz_176;
  assign memory_RS2_USE = zz_175;
  assign execute_RS2_USE = zz_174;
  assign writeBack_RS1 = zz_173;
  assign memory_RS1 = zz_172;
  assign decode_RS1 = zz_37;
  assign decode_BYPASSABLE_EXECUTE_STAGE = zz_44;
  assign memory_MEMORY_READ_DATA = zz_54;
  assign writeBack_FORMAL_MEM_WDATA = zz_168;
  assign memory_FORMAL_MEM_WDATA = zz_167;
  assign execute_FORMAL_MEM_WDATA = zz_55;
  assign decode_MEMORY_ENABLE = zz_43;
  assign fetch_INSTRUCTION = zz_64;
  assign writeBack_RS1_USE = zz_159;
  assign memory_RS1_USE = zz_158;
  assign execute_RS1_USE = zz_157;
  assign writeBack_RS2 = zz_156;
  assign memory_RS2 = zz_155;
  assign decode_RS2 = zz_36;
  assign writeBack_FORMAL_MEM_WMASK = zz_153;
  assign memory_FORMAL_MEM_WMASK = zz_152;
  assign execute_FORMAL_MEM_WMASK = zz_57;
  assign decode_SRC_LESS_UNSIGNED = zz_48;
  assign writeBack_FORMAL_HALT = zz_147;
  assign memory_FORMAL_HALT = zz_146;
  assign execute_FORMAL_HALT = zz_145;
  assign decode_FORMAL_HALT = zz_144;
  assign fetch_FORMAL_HALT = zz_143;
  assign prefetch_FORMAL_HALT = zz_70;
  assign writeBack_FORMAL_MEM_RDATA = zz_53;
  assign execute_BYPASSABLE_MEMORY_STAGE = zz_141;
  assign decode_BYPASSABLE_MEMORY_STAGE = zz_40;
  assign decode_ALU_CTRL = zz_12;
  assign zz_13 = zz_14;
  assign execute_BRANCH_CALC = zz_15;
  assign decode_SRC2 = zz_28;
  assign decode_SRC_USE_SUB_LESS = zz_45;
  assign memory_BRANCH_CALC = zz_139;
  assign memory_BRANCH_DO = zz_199;
  assign execute_PC = zz_192;
  assign execute_RS1 = zz_171;
  assign execute_BRANCH_CTRL = zz_16;
  assign decode_RS2_USE = zz_42;
  assign decode_RS1_USE = zz_41;
  assign execute_REGFILE_WRITE_VALID = zz_149;
  assign execute_BYPASSABLE_EXECUTE_STAGE = zz_170;
  assign memory_REGFILE_WRITE_VALID = zz_150;
  assign memory_BYPASSABLE_MEMORY_STAGE = zz_142;
  assign writeBack_REGFILE_WRITE_VALID = zz_151;
  assign memory_SHIFT_RIGHT = zz_187;
  always @ (memory_REGFILE_WRITE_DATA or memory_SHIFT_CTRL or zz_122 or memory_SHIFT_RIGHT)
  begin
    zz_18 = memory_REGFILE_WRITE_DATA;
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        zz_18 = zz_122;
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
  assign execute_SRC_LESS_UNSIGNED = zz_148;
  assign execute_SRC_USE_SUB_LESS = zz_137;
  assign zz_25 = decode_PC;
  assign zz_26 = decode_RS2;
  assign decode_SRC2_CTRL = zz_27;
  assign zz_29 = decode_RS1;
  assign decode_SRC1_CTRL = zz_30;
  assign execute_SRC_ADD_SUB = zz_24;
  assign execute_SRC_LESS = zz_22;
  assign execute_ALU_CTRL = zz_32;
  assign execute_SRC2 = zz_138;
  assign execute_SRC1 = zz_179;
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
  assign writeBack_MEMORY_ENABLE = zz_166;
  assign writeBack_MEMORY_ADDRESS_LOW = zz_189;
  assign writeBack_MEMORY_READ_DATA = zz_169;
  assign memory_INSTRUCTION = zz_162;
  assign memory_MEMORY_ENABLE = zz_165;
  assign execute_RS2 = zz_154;
  assign execute_SRC_ADD = zz_23;
  assign execute_INSTRUCTION = zz_161;
  assign execute_ALIGNEMENT_FAULT = zz_60;
  assign execute_MEMORY_ENABLE = zz_164;
  assign zz_62 = fetch_INSTRUCTION;
  assign zz_65 = prefetch_PC;
  always @ (memory_FORMAL_PC_NEXT or zz_81 or zz_82)
  begin
    zz_66 = memory_FORMAL_PC_NEXT;
    if(zz_81)begin
      zz_66 = zz_82;
    end
  end

  assign prefetch_PC = zz_68;
  assign prefetch_PC_CALC_WITHOUT_JUMP = zz_69;
  always @ (memory_FORMAL_HALT or memory_arbitration_isValid or memory_BRANCH_DO or zz_82 or memory_MEMORY_ENABLE or memory_INSTRUCTION or dBus_rsp_ready)
  begin
    zz_71 = memory_FORMAL_HALT;
    memory_arbitration_haltItself = 1'b0;
    if(((memory_arbitration_isValid && memory_BRANCH_DO) && (zz_82[1 : 0] != (2'b00))))begin
      zz_71 = 1'b1;
      memory_arbitration_haltItself = 1'b1;
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign zz_72 = execute_FORMAL_HALT;
  always @ (decode_FORMAL_HALT or decodeExceptionPort_valid or decode_arbitration_isValid or zz_123 or zz_124)
  begin
    zz_73 = decode_FORMAL_HALT;
    decode_arbitration_haltItself = 1'b0;
    if(decodeExceptionPort_valid)begin
      zz_73 = 1'b1;
      decode_arbitration_haltItself = 1'b1;
    end
    if((decode_arbitration_isValid && (zz_123 || zz_124)))begin
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
  assign writeBack_PC = zz_194;
  assign writeBack_INSTRUCTION = zz_163;
  assign decode_PC = zz_191;
  assign decode_INSTRUCTION = zz_160;
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
  always @ (fetch_arbitration_isValid or iBus_rsp_ready or zz_89)
  begin
    fetch_arbitration_haltItself = 1'b0;
    if(((fetch_arbitration_isValid && (! iBus_rsp_ready)) && (! zz_89)))begin
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

  always @ (zz_81)
  begin
    execute_arbitration_flushAll = 1'b0;
    if(zz_81)begin
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
  always @ (writeBack_arbitration_isFiring or zz_88 or writeBack_FomalPlugin_haltFired)
  begin
    zz_204 = writeBack_arbitration_isFiring;
    rvfi_trap = 1'b0;
    zz_205 = 1'b0;
    if(zz_88)begin
      zz_204 = 1'b1;
      rvfi_trap = 1'b1;
      zz_205 = 1'b1;
    end
    if(writeBack_FomalPlugin_haltFired)begin
      zz_204 = 1'b0;
    end
  end

  assign rvfi_order = writeBack_FomalPlugin_order;
  assign rvfi_insn = zz_80;
  assign rvfi_intr = 1'b0;
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

  assign zz_83 = 1'b0;
  assign zz_70 = 1'b0;
  assign prefetch_PcManagerSimplePlugin_pcBeforeJumps = (prefetch_PcManagerSimplePlugin_pcReg + zz_213);
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

  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_valid = zz_81;
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_payload = zz_82;
  assign zz_68 = prefetch_PcManagerSimplePlugin_pc;
  assign zz_67 = (prefetch_PC + (32'b00000000000000000000000000000100));
  assign zz_206 = (((prefetch_arbitration_isValid && (! prefetch_arbitration_removeIt)) && (! prefetch_arbitration_isStuckByOthers)) && (! (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))));
  assign iBus_cmd_payload_pc = zz_65;
  always @ (iBus_rsp_inst or zz_89 or zz_90)
  begin
    zz_64 = iBus_rsp_inst;
    if(zz_89)begin
      zz_64 = zz_90;
    end
  end

  assign zz_63 = (decode_arbitration_isStuck ? decode_INSTRUCTION : zz_62);
  assign zz_61 = 1'b1;
  assign zz_60 = 1'b0;
  assign zz_209 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign zz_210 = execute_INSTRUCTION[5];
  assign zz_208 = execute_SRC_ADD;
  assign zz_207 = execute_INSTRUCTION[13 : 12];
  always @ (zz_207 or execute_RS2)
  begin
    case(zz_207)
      2'b00 : begin
        zz_91 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        zz_91 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        zz_91 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign zz_211 = zz_91;
  assign zz_59 = zz_208[1 : 0];
  always @ (zz_207)
  begin
    case(zz_207)
      2'b00 : begin
        execute_DBusSimplePlugin_formalMask = (4'b0001);
      end
      2'b01 : begin
        execute_DBusSimplePlugin_formalMask = (4'b0011);
      end
      default : begin
        execute_DBusSimplePlugin_formalMask = (4'b1111);
      end
    endcase
  end

  assign zz_58 = zz_208;
  assign zz_57 = ((zz_209 && zz_210) ? execute_DBusSimplePlugin_formalMask : (4'b0000));
  assign zz_56 = ((zz_209 && (! zz_210)) ? execute_DBusSimplePlugin_formalMask : (4'b0000));
  assign zz_55 = zz_211;
  assign zz_54 = dBus_rsp_data;
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

  assign zz_92 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (zz_92 or writeBack_DBusSimplePlugin_rspShifted)
  begin
    zz_93[31] = zz_92;
    zz_93[30] = zz_92;
    zz_93[29] = zz_92;
    zz_93[28] = zz_92;
    zz_93[27] = zz_92;
    zz_93[26] = zz_92;
    zz_93[25] = zz_92;
    zz_93[24] = zz_92;
    zz_93[23] = zz_92;
    zz_93[22] = zz_92;
    zz_93[21] = zz_92;
    zz_93[20] = zz_92;
    zz_93[19] = zz_92;
    zz_93[18] = zz_92;
    zz_93[17] = zz_92;
    zz_93[16] = zz_92;
    zz_93[15] = zz_92;
    zz_93[14] = zz_92;
    zz_93[13] = zz_92;
    zz_93[12] = zz_92;
    zz_93[11] = zz_92;
    zz_93[10] = zz_92;
    zz_93[9] = zz_92;
    zz_93[8] = zz_92;
    zz_93[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign zz_94 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
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
    zz_95[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (zz_212 or zz_93 or zz_95 or writeBack_DBusSimplePlugin_rspShifted)
  begin
    case(zz_212)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = zz_93;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = zz_95;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign zz_53 = writeBack_DBusSimplePlugin_rspFormated;
  assign zz_97 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign zz_98 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign zz_99 = ((decode_INSTRUCTION & (32'b00000000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign zz_100 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign zz_101 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign zz_102 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign zz_103 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000000000));
  assign zz_104 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign zz_96 = {({zz_99,zz_101} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100)) != (1'b0)),{({zz_99,{zz_104,{zz_98,{zz_97,((decode_INSTRUCTION & (32'b00000000000000000100000001000000)) == (32'b00000000000000000100000000000000))}}}} != (5'b00000)),{({zz_104,((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000100000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000000)),{zz_103,((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000))}} != (3'b000)),{({zz_102,{((decode_INSTRUCTION & (32'b00000000000000000000000000100100)) == (32'b00000000000000000000000000100000)),zz_100}} != (3'b000)),{(zz_103 != (1'b0)),{({zz_98,{((decode_INSTRUCTION & (32'b00000000000000000010000000100000)) == (32'b00000000000000000010000000100000)),{((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000010000)),{((decode_INSTRUCTION & (32'b00000000000000000001000000100000)) == (32'b00000000000000000000000000100000)),((decode_INSTRUCTION & (32'b00000000000000000001000000010000)) == (32'b00000000000000000000000000010000))}}}} != (5'b00000)),{({zz_102,{((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000)),((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000))}} != (3'b000)),{({((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000101000000010000)),((decode_INSTRUCTION & (32'b00000000000000000111000001100100)) == (32'b00000000000000000101000000100000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b01000000000000000011000000010100)) == (32'b01000000000000000001000000010000)),{((decode_INSTRUCTION & (32'b01000000000000000100000001100100)) == (32'b01000000000000000100000000100000)),((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000001000000010000))}} != (3'b000)),{({((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000)),((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100))} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000)) != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000000000)),((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000001000000000000))} != (2'b00)),{({zz_99,zz_101} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001000000)) != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000)),zz_98} != (2'b00)),{({zz_98,((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000))} != (2'b00)),{({zz_99,{zz_98,zz_100}} != (3'b000)),({zz_99,{zz_98,zz_97}} != (3'b000))}}}}}}}}}}}}}}}}}}};
  assign zz_52 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011)),{((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000111000001111011)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & (32'b11111110000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & (32'b11111100000000000011000001111111)) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011)),((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011))}}}}}}}}}}}}}}} != (16'b0000000000000000));
  assign zz_105 = zz_96[1 : 0];
  assign zz_51 = zz_105;
  assign zz_106 = zz_96[3 : 2];
  assign zz_50 = zz_106;
  assign zz_107 = zz_96[5 : 4];
  assign zz_49 = zz_107;
  assign zz_48 = zz_214[0];
  assign zz_108 = zz_96[8 : 7];
  assign zz_47 = zz_108;
  assign zz_109 = zz_96[10 : 9];
  assign zz_46 = zz_109;
  assign zz_45 = zz_215[0];
  assign zz_44 = zz_216[0];
  assign zz_43 = zz_217[0];
  assign zz_42 = zz_218[0];
  assign zz_41 = zz_219[0];
  assign zz_40 = zz_220[0];
  assign zz_39 = zz_221[0];
  assign zz_110 = zz_96[19 : 18];
  assign zz_38 = zz_110;
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign zz_111 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = zz_202;
  assign zz_112 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = zz_203;
  assign zz_37 = decode_RegFilePlugin_rs1Data;
  assign zz_36 = decode_RegFilePlugin_rs2Data;
  always @ (zz_77 or writeBack_arbitration_isFiring or zz_113)
  begin
    writeBack_RegFilePlugin_regFileWrite_valid = (zz_77 && writeBack_arbitration_isFiring);
    if(zz_113)begin
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
        zz_114 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        zz_114 = {31'd0, execute_SRC_LESS};
      end
      default : begin
        zz_114 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign zz_33 = zz_114;
  always @ (decode_SRC1_CTRL or zz_29 or decode_INSTRUCTION)
  begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        zz_115 = zz_29;
      end
      `Src1CtrlEnum_binary_sequancial_FOUR : begin
        zz_115 = (32'b00000000000000000000000000000100);
      end
      default : begin
        zz_115 = {decode_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign zz_31 = zz_115;
  assign zz_116 = zz_222[11];
  always @ (zz_116)
  begin
    zz_117[19] = zz_116;
    zz_117[18] = zz_116;
    zz_117[17] = zz_116;
    zz_117[16] = zz_116;
    zz_117[15] = zz_116;
    zz_117[14] = zz_116;
    zz_117[13] = zz_116;
    zz_117[12] = zz_116;
    zz_117[11] = zz_116;
    zz_117[10] = zz_116;
    zz_117[9] = zz_116;
    zz_117[8] = zz_116;
    zz_117[7] = zz_116;
    zz_117[6] = zz_116;
    zz_117[5] = zz_116;
    zz_117[4] = zz_116;
    zz_117[3] = zz_116;
    zz_117[2] = zz_116;
    zz_117[1] = zz_116;
    zz_117[0] = zz_116;
  end

  assign zz_118 = zz_223[11];
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

  always @ (decode_SRC2_CTRL or zz_26 or zz_117 or decode_INSTRUCTION or zz_119 or zz_25)
  begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        zz_120 = zz_26;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        zz_120 = {zz_117,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        zz_120 = {zz_119,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        zz_120 = zz_25;
      end
    endcase
  end

  assign zz_28 = zz_120;
  assign execute_SrcPlugin_addSub = zz_224;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign zz_24 = execute_SrcPlugin_addSub;
  assign zz_23 = execute_SrcPlugin_addSub;
  assign zz_22 = execute_SrcPlugin_less;
  assign execute_FullBarrielShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (execute_SRC1)
  begin
    zz_121[0] = execute_SRC1[31];
    zz_121[1] = execute_SRC1[30];
    zz_121[2] = execute_SRC1[29];
    zz_121[3] = execute_SRC1[28];
    zz_121[4] = execute_SRC1[27];
    zz_121[5] = execute_SRC1[26];
    zz_121[6] = execute_SRC1[25];
    zz_121[7] = execute_SRC1[24];
    zz_121[8] = execute_SRC1[23];
    zz_121[9] = execute_SRC1[22];
    zz_121[10] = execute_SRC1[21];
    zz_121[11] = execute_SRC1[20];
    zz_121[12] = execute_SRC1[19];
    zz_121[13] = execute_SRC1[18];
    zz_121[14] = execute_SRC1[17];
    zz_121[15] = execute_SRC1[16];
    zz_121[16] = execute_SRC1[15];
    zz_121[17] = execute_SRC1[14];
    zz_121[18] = execute_SRC1[13];
    zz_121[19] = execute_SRC1[12];
    zz_121[20] = execute_SRC1[11];
    zz_121[21] = execute_SRC1[10];
    zz_121[22] = execute_SRC1[9];
    zz_121[23] = execute_SRC1[8];
    zz_121[24] = execute_SRC1[7];
    zz_121[25] = execute_SRC1[6];
    zz_121[26] = execute_SRC1[5];
    zz_121[27] = execute_SRC1[4];
    zz_121[28] = execute_SRC1[3];
    zz_121[29] = execute_SRC1[2];
    zz_121[30] = execute_SRC1[1];
    zz_121[31] = execute_SRC1[0];
  end

  assign execute_FullBarrielShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SLL_1) ? zz_121 : execute_SRC1);
  assign zz_20 = zz_233;
  always @ (memory_SHIFT_RIGHT)
  begin
    zz_122[0] = memory_SHIFT_RIGHT[31];
    zz_122[1] = memory_SHIFT_RIGHT[30];
    zz_122[2] = memory_SHIFT_RIGHT[29];
    zz_122[3] = memory_SHIFT_RIGHT[28];
    zz_122[4] = memory_SHIFT_RIGHT[27];
    zz_122[5] = memory_SHIFT_RIGHT[26];
    zz_122[6] = memory_SHIFT_RIGHT[25];
    zz_122[7] = memory_SHIFT_RIGHT[24];
    zz_122[8] = memory_SHIFT_RIGHT[23];
    zz_122[9] = memory_SHIFT_RIGHT[22];
    zz_122[10] = memory_SHIFT_RIGHT[21];
    zz_122[11] = memory_SHIFT_RIGHT[20];
    zz_122[12] = memory_SHIFT_RIGHT[19];
    zz_122[13] = memory_SHIFT_RIGHT[18];
    zz_122[14] = memory_SHIFT_RIGHT[17];
    zz_122[15] = memory_SHIFT_RIGHT[16];
    zz_122[16] = memory_SHIFT_RIGHT[15];
    zz_122[17] = memory_SHIFT_RIGHT[14];
    zz_122[18] = memory_SHIFT_RIGHT[13];
    zz_122[19] = memory_SHIFT_RIGHT[12];
    zz_122[20] = memory_SHIFT_RIGHT[11];
    zz_122[21] = memory_SHIFT_RIGHT[10];
    zz_122[22] = memory_SHIFT_RIGHT[9];
    zz_122[23] = memory_SHIFT_RIGHT[8];
    zz_122[24] = memory_SHIFT_RIGHT[7];
    zz_122[25] = memory_SHIFT_RIGHT[6];
    zz_122[26] = memory_SHIFT_RIGHT[5];
    zz_122[27] = memory_SHIFT_RIGHT[4];
    zz_122[28] = memory_SHIFT_RIGHT[3];
    zz_122[29] = memory_SHIFT_RIGHT[2];
    zz_122[30] = memory_SHIFT_RIGHT[1];
    zz_122[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (zz_125 or zz_126 or decode_INSTRUCTION or writeBack_arbitration_isValid or writeBack_REGFILE_WRITE_VALID or writeBack_INSTRUCTION or memory_arbitration_isValid or memory_REGFILE_WRITE_VALID or memory_BYPASSABLE_MEMORY_STAGE or memory_INSTRUCTION or execute_arbitration_isValid or execute_REGFILE_WRITE_VALID or execute_BYPASSABLE_EXECUTE_STAGE or execute_INSTRUCTION or decode_RS1_USE or decode_RS2_USE)
  begin
    zz_123 = 1'b0;
    zz_124 = 1'b0;
    if(zz_125)begin
      if((zz_126 == decode_INSTRUCTION[19 : 15]))begin
        zz_123 = 1'b1;
      end
      if((zz_126 == decode_INSTRUCTION[24 : 20]))begin
        zz_124 = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! 1'b1)))begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_123 = 1'b1;
        end
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_124 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_123 = 1'b1;
        end
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_124 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          zz_123 = 1'b1;
        end
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          zz_124 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      zz_123 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      zz_124 = 1'b0;
    end
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign zz_127 = execute_INSTRUCTION[14 : 12];
  always @ (zz_127 or execute_BranchPlugin_eq or execute_SRC_LESS)
  begin
    if((zz_127 == (3'b000))) begin
        zz_128 = execute_BranchPlugin_eq;
    end else if((zz_127 == (3'b001))) begin
        zz_128 = (! execute_BranchPlugin_eq);
    end else if((((zz_127 & (3'b101)) == (3'b101)))) begin
        zz_128 = (! execute_SRC_LESS);
    end else begin
        zz_128 = execute_SRC_LESS;
    end
  end

  always @ (execute_BRANCH_CTRL or zz_128)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        zz_129 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        zz_129 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        zz_129 = 1'b1;
      end
      default : begin
        zz_129 = zz_128;
      end
    endcase
  end

  assign zz_17 = zz_129;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? execute_RS1 : execute_PC);
  assign zz_130 = zz_235[19];
  always @ (zz_130)
  begin
    zz_131[10] = zz_130;
    zz_131[9] = zz_130;
    zz_131[8] = zz_130;
    zz_131[7] = zz_130;
    zz_131[6] = zz_130;
    zz_131[5] = zz_130;
    zz_131[4] = zz_130;
    zz_131[3] = zz_130;
    zz_131[2] = zz_130;
    zz_131[1] = zz_130;
    zz_131[0] = zz_130;
  end

  assign zz_132 = zz_236[11];
  always @ (zz_132)
  begin
    zz_133[19] = zz_132;
    zz_133[18] = zz_132;
    zz_133[17] = zz_132;
    zz_133[16] = zz_132;
    zz_133[15] = zz_132;
    zz_133[14] = zz_132;
    zz_133[13] = zz_132;
    zz_133[12] = zz_132;
    zz_133[11] = zz_132;
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

  assign zz_134 = zz_237[11];
  always @ (zz_134)
  begin
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

  always @ (execute_BRANCH_CTRL or zz_131 or execute_INSTRUCTION or zz_133 or zz_135)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        zz_136 = {{zz_131,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        zz_136 = {zz_133,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        zz_136 = {{zz_135,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = zz_136;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign zz_15 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign zz_81 = (memory_arbitration_isFiring && memory_BRANCH_DO);
  assign zz_82 = memory_BRANCH_CALC;
  assign zz_14 = decode_ALU_CTRL;
  assign zz_12 = zz_47;
  assign zz_32 = zz_140;
  assign zz_27 = zz_51;
  assign zz_30 = zz_38;
  assign zz_11 = decode_SHIFT_CTRL;
  assign zz_8 = execute_SHIFT_CTRL;
  assign zz_9 = zz_46;
  assign zz_21 = zz_185;
  assign zz_19 = zz_186;
  assign zz_6 = decode_ALU_BITWISE_CTRL;
  assign zz_4 = zz_50;
  assign zz_34 = zz_195;
  assign zz_3 = decode_BRANCH_CTRL;
  assign zz_1 = zz_49;
  assign zz_16 = zz_198;
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
      zz_84 <= zz_83;
      zz_85 <= zz_83;
      zz_86 <= zz_83;
      zz_87 <= zz_83;
      zz_88 <= zz_83;
      writeBack_FomalPlugin_haltFired <= 1'b0;
      prefetch_PcManagerSimplePlugin_pcReg <= (32'b00000000000000000000000000000000);
      prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      prefetch_IBusSimplePlugin_pendingCmd <= 1'b0;
      zz_89 <= 1'b0;
      zz_113 <= 1'b1;
      zz_125 <= 1'b0;
      zz_197 <= (32'b00000000000000000000000000000000);
      zz_163 <= (32'b00000000000000000000000000000000);
    end else begin
      if(writeBack_arbitration_isFiring)begin
        writeBack_FomalPlugin_order <= (writeBack_FomalPlugin_order + (64'b0000000000000000000000000000000000000000000000000000000000000001));
      end
      zz_84 <= writeBack_FomalPlugin_haltRequest;
      zz_85 <= zz_84;
      zz_86 <= zz_85;
      zz_87 <= zz_86;
      zz_88 <= zz_87;
      if((zz_204 && zz_205))begin
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
      if((zz_206 && iBus_cmd_ready))begin
        prefetch_IBusSimplePlugin_pendingCmd <= 1'b1;
      end
      if(iBus_rsp_ready)begin
        zz_89 <= 1'b1;
      end
      if((! fetch_arbitration_isStuck))begin
        zz_89 <= 1'b0;
      end
      zz_113 <= 1'b0;
      zz_125 <= (zz_77 && writeBack_arbitration_isFiring);
      if((! writeBack_arbitration_isStuck))begin
        zz_163 <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        zz_197 <= zz_18;
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
    if((! zz_89))begin
      zz_90 <= iBus_rsp_inst;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    zz_126 <= zz_80[11 : 7];
    if((! execute_arbitration_isStuck))begin
      zz_137 <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      zz_138 <= decode_SRC2;
    end
    if((! memory_arbitration_isStuck))begin
      zz_139 <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_140 <= zz_13;
    end
    if((! execute_arbitration_isStuck))begin
      zz_141 <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_142 <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_143 <= zz_75;
    end
    if((! decode_arbitration_isStuck))begin
      zz_144 <= zz_74;
    end
    if((! execute_arbitration_isStuck))begin
      zz_145 <= zz_73;
    end
    if((! memory_arbitration_isStuck))begin
      zz_146 <= zz_72;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_147 <= zz_71;
    end
    if((! execute_arbitration_isStuck))begin
      zz_148 <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      zz_149 <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      zz_150 <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_151 <= memory_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      zz_152 <= execute_FORMAL_MEM_WMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_153 <= memory_FORMAL_MEM_WMASK;
    end
    if((! execute_arbitration_isStuck))begin
      zz_154 <= zz_26;
    end
    if((! memory_arbitration_isStuck))begin
      zz_155 <= execute_RS2;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_156 <= memory_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      zz_157 <= decode_RS1_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_158 <= execute_RS1_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_159 <= memory_RS1_USE;
    end
    if((! decode_arbitration_isStuck))begin
      zz_160 <= zz_62;
    end
    if((! execute_arbitration_isStuck))begin
      zz_161 <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      zz_162 <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      zz_164 <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_165 <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_166 <= memory_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_167 <= execute_FORMAL_MEM_WDATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_168 <= memory_FORMAL_MEM_WDATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_169 <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      zz_170 <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      zz_171 <= zz_29;
    end
    if((! memory_arbitration_isStuck))begin
      zz_172 <= execute_RS1;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_173 <= memory_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      zz_174 <= decode_RS2_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_175 <= execute_RS2_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_176 <= memory_RS2_USE;
    end
    if((! memory_arbitration_isStuck))begin
      zz_177 <= execute_FORMAL_MEM_RMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_178 <= memory_FORMAL_MEM_RMASK;
    end
    if((! execute_arbitration_isStuck))begin
      zz_179 <= decode_SRC1;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_180 <= prefetch_FORMAL_PC_NEXT;
    end
    if((! decode_arbitration_isStuck))begin
      zz_181 <= fetch_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      zz_182 <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      zz_183 <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_184 <= zz_66;
    end
    if((! execute_arbitration_isStuck))begin
      zz_185 <= zz_10;
    end
    if((! memory_arbitration_isStuck))begin
      zz_186 <= zz_7;
    end
    if((! memory_arbitration_isStuck))begin
      zz_187 <= execute_SHIFT_RIGHT;
    end
    if((! memory_arbitration_isStuck))begin
      zz_188 <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_189 <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! fetch_arbitration_isStuck))begin
      zz_190 <= zz_65;
    end
    if((! decode_arbitration_isStuck))begin
      zz_191 <= fetch_PC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_192 <= zz_25;
    end
    if((! memory_arbitration_isStuck))begin
      zz_193 <= execute_PC;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_194 <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      zz_195 <= zz_5;
    end
    if((! memory_arbitration_isStuck))begin
      zz_196 <= execute_REGFILE_WRITE_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      zz_198 <= zz_2;
    end
    if((! memory_arbitration_isStuck))begin
      zz_199 <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      zz_200 <= execute_FORMAL_MEM_ADDR;
    end
    if((! writeBack_arbitration_isStuck))begin
      zz_201 <= memory_FORMAL_MEM_ADDR;
    end
    if (!(prefetch_arbitration_removeIt == 1'b0)) begin
      $display("ERROR removeIt should never be asserted on this stage");
    end
  end

endmodule


