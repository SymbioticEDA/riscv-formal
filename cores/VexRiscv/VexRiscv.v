// Generator : SpinalHDL v0.10.15    git head : b2cc963be712aa10e43c07c8c2d261d3433a28ef
// Date      : 06/11/2017, 22:40:17
// Component : VexRiscv


`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 'b10

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 'b00
`define Src1CtrlEnum_binary_sequancial_IMU 'b01
`define Src1CtrlEnum_binary_sequancial_FOUR 'b10

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 'b00
`define Src2CtrlEnum_binary_sequancial_IMI 'b01
`define Src2CtrlEnum_binary_sequancial_IMS 'b10
`define Src2CtrlEnum_binary_sequancial_PC 'b11

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 'b00
`define BranchCtrlEnum_binary_sequancial_B 'b01
`define BranchCtrlEnum_binary_sequancial_JAL 'b10
`define BranchCtrlEnum_binary_sequancial_JALR 'b11

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 'b11

module VexRiscv
( 
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
  input   reset 
);

  reg  prefetch_arbitration_haltItself;
  wire  prefetch_arbitration_haltByOther;
  wire  prefetch_arbitration_removeIt;
  wire  _1;
  reg  prefetch_arbitration_isValid;
  wire  prefetch_arbitration_isStuck;
  wire  prefetch_arbitration_isStuckByOthers;
  wire  prefetch_arbitration_isFiring;
  reg  fetch_arbitration_haltItself;
  wire  fetch_arbitration_haltByOther;
  reg  fetch_arbitration_removeIt;
  wire  fetch_arbitration_flushAll;
  wire  _2;
  reg  fetch_arbitration_isValid;
  wire  fetch_arbitration_isStuck;
  wire  fetch_arbitration_isStuckByOthers;
  wire  fetch_arbitration_isFlushed;
  reg  decode_arbitration_haltItself/* verilator public */ ;
  wire  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushAll;
  wire  _3;
  reg  decode_arbitration_isValid/* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  wire  _4;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  wire  memory_arbitration_flushAll;
  wire  _5;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  wire  _6;
  reg  writeBack_arbitration_isValid/* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isFiring/* verilator public */ ;
  reg [31:0] decode_INSTRUCTION/* verilator public */ ;
  wire [31:0] decode_PC/* verilator public */ ;
  reg [31:0] writeBack_INSTRUCTION/* verilator public */ ;
  wire [31:0] writeBack_PC/* verilator public */ ;
  wire  decodeExceptionPort_valid;
  wire  _7;
  wire [31:0] _8;
  wire  _9;
  reg [63:0] writeBack_FomalPlugin_order;
  wire [63:0] _10;
  wire [31:0] _11;
  wire  _12;
  wire  _13;
  wire  _14;
  wire  _15;
  wire [4:0] _16;
  wire [4:0] _17;
  wire  _18;
  wire [4:0] _19;
  wire [4:0] _20;
  wire  _21;
  wire [4:0] _22;
  wire [4:0] _23;
  reg [31:0] _24;
  reg  writeBack_FomalPlugin_haltRequest;
  wire  _25;
  wire  _26;
  wire  _27;
  wire  _28;
  wire  _29;
  wire  _30;
  wire  _31;
  reg  _32;
  wire  _33;
  wire  _34;
  wire  _35;
  wire  _36;
  wire  _37;
  reg  _38;
  wire  _39;
  wire  _40;
  wire  _41;
  wire  _42;
  wire  _43;
  reg  _44;
  reg  _45;
  reg  _46;
  reg  _47;
  reg  _48;
  wire  _49;
  wire  _50;
  wire  _51;
  wire  _52;
  reg  writeBack_FomalPlugin_haltFired;
  wire  _53;
  wire  _54;
  wire  _55;
  wire  _56;
  wire  _57;
  wire  _58;
  wire  _59;
  wire  _60;
  wire  _61;
  wire  _62;
  reg [31:0] prefetch_PcManagerSimplePlugin_pcReg/* verilator public */ ;
  wire  _63;
  reg  prefetch_PcManagerSimplePlugin_inc;
  wire [1:0] _64;
  wire [2:0] _65;
  wire [31:0] prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  reg [31:0] prefetch_PcManagerSimplePlugin_pc;
  wire [31:0] prefetch_PC_CALC_WITHOUT_JUMP;
  reg  prefetch_PcManagerSimplePlugin_samplePcNext;
  wire  prefetch_PcManagerSimplePlugin_jump_pcLoad_valid;
  wire [31:0] prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
  wire  _66;
  wire  _67;
  wire  _68;
  wire  _69;
  wire  _70;
  wire [31:0] prefetch_PC;
  wire [31:0] _71;
  reg [31:0] _72;
  wire  _73;
  reg  prefetch_IBusSimplePlugin_pendingCmd;
  wire  _74;
  wire  _75;
  wire [31:0] _76;
  wire  _77;
  wire  _78;
  wire  _79;
  reg  _80;
  wire  _81;
  wire  _82;
  reg [31:0] _83;
  reg [31:0] _84;
  wire  _85;
  wire  _86;
  wire [31:0] _87;
  wire  _88;
  wire  _89;
  reg  execute_MEMORY_ENABLE;
  wire  execute_ALIGNEMENT_FAULT;
  reg [31:0] execute_INSTRUCTION;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] _90;
  wire [1:0] _91;
  reg [31:0] execute_RS2;
  reg [31:0] _92;
  wire  _93;
  wire  _94;
  wire [1:0] _95;
  wire [3:0] _96;
  wire [3:0] _97;
  wire [3:0] _98;
  reg [3:0] execute_DBusSimplePlugin_formalMask;
  wire [3:0] _99;
  wire [3:0] _100;
  reg  memory_MEMORY_ENABLE;
  reg [31:0] memory_INSTRUCTION;
  wire  _101;
  wire  _102;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  reg [31:0] writeBack_MEMORY_READ_DATA;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [1:0] _103;
  wire [1:0] _104;
  wire [1:0] _105;
  wire  _106;
  reg [31:0] _107;
  wire  _108;
  reg [31:0] _109;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  reg  writeBack_MEMORY_ENABLE;
  wire  _110;
  wire [19:0] _111;
  wire  _112;
  wire  _113;
  wire  _114;
  wire  _115;
  wire  _116;
  wire  _117;
  wire  _118;
  wire  _119;
  wire [31:0] _120;
  wire [31:0] _121;
  wire [31:0] _122;
  wire [31:0] _123;
  wire [31:0] _124;
  wire [0:0] _125;
  wire [0:0] _126;
  wire [0:0] _127;
  wire [0:0] _128;
  wire [0:0] _129;
  wire [0:0] _130;
  wire [0:0] _131;
  wire [0:0] _132;
  wire  decode_INSTRUCTION_READY;
  wire  decode_LEGAL_INSTRUCTION;
  reg [31:0] RegFilePlugin_regFile [0:31]/* verilator public */ ;
  reg  decode_REGFILE_WRITE_VALID;
  wire  _133;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  reg [31:0] RegFilePlugin_regFile_port0_data;
  wire [4:0] RegFilePlugin_regFile_port0_address;
  wire  RegFilePlugin_regFile_port0_enable;
  wire  _134;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  reg [31:0] RegFilePlugin_regFile_port1_data;
  wire [4:0] RegFilePlugin_regFile_port1_address;
  wire  RegFilePlugin_regFile_port1_enable;
  wire  _135;
  reg  writeBack_RegFilePlugin_regFileWrite_valid/* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address/* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data/* verilator public */ ;
  wire [4:0] RegFilePlugin_regFile_port2_address;
  wire [31:0] RegFilePlugin_regFile_port2_data;
  wire  RegFilePlugin_regFile_port2_enable;
  wire [4:0] _136;
  wire  _137;
  reg  _138;
  wire  _139;
  wire  _140;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  reg [31:0] execute_SRC1;
  reg [31:0] execute_SRC2;
  reg [31:0] execute_IntAluPlugin_bitwise;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _141;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _142;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _143;
  reg `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire  execute_SRC_LESS;
  wire [31:0] _144;
  wire [31:0] execute_SRC_ADD_SUB;
  reg [31:0] _145;
  wire `AluCtrlEnum_binary_sequancial_type _146;
  wire `AluCtrlEnum_binary_sequancial_type _147;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire [31:0] _148;
  wire [11:0] _149;
  reg [31:0] _150;
  wire `Src1CtrlEnum_binary_sequancial_type _151;
  wire `Src1CtrlEnum_binary_sequancial_type _152;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire [31:0] _153;
  wire [11:0] _154;
  wire  _155;
  reg [19:0] _156;
  wire [11:0] _157;
  wire  _158;
  reg [19:0] _159;
  wire [31:0] _160;
  reg [31:0] _161;
  wire `Src2CtrlEnum_binary_sequancial_type _162;
  wire `Src2CtrlEnum_binary_sequancial_type _163;
  wire `Src2CtrlEnum_binary_sequancial_type _164;
  wire [31:0] _165;
  reg  execute_SRC_USE_SUB_LESS;
  wire [31:0] _166;
  wire [31:0] _167;
  wire [1:0] _168;
  wire [1:0] _169;
  wire [31:0] _170;
  wire [31:0] execute_SrcPlugin_addSub;
  reg  execute_SRC_LESS_UNSIGNED;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrielShifterPlugin_amplitude;
  reg `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _171;
  reg [31:0] _172;
  wire [31:0] execute_FullBarrielShifterPlugin_reversed;
  wire `ShiftCtrlEnum_binary_sequancial_type _173;
  wire [32:0] _174;
  wire [32:0] _175;
  wire [31:0] _176;
  reg `ShiftCtrlEnum_binary_sequancial_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _177;
  reg [31:0] _178;
  reg [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _179;
  wire `ShiftCtrlEnum_binary_sequancial_type _180;
  wire `ShiftCtrlEnum_binary_sequancial_type _181;
  reg  _182;
  reg  _183;
  reg  _184;
  reg [4:0] _185;
  wire  _186;
  wire  _187;
  wire  _188;
  wire  _189;
  wire  _190;
  wire  _191;
  reg  writeBack_REGFILE_WRITE_VALID;
  wire  _192;
  wire  _193;
  wire  _194;
  wire  _195;
  wire  _196;
  reg  memory_BYPASSABLE_MEMORY_STAGE;
  reg  memory_REGFILE_WRITE_VALID;
  wire  _197;
  wire  _198;
  wire  _199;
  wire  _200;
  wire  _201;
  reg  execute_BYPASSABLE_EXECUTE_STAGE;
  reg  execute_REGFILE_WRITE_VALID;
  wire  _202;
  wire  _203;
  wire  _204;
  wire  _205;
  wire  _206;
  wire  decode_RS1_USE;
  wire  _207;
  wire  decode_RS2_USE;
  wire  _208;
  wire  _209;
  wire  execute_BranchPlugin_eq;
  reg `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire  _210;
  wire  _211;
  wire  _212;
  wire [2:0] _213;
  wire [2:0] _214;
  wire [2:0] _215;
  reg  _216;
  wire [2:0] _217;
  wire [2:0] _218;
  reg  _219;
  wire `BranchCtrlEnum_binary_sequancial_type _220;
  wire `BranchCtrlEnum_binary_sequancial_type _221;
  wire `BranchCtrlEnum_binary_sequancial_type _222;
  wire `BranchCtrlEnum_binary_sequancial_type _223;
  reg [31:0] execute_RS1;
  wire [31:0] _224;
  wire [31:0] execute_PC;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire [19:0] _225;
  wire  _226;
  reg [10:0] _227;
  wire  _228;
  wire [11:0] _229;
  wire  _230;
  reg [19:0] _231;
  wire [11:0] _232;
  wire  _233;
  reg [18:0] _234;
  wire  _235;
  reg [31:0] _236;
  wire `BranchCtrlEnum_binary_sequancial_type _237;
  wire `BranchCtrlEnum_binary_sequancial_type _238;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  wire [30:0] _239;
  wire `BranchCtrlEnum_binary_sequancial_type _240;
  wire  _241;
  wire [31:0] _242;
  reg  memory_BRANCH_DO;
  wire [31:0] memory_BRANCH_CALC;
  wire  _243;
  wire  _244;
  wire [1:0] _245;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  reg [31:0] memory_REGFILE_WRITE_DATA;
  reg [31:0] writeBack_REGFILE_WRITE_DATA;
  reg  execute_RS2_USE;
  reg  memory_RS2_USE;
  reg  writeBack_RS2_USE;
  wire [31:0] decode_RS1;
  reg [31:0] memory_RS1;
  reg [31:0] writeBack_RS1;
  wire [31:0] decode_RS2;
  reg [31:0] memory_RS2;
  reg [31:0] writeBack_RS2;
  wire [31:0] execute_FORMAL_MEM_WDATA;
  reg [31:0] memory_FORMAL_MEM_WDATA;
  reg [31:0] writeBack_FORMAL_MEM_WDATA;
  wire [31:0] execute_BRANCH_CALC;
  reg [31:0] _246;
  wire [31:0] fetch_PC;
  wire [31:0] memory_PC;
  reg [31:0] _247;
  reg [31:0] _248;
  reg [31:0] _249;
  reg [31:0] _250;
  reg [31:0] _251;
  wire  execute_BRANCH_DO;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  reg [1:0] _252;
  reg [1:0] _253;
  wire [31:0] decode_SRC2;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  reg  execute_RS1_USE;
  reg  memory_RS1_USE;
  reg  writeBack_RS1_USE;
  wire [3:0] execute_FORMAL_MEM_RMASK;
  reg [3:0] memory_FORMAL_MEM_RMASK;
  reg [3:0] writeBack_FORMAL_MEM_RMASK;
  wire [31:0] execute_FORMAL_MEM_ADDR;
  wire [31:0] memory_FORMAL_MEM_ADDR;
  wire [31:0] writeBack_FORMAL_MEM_ADDR;
  reg [31:0] _254;
  reg [31:0] _255;
  wire  prefetch_FORMAL_HALT;
  reg  fetch_FORMAL_HALT;
  reg  decode_FORMAL_HALT;
  reg  execute_FORMAL_HALT;
  reg  memory_FORMAL_HALT;
  reg  writeBack_FORMAL_HALT;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire  decode_SRC_LESS_UNSIGNED;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire [3:0] execute_FORMAL_MEM_WMASK;
  reg [3:0] memory_FORMAL_MEM_WMASK;
  reg [3:0] writeBack_FORMAL_MEM_WMASK;
  wire [31:0] writeBack_FORMAL_MEM_RDATA;
  wire [31:0] fetch_INSTRUCTION;
  wire [31:0] prefetch_FORMAL_PC_NEXT;
  wire [31:0] fetch_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  reg [31:0] _256;
  reg [31:0] _257;
  reg [31:0] _258;
  reg [31:0] _259;
  reg [31:0] _260;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire [31:0] execute_SHIFT_RIGHT;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  reg  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] decode_SRC1;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire  decode_SRC_USE_SUB_LESS;
  wire  _261;
  wire  _262;
  wire  _263;
  wire  _264;
  wire  _265;
  wire  _266;
  wire  _267;
  wire  _268;
  wire  _269;
  wire  _270;
  wire  _271;
  wire  _272;
  wire  _273;
  wire  _274;
  wire  _275;
  wire  _276;
  wire  _277;
  wire  _278;
  wire  _279;
  wire  _280;
  wire  _281;
  wire  _282;
  wire  _283;
  wire  _284;
  wire [31:0] _285;
  reg  _286;
  reg  _287;
  wire [1:0] _288;
  wire  _289;
  wire  _290;
  wire [31:0] _291;
  wire [31:0] _292;
  wire [1:0] _293;
  wire [31:0] _294;
  wire [4:0] _295;
  wire [4:0] _296;
  wire [4:0] _297;
  assign prefetch_arbitration_haltByOther = 1'b0;
  assign prefetch_arbitration_removeIt = 1'b0;
  assign _1 = 1'b0;
  assign prefetch_arbitration_isStuck = (prefetch_arbitration_haltItself || prefetch_arbitration_isStuckByOthers);
  assign prefetch_arbitration_isStuckByOthers = (prefetch_arbitration_haltByOther || (((((_273 || fetch_arbitration_haltItself) || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign prefetch_arbitration_isFiring = ((prefetch_arbitration_isValid && (! prefetch_arbitration_isStuck)) && (! prefetch_arbitration_removeIt));
  assign fetch_arbitration_haltByOther = 1'b0;
  assign fetch_arbitration_flushAll = 1'b0;
  assign _2 = 1'b0;
  assign fetch_arbitration_isStuck = (fetch_arbitration_haltItself || fetch_arbitration_isStuckByOthers);
  assign fetch_arbitration_isStuckByOthers = (fetch_arbitration_haltByOther || ((((_274 || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign fetch_arbitration_isFlushed = ((((fetch_arbitration_flushAll || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign decode_arbitration_haltByOther = 1'b0;
  assign decode_arbitration_flushAll = 1'b0;
  assign _3 = 1'b0;
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((_275 || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_haltByOther = 1'b0;
  assign _4 = 1'b0;
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((_276 || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_haltByOther = 1'b0;
  assign memory_arbitration_flushAll = 1'b0;
  assign _5 = 1'b0;
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (_277 || writeBack_arbitration_haltItself));
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  assign writeBack_arbitration_flushAll = 1'b0;
  assign _6 = 1'b0;
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || _278);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign decode_PC = _248;
  assign writeBack_PC = _251;
  assign rvfi_valid = _286;
  assign rvfi_order = writeBack_FomalPlugin_order;
  assign rvfi_insn = _11;
  assign rvfi_halt = _287;
  assign rvfi_intr = _14;
  assign rvfi_rs1_addr = _17;
  assign rvfi_rs1_rdata = (_15 ? writeBack_RS1 : (32'b00000000000000000000000000000000));
  assign rvfi_rs2_addr = _20;
  assign rvfi_rs2_rdata = (_18 ? writeBack_RS2 : (32'b00000000000000000000000000000000));
  assign rvfi_rd_addr = _23;
  assign rvfi_rd_wdata = (_21 ? _24 : (32'b00000000000000000000000000000000));
  assign rvfi_pc_rdata = writeBack_PC;
  assign rvfi_pc_wdata = writeBack_FORMAL_PC_NEXT;
  assign rvfi_mem_addr = writeBack_FORMAL_MEM_ADDR;
  assign rvfi_mem_rmask = writeBack_FORMAL_MEM_RMASK;
  assign rvfi_mem_wmask = writeBack_FORMAL_MEM_WMASK;
  assign rvfi_mem_rdata = writeBack_FORMAL_MEM_RDATA;
  assign rvfi_mem_wdata = writeBack_FORMAL_MEM_WDATA;
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign _7 = (memory_arbitration_isFiring && memory_BRANCH_DO);
  assign _8 = memory_BRANCH_CALC;
  assign _9 = ((memory_arbitration_isValid && memory_BRANCH_DO) && (_245 != (2'b00)));
  assign _10 = (writeBack_FomalPlugin_order + (64'b0000000000000000000000000000000000000000000000000000000000000001));
  assign _11 = writeBack_INSTRUCTION;
  assign _12 = 1'b0;
  assign _13 = 1'b0;
  assign _14 = 1'b0;
  assign _15 = writeBack_RS1_USE;
  assign _16 = _11[19 : 15];
  assign _17 = (_15 ? _16 : _295);
  assign _18 = writeBack_RS2_USE;
  assign _19 = _11[24 : 20];
  assign _20 = (_18 ? _19 : _296);
  assign _21 = writeBack_REGFILE_WRITE_VALID;
  assign _22 = _11[11 : 7];
  assign _23 = (_21 ? _22 : _297);
  assign _25 = prefetch_FORMAL_HALT;
  assign _26 = 1'b1;
  assign _27 = 1'b1;
  assign _28 = 1'b0;
  assign _29 = fetch_FORMAL_HALT;
  assign _30 = 1'b1;
  assign _31 = 1'b1;
  assign _33 = 1'b1;
  assign _34 = 1'b1;
  assign _35 = execute_FORMAL_HALT;
  assign _36 = 1'b1;
  assign _37 = 1'b1;
  assign _39 = 1'b1;
  assign _40 = 1'b1;
  assign _41 = 1'b1;
  assign _42 = 1'b1;
  assign _43 = 1'b0;
  assign _49 = 1'b1;
  assign _50 = 1'b1;
  assign _51 = 1'b1;
  assign _52 = 1'b0;
  assign _53 = 1'b1;
  assign _54 = 1'b0;
  assign _55 = 1'b0;
  assign _56 = 1'b1;
  assign _57 = 1'b1;
  assign _58 = 1'b0;
  assign _59 = 1'b1;
  assign _60 = 1'b1;
  assign _61 = 1'b0;
  assign _62 = 1'b1;
  assign _63 = 1'b0;
  assign _64 = (2'b00);
  assign _65 = {prefetch_PcManagerSimplePlugin_inc,_64};
  assign prefetch_PcManagerSimplePlugin_pcBeforeJumps = (prefetch_PcManagerSimplePlugin_pcReg + _294);
  assign prefetch_PC_CALC_WITHOUT_JUMP = prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_valid = _7;
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_payload = _8;
  assign _66 = 1'b0;
  assign _67 = 1'b1;
  assign _68 = 1'b0;
  assign _69 = 1'b1;
  assign _70 = 1'b1;
  assign prefetch_PC = prefetch_PcManagerSimplePlugin_pc;
  assign _71 = (prefetch_PC + (32'b00000000000000000000000000000100));
  assign iBus_cmd_valid = _284;
  assign iBus_cmd_payload_pc = _76;
  assign _73 = 1'b0;
  assign _74 = 1'b0;
  assign _75 = 1'b1;
  assign _76 = prefetch_PC;
  assign _77 = 1'b1;
  assign _78 = 1'b0;
  assign _79 = 1'b0;
  assign _81 = 1'b1;
  assign _82 = 1'b0;
  assign _85 = 1'b1;
  assign _86 = 1'b0;
  assign _87 = fetch_INSTRUCTION;
  assign _88 = 1'b1;
  assign dBus_cmd_valid = _289;
  assign dBus_cmd_payload_wr = _290;
  assign dBus_cmd_payload_address = _285;
  assign dBus_cmd_payload_data = _291;
  assign dBus_cmd_payload_size = _288;
  assign _89 = 1'b0;
  assign execute_ALIGNEMENT_FAULT = _89;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign _90 = execute_SRC_ADD;
  assign _91 = execute_INSTRUCTION[13 : 12];
  assign _93 = 1'b1;
  assign _94 = 1'b0;
  assign _95 = _285[1 : 0];
  assign _96 = (4'b0001);
  assign _97 = (4'b0011);
  assign _98 = (4'b1111);
  assign _99 = (4'b0000);
  assign _100 = (4'b0000);
  assign _101 = 1'b1;
  assign _102 = 1'b1;
  assign writeBack_MEMORY_ADDRESS_LOW = _253;
  assign _103 = (2'b10);
  assign _104 = (2'b11);
  assign _105 = writeBack_INSTRUCTION[13 : 12];
  assign _106 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  assign _108 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  assign _110 = 1'b1;
  assign _111 = {({((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000)),_115} != (2'b00)),{({_115,((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000))} != (2'b00)),{({_117,{_115,_112}} != (3'b000)),{({_117,{_115,_118}} != (3'b000)),{({_117,_116} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001000000)) != (1'b0)),{({_119,((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000100000))} != (2'b00)),{({_117,{_119,{_115,{_118,((decode_INSTRUCTION & (32'b00000000000000000100000001000000)) == (32'b00000000000000000100000000000000))}}}} != (5'b00000)),{({_117,_116} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100)) != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000000000)),((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000001000000000000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000101000000010000)),((decode_INSTRUCTION & (32'b00000000000000000111000001100100)) == (32'b00000000000000000101000000100000))} != (2'b00)),{({((decode_INSTRUCTION & (32'b01000000000000000011000000010100)) == (32'b01000000000000000001000000010000)),{((decode_INSTRUCTION & (32'b01000000000000000100000001100100)) == (32'b01000000000000000100000000100000)),((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000001000000010000))}} != (3'b000)),{({_113,{((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000)),((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000))}} != (3'b000)),{({((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000)),((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100))} != (2'b00)),{(((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000)) != (1'b0)),{({((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000000)),{_114,((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000))}} != (3'b000)),{({_115,{((decode_INSTRUCTION & (32'b00000000000000000010000000100000)) == (32'b00000000000000000010000000100000)),{((decode_INSTRUCTION & (32'b00000000000000000010000000010000)) == (32'b00000000000000000010000000010000)),{((decode_INSTRUCTION & (32'b00000000000000000001000000100000)) == (32'b00000000000000000000000000100000)),((decode_INSTRUCTION & (32'b00000000000000000001000000010000)) == (32'b00000000000000000000000000010000))}}}} != (5'b00000)),{(_114 != (1'b0)),({_113,{((decode_INSTRUCTION & (32'b00000000000000000000000000100100)) == (32'b00000000000000000000000000100000)),_112}} != (3'b000))}}}}}}}}}}}}}}}}}}};
  assign _112 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _113 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign _114 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000000000));
  assign _115 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _116 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign _117 = ((decode_INSTRUCTION & (32'b00000000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign _118 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign _119 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign _120 = (32'b10111110000000000111000001111111);
  assign _121 = (32'b10111110000000000111000001111111);
  assign _122 = (32'b11111100000000000011000001111111);
  assign _123 = (32'b10111100000000000111000001111111);
  assign _124 = (32'b11111110000000000000000001111111);
  assign _125 = _111[0 : 0];
  assign _126 = _111[1 : 1];
  assign _127 = _111[2 : 2];
  assign _128 = _111[3 : 3];
  assign _129 = _111[6 : 6];
  assign _130 = _111[9 : 9];
  assign _131 = _111[12 : 12];
  assign _132 = _111[13 : 13];
  assign decode_INSTRUCTION_READY = _88;
  assign decode_LEGAL_INSTRUCTION = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011)),{((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000111000001111011)) == (32'b00000000000000000000000001100011)),{((decode_INSTRUCTION & _124) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & _123) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & _122) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & _121) == (32'b00000000000000000101000000110011)),((decode_INSTRUCTION & _120) == (32'b00000000000000000000000000110011))}}}}}}}}}}}}}}} != (16'b0000000000000000));
  assign _133 = 1'b0;
  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : _87);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = RegFilePlugin_regFile_port0_data;
  assign RegFilePlugin_regFile_port0_address = decode_RegFilePlugin_regFileReadAddress1;
  assign RegFilePlugin_regFile_port0_enable = _134;
  assign _134 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = RegFilePlugin_regFile_port1_data;
  assign RegFilePlugin_regFile_port1_address = decode_RegFilePlugin_regFileReadAddress2;
  assign RegFilePlugin_regFile_port1_enable = _135;
  assign _135 = 1'b1;
  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _136;
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _24;
  assign RegFilePlugin_regFile_port2_address = writeBack_RegFilePlugin_regFileWrite_payload_address;
  assign RegFilePlugin_regFile_port2_data = writeBack_RegFilePlugin_regFileWrite_payload_data;
  assign RegFilePlugin_regFile_port2_enable = writeBack_RegFilePlugin_regFileWrite_valid;
  assign _136 = _11[11 : 7];
  assign _137 = 1'b0;
  assign _139 = 1'b1;
  assign _140 = 1'b1;
  assign _141 = `AluBitwiseCtrlEnum_binary_sequancial_AND_1;
  assign _142 = `AluBitwiseCtrlEnum_binary_sequancial_OR_1;
  assign _143 = `AluBitwiseCtrlEnum_binary_sequancial_XOR_1;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign _144 = execute_SRC_LESS;
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign _146 = `AluCtrlEnum_binary_sequancial_BITWISE;
  assign _147 = `AluCtrlEnum_binary_sequancial_SLT_SLTU;
  assign decode_SRC1_CTRL = _111[11 : 10];
  assign _148 = decode_RS1;
  assign _149 = (12'b000000000000);
  assign _151 = `Src1CtrlEnum_binary_sequancial_RS;
  assign _152 = `Src1CtrlEnum_binary_sequancial_FOUR;
  assign decode_SRC2_CTRL = _111[17 : 16];
  assign _153 = decode_RS2;
  assign _154 = decode_INSTRUCTION[31 : 20];
  assign _155 = _154[11];
  assign _157 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _158 = _157[11];
  assign _160 = decode_PC;
  assign _162 = `Src2CtrlEnum_binary_sequancial_RS;
  assign _163 = `Src2CtrlEnum_binary_sequancial_IMI;
  assign _164 = `Src2CtrlEnum_binary_sequancial_IMS;
  assign _165 = execute_SRC1;
  assign _166 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _167 = ($signed(_165) + $signed(_166));
  assign _168 = (2'b01);
  assign _169 = (execute_SRC_USE_SUB_LESS ? _168 : _293);
  assign _170 = ($signed(_167) + $signed(_292));
  assign execute_SrcPlugin_addSub = _170;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_FullBarrielShifterPlugin_amplitude = execute_SRC2[4 : 0];
  assign _171 = `ShiftCtrlEnum_binary_sequancial_SLL_1;
  assign execute_FullBarrielShifterPlugin_reversed = ((execute_SHIFT_CTRL == _171) ? _172 : execute_SRC1);
  assign _173 = `ShiftCtrlEnum_binary_sequancial_SRA_1;
  assign _174 = {((execute_SHIFT_CTRL == _173) && execute_FullBarrielShifterPlugin_reversed[31]),execute_FullBarrielShifterPlugin_reversed};
  assign _175 = ($signed(_174) >>> execute_FullBarrielShifterPlugin_amplitude);
  assign _176 = _175[31 : 0];
  assign _177 = `ShiftCtrlEnum_binary_sequancial_SLL_1;
  assign _180 = `ShiftCtrlEnum_binary_sequancial_SRL_1;
  assign _181 = `ShiftCtrlEnum_binary_sequancial_SRA_1;
  assign _186 = 1'b0;
  assign _187 = 1'b1;
  assign _188 = 1'b0;
  assign _189 = 1'b1;
  assign _190 = 1'b0;
  assign _191 = 1'b1;
  assign _192 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign _193 = 1'b1;
  assign _194 = (_193 || (! _191));
  assign _195 = 1'b1;
  assign _196 = 1'b1;
  assign _197 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign _198 = 1'b1;
  assign _199 = (_198 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign _200 = 1'b1;
  assign _201 = 1'b1;
  assign _202 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign _203 = 1'b1;
  assign _204 = (_203 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign _205 = 1'b1;
  assign _206 = 1'b1;
  assign decode_RS1_USE = _128[0];
  assign _207 = 1'b0;
  assign decode_RS2_USE = _125[0];
  assign _208 = 1'b0;
  assign _209 = 1'b1;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _210 = 1'b0;
  assign _211 = 1'b1;
  assign _212 = 1'b1;
  assign _213 = execute_INSTRUCTION[14 : 12];
  assign _214 = (3'b000);
  assign _215 = (3'b001);
  assign _217 = (3'b101);
  assign _218 = (3'b101);
  assign _220 = `BranchCtrlEnum_binary_sequancial_INC;
  assign _221 = `BranchCtrlEnum_binary_sequancial_JAL;
  assign _222 = `BranchCtrlEnum_binary_sequancial_JALR;
  assign _223 = `BranchCtrlEnum_binary_sequancial_JALR;
  assign _224 = execute_RS1;
  assign execute_PC = _249;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == _223) ? _224 : execute_PC);
  assign _225 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _226 = _225[19];
  assign _228 = 1'b0;
  assign _229 = execute_INSTRUCTION[31 : 20];
  assign _230 = _229[11];
  assign _232 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _233 = _232[11];
  assign _235 = 1'b0;
  assign _237 = `BranchCtrlEnum_binary_sequancial_JAL;
  assign _238 = `BranchCtrlEnum_binary_sequancial_JALR;
  assign execute_BranchPlugin_branch_src2 = _236;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _239 = execute_BranchPlugin_branchAdder[31 : 1];
  assign _240 = `BranchCtrlEnum_binary_sequancial_JALR;
  assign _241 = 1'b0;
  assign _242 = {_239,((execute_BRANCH_CTRL == _240) ? _241 : execute_BranchPlugin_branchAdder[0])};
  assign memory_BRANCH_CALC = _246;
  assign _243 = 1'b1;
  assign _244 = 1'b0;
  assign _245 = _8[1 : 0];
  assign execute_REGFILE_WRITE_DATA = _145;
  assign decode_RS1 = decode_RegFilePlugin_rs1Data;
  assign decode_RS2 = decode_RegFilePlugin_rs2Data;
  assign execute_FORMAL_MEM_WDATA = _291;
  assign execute_BRANCH_CALC = _242;
  assign fetch_PC = _247;
  assign memory_PC = _250;
  assign execute_BRANCH_DO = _219;
  assign execute_MEMORY_ADDRESS_LOW = _95;
  assign memory_MEMORY_ADDRESS_LOW = _252;
  assign decode_SRC2 = _161;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _127[0];
  assign execute_FORMAL_MEM_RMASK = ((_289 && (! _290)) ? execute_DBusSimplePlugin_formalMask : _100);
  assign execute_FORMAL_MEM_ADDR = _285;
  assign memory_FORMAL_MEM_ADDR = _254;
  assign writeBack_FORMAL_MEM_ADDR = _255;
  assign prefetch_FORMAL_HALT = _55;
  assign decode_BRANCH_CTRL = _111[15 : 14];
  assign decode_SRC_LESS_UNSIGNED = _130[0];
  assign decode_ALU_BITWISE_CTRL = _111[19 : 18];
  assign execute_FORMAL_MEM_WMASK = ((_289 && _290) ? execute_DBusSimplePlugin_formalMask : _99);
  assign writeBack_FORMAL_MEM_RDATA = writeBack_DBusSimplePlugin_rspFormated;
  assign fetch_INSTRUCTION = _84;
  assign prefetch_FORMAL_PC_NEXT = _71;
  assign fetch_FORMAL_PC_NEXT = _256;
  assign decode_FORMAL_PC_NEXT = _257;
  assign execute_FORMAL_PC_NEXT = _258;
  assign memory_FORMAL_PC_NEXT = _259;
  assign writeBack_FORMAL_PC_NEXT = _260;
  assign decode_ALU_CTRL = _111[5 : 4];
  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign execute_SHIFT_RIGHT = _176;
  assign decode_BYPASSABLE_MEMORY_STAGE = _132[0];
  assign decode_MEMORY_ENABLE = _126[0];
  assign decode_SRC1 = _150;
  assign decode_SHIFT_CTRL = _111[8 : 7];
  assign decode_SRC_USE_SUB_LESS = _129[0];
  assign _261 = 1'b0;
  assign _262 = 1'b1;
  assign _263 = 1'b1;
  assign _264 = 1'b0;
  assign _265 = 1'b1;
  assign _266 = 1'b0;
  assign _267 = 1'b1;
  assign _268 = 1'b0;
  assign _269 = 1'b1;
  assign _270 = 1'b0;
  assign _271 = 1'b1;
  assign _272 = 1'b0;
  assign _273 = 1'b0;
  assign _274 = 1'b0;
  assign _275 = 1'b0;
  assign _276 = 1'b0;
  assign _277 = 1'b0;
  assign _278 = 1'b0;
  assign _279 = 1'b0;
  assign _280 = 1'b0;
  assign _281 = 1'b0;
  assign _282 = 1'b0;
  assign _283 = 1'b0;
  assign _284 = (((prefetch_arbitration_isValid && (! prefetch_arbitration_removeIt)) && (! prefetch_arbitration_isStuckByOthers)) && (! (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))));
  assign _285 = _90;
  assign _288 = _91;
  assign _289 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign _290 = execute_INSTRUCTION[5];
  assign _291 = _92;
  assign _292 = $signed(_169);
  assign _293 = (2'b00);
  assign _294 = _65;
  assign _295 = (5'b00000);
  assign _296 = (5'b00000);
  assign _297 = (5'b00000);
  always @ (iBus_cmd_ready or iBus_rsp_ready or prefetch_IBusSimplePlugin_pendingCmd or _77 or _78)
  begin
    prefetch_arbitration_haltItself = _78;
    if(((! iBus_cmd_ready) || (prefetch_IBusSimplePlugin_pendingCmd && (! iBus_rsp_ready))))begin
      prefetch_arbitration_haltItself = _77;
    end
  end

  always @ (fetch_arbitration_isValid or iBus_rsp_ready or _80 or _85 or _86)
  begin
    fetch_arbitration_haltItself = _86;
    if(((fetch_arbitration_isValid && (! iBus_rsp_ready)) && (! _80)))begin
      fetch_arbitration_haltItself = _85;
    end
  end

  always @ (fetch_arbitration_isFlushed or _263 or _264)
  begin
    fetch_arbitration_removeIt = _264;
    if(fetch_arbitration_isFlushed)begin
      fetch_arbitration_removeIt = _263;
    end
  end

  always @ (decode_arbitration_isValid or decodeExceptionPort_valid or _57 or _58 or _182 or _183 or _209)
  begin
    decode_arbitration_haltItself = _58;
    if(decodeExceptionPort_valid)begin
      decode_arbitration_haltItself = _57;
    end
    if((decode_arbitration_isValid && (_182 || _183)))begin
      decode_arbitration_haltItself = _209;
    end
  end

  always @ (decode_arbitration_isFlushed or _265 or _266)
  begin
    decode_arbitration_removeIt = _266;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = _265;
    end
  end

  always @ (execute_arbitration_isValid or dBus_cmd_ready or execute_MEMORY_ENABLE or execute_ALIGNEMENT_FAULT or _93 or _94)
  begin
    execute_arbitration_haltItself = _94;
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = _93;
    end
  end

  always @ (execute_arbitration_isFlushed or _267 or _268)
  begin
    execute_arbitration_removeIt = _268;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = _267;
    end
  end

  always @ (_7 or _243 or _244)
  begin
    execute_arbitration_flushAll = _244;
    if(_7)begin
      execute_arbitration_flushAll = _243;
    end
  end

  always @ (memory_arbitration_isValid or _9 or _60 or _61 or dBus_rsp_ready or memory_MEMORY_ENABLE or memory_INSTRUCTION or _101)
  begin
    memory_arbitration_haltItself = _61;
    if(_9)begin
      memory_arbitration_haltItself = _60;
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = _101;
    end
  end

  always @ (memory_arbitration_isFlushed or _269 or _270)
  begin
    memory_arbitration_removeIt = _270;
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = _269;
    end
  end

  always @ (writeBack_arbitration_isFlushed or _271 or _272)
  begin
    writeBack_arbitration_removeIt = _272;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = _271;
    end
  end

  always @ (_12 or _48 or _50)
  begin
    rvfi_trap = _12;
    if(_48)begin
      rvfi_trap = _50;
    end
  end

  always @ (writeBack_arbitration_isValid or writeBack_DBusSimplePlugin_rspFormated or writeBack_MEMORY_ENABLE or writeBack_REGFILE_WRITE_DATA)
  begin
    _24 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _24 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  always @ (prefetch_arbitration_isValid or fetch_arbitration_isValid or decode_arbitration_isValid or execute_arbitration_isValid or memory_arbitration_isValid or writeBack_arbitration_isValid or _25 or _26 or _27 or _28 or _29 or _30 or _31 or _32 or _33 or _34 or _35 or _36 or _37 or _38 or _39 or _40 or _41 or _42 or writeBack_FORMAL_HALT)
  begin
    writeBack_FomalPlugin_haltRequest = _28;
    if((prefetch_arbitration_isValid && _25))begin
      if((((((_26 && (! fetch_arbitration_isValid)) && (! decode_arbitration_isValid)) && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = _27;
      end
    end
    if((fetch_arbitration_isValid && _29))begin
      if(((((_30 && (! decode_arbitration_isValid)) && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = _31;
      end
    end
    if((decode_arbitration_isValid && _32))begin
      if((((_33 && (! execute_arbitration_isValid)) && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = _34;
      end
    end
    if((execute_arbitration_isValid && _35))begin
      if(((_36 && (! memory_arbitration_isValid)) && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = _37;
      end
    end
    if((memory_arbitration_isValid && _38))begin
      if((_39 && (! writeBack_arbitration_isValid)))begin
        writeBack_FomalPlugin_haltRequest = _40;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_FORMAL_HALT))begin
      if(_41)begin
        writeBack_FomalPlugin_haltRequest = _42;
      end
    end
  end

  always @ (decodeExceptionPort_valid or _56 or decode_FORMAL_HALT)
  begin
    _32 = decode_FORMAL_HALT;
    if(decodeExceptionPort_valid)begin
      _32 = _56;
    end
  end

  always @ (_9 or _59 or memory_FORMAL_HALT)
  begin
    _38 = memory_FORMAL_HALT;
    if(_9)begin
      _38 = _59;
    end
  end

  always @ (prefetch_PC_CALC_WITHOUT_JUMP or prefetch_PcManagerSimplePlugin_jump_pcLoad_valid or prefetch_PcManagerSimplePlugin_jump_pcLoad_payload)
  begin
    prefetch_PcManagerSimplePlugin_pc = prefetch_PC_CALC_WITHOUT_JUMP;
    if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
      prefetch_PcManagerSimplePlugin_pc = prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
    end
  end

  always @ (prefetch_arbitration_isFiring or prefetch_PcManagerSimplePlugin_jump_pcLoad_valid or _67 or _68 or _70)
  begin
    prefetch_PcManagerSimplePlugin_samplePcNext = _68;
    if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = _67;
    end
    if(prefetch_arbitration_isFiring)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = _70;
    end
  end

  always @ (_7 or _8 or memory_FORMAL_PC_NEXT)
  begin
    _72 = memory_FORMAL_PC_NEXT;
    if(_7)begin
      _72 = _8;
    end
  end

  always @ (iBus_rsp_inst or _80 or _83)
  begin
    _84 = iBus_rsp_inst;
    if(_80)begin
      _84 = _83;
    end
  end

  always @ (execute_RS2 or _288)
  begin
    case(_288)
      (2'b00) : begin
        _92 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      (2'b01) : begin
        _92 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _92 = execute_RS2[31 : 0];
      end
    endcase
  end

  always @ (_96 or _97 or _98 or _288)
  begin
    case(_288)
      (2'b00) : begin
        execute_DBusSimplePlugin_formalMask = _96;
      end
      (2'b01) : begin
        execute_DBusSimplePlugin_formalMask = _97;
      end
      default : begin
        execute_DBusSimplePlugin_formalMask = _98;
      end
    endcase
  end

  always @ (writeBack_MEMORY_READ_DATA or writeBack_MEMORY_ADDRESS_LOW)
  begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      (2'b01) : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      (2'b10) : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      (2'b11) : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  always @ (writeBack_DBusSimplePlugin_rspShifted or _106)
  begin
    _107[31] = _106;
    _107[30] = _106;
    _107[29] = _106;
    _107[28] = _106;
    _107[27] = _106;
    _107[26] = _106;
    _107[25] = _106;
    _107[24] = _106;
    _107[23] = _106;
    _107[22] = _106;
    _107[21] = _106;
    _107[20] = _106;
    _107[19] = _106;
    _107[18] = _106;
    _107[17] = _106;
    _107[16] = _106;
    _107[15] = _106;
    _107[14] = _106;
    _107[13] = _106;
    _107[12] = _106;
    _107[11] = _106;
    _107[10] = _106;
    _107[9] = _106;
    _107[8] = _106;
    _107[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  always @ (writeBack_DBusSimplePlugin_rspShifted or _108)
  begin
    _109[31] = _108;
    _109[30] = _108;
    _109[29] = _108;
    _109[28] = _108;
    _109[27] = _108;
    _109[26] = _108;
    _109[25] = _108;
    _109[24] = _108;
    _109[23] = _108;
    _109[22] = _108;
    _109[21] = _108;
    _109[20] = _108;
    _109[19] = _108;
    _109[18] = _108;
    _109[17] = _108;
    _109[16] = _108;
    _109[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (writeBack_DBusSimplePlugin_rspShifted or _105 or _107 or _109)
  begin
    case(_105)
      (2'b00) : begin
        writeBack_DBusSimplePlugin_rspFormated = _107;
      end
      (2'b01) : begin
        writeBack_DBusSimplePlugin_rspFormated = _109;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  always @ (decode_INSTRUCTION or _131 or _133)
  begin
    decode_REGFILE_WRITE_VALID = _131[0];
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = _133;
    end
  end

  always @ (writeBack_arbitration_isFiring or _21 or _138 or _140)
  begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_21 && writeBack_arbitration_isFiring);
    if(_138)begin
      writeBack_RegFilePlugin_regFileWrite_valid = _140;
    end
  end

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

  always @ (execute_IntAluPlugin_bitwise or execute_ALU_CTRL or _144 or execute_SRC_ADD_SUB)
  begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequancial_BITWISE : begin
        _145 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _145 = _144;
      end
      default : begin
        _145 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @ (decode_INSTRUCTION or decode_SRC1_CTRL or _148 or _149)
  begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _150 = _148;
      end
      `Src1CtrlEnum_binary_sequancial_FOUR : begin
        _150 = (32'b00000000000000000000000000000100);
      end
      default : begin
        _150 = {decode_INSTRUCTION[31 : 12],_149};
      end
    endcase
  end

  always @ (_155)
  begin
    _156[19] = _155;
    _156[18] = _155;
    _156[17] = _155;
    _156[16] = _155;
    _156[15] = _155;
    _156[14] = _155;
    _156[13] = _155;
    _156[12] = _155;
    _156[11] = _155;
    _156[10] = _155;
    _156[9] = _155;
    _156[8] = _155;
    _156[7] = _155;
    _156[6] = _155;
    _156[5] = _155;
    _156[4] = _155;
    _156[3] = _155;
    _156[2] = _155;
    _156[1] = _155;
    _156[0] = _155;
  end

  always @ (_158)
  begin
    _159[19] = _158;
    _159[18] = _158;
    _159[17] = _158;
    _159[16] = _158;
    _159[15] = _158;
    _159[14] = _158;
    _159[13] = _158;
    _159[12] = _158;
    _159[11] = _158;
    _159[10] = _158;
    _159[9] = _158;
    _159[8] = _158;
    _159[7] = _158;
    _159[6] = _158;
    _159[5] = _158;
    _159[4] = _158;
    _159[3] = _158;
    _159[2] = _158;
    _159[1] = _158;
    _159[0] = _158;
  end

  always @ (decode_INSTRUCTION or decode_SRC2_CTRL or _153 or _156 or _159 or _160)
  begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _161 = _153;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _161 = {_156,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _161 = {_159,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _161 = _160;
      end
    endcase
  end

  always @ (execute_SRC1)
  begin
    _172[0] = execute_SRC1[31];
    _172[1] = execute_SRC1[30];
    _172[2] = execute_SRC1[29];
    _172[3] = execute_SRC1[28];
    _172[4] = execute_SRC1[27];
    _172[5] = execute_SRC1[26];
    _172[6] = execute_SRC1[25];
    _172[7] = execute_SRC1[24];
    _172[8] = execute_SRC1[23];
    _172[9] = execute_SRC1[22];
    _172[10] = execute_SRC1[21];
    _172[11] = execute_SRC1[20];
    _172[12] = execute_SRC1[19];
    _172[13] = execute_SRC1[18];
    _172[14] = execute_SRC1[17];
    _172[15] = execute_SRC1[16];
    _172[16] = execute_SRC1[15];
    _172[17] = execute_SRC1[14];
    _172[18] = execute_SRC1[13];
    _172[19] = execute_SRC1[12];
    _172[20] = execute_SRC1[11];
    _172[21] = execute_SRC1[10];
    _172[22] = execute_SRC1[9];
    _172[23] = execute_SRC1[8];
    _172[24] = execute_SRC1[7];
    _172[25] = execute_SRC1[6];
    _172[26] = execute_SRC1[5];
    _172[27] = execute_SRC1[4];
    _172[28] = execute_SRC1[3];
    _172[29] = execute_SRC1[2];
    _172[30] = execute_SRC1[1];
    _172[31] = execute_SRC1[0];
  end

  always @ (memory_SHIFT_CTRL or _177 or memory_SHIFT_RIGHT or _179 or _180 or _181 or memory_REGFILE_WRITE_DATA)
  begin
    _178 = memory_REGFILE_WRITE_DATA;
    if((memory_SHIFT_CTRL == _177))begin
      _178 = _179;
    end else if(((memory_SHIFT_CTRL == _180) || (memory_SHIFT_CTRL == _181)))begin
      _178 = memory_SHIFT_RIGHT;
    end
  end

  always @ (memory_SHIFT_RIGHT)
  begin
    _179[0] = memory_SHIFT_RIGHT[31];
    _179[1] = memory_SHIFT_RIGHT[30];
    _179[2] = memory_SHIFT_RIGHT[29];
    _179[3] = memory_SHIFT_RIGHT[28];
    _179[4] = memory_SHIFT_RIGHT[27];
    _179[5] = memory_SHIFT_RIGHT[26];
    _179[6] = memory_SHIFT_RIGHT[25];
    _179[7] = memory_SHIFT_RIGHT[24];
    _179[8] = memory_SHIFT_RIGHT[23];
    _179[9] = memory_SHIFT_RIGHT[22];
    _179[10] = memory_SHIFT_RIGHT[21];
    _179[11] = memory_SHIFT_RIGHT[20];
    _179[12] = memory_SHIFT_RIGHT[19];
    _179[13] = memory_SHIFT_RIGHT[18];
    _179[14] = memory_SHIFT_RIGHT[17];
    _179[15] = memory_SHIFT_RIGHT[16];
    _179[16] = memory_SHIFT_RIGHT[15];
    _179[17] = memory_SHIFT_RIGHT[14];
    _179[18] = memory_SHIFT_RIGHT[13];
    _179[19] = memory_SHIFT_RIGHT[12];
    _179[20] = memory_SHIFT_RIGHT[11];
    _179[21] = memory_SHIFT_RIGHT[10];
    _179[22] = memory_SHIFT_RIGHT[9];
    _179[23] = memory_SHIFT_RIGHT[8];
    _179[24] = memory_SHIFT_RIGHT[7];
    _179[25] = memory_SHIFT_RIGHT[6];
    _179[26] = memory_SHIFT_RIGHT[5];
    _179[27] = memory_SHIFT_RIGHT[4];
    _179[28] = memory_SHIFT_RIGHT[3];
    _179[29] = memory_SHIFT_RIGHT[2];
    _179[30] = memory_SHIFT_RIGHT[1];
    _179[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (decode_INSTRUCTION or writeBack_INSTRUCTION or execute_INSTRUCTION or memory_INSTRUCTION or _184 or _185 or _187 or _188 or _192 or _194 or _195 or _197 or _199 or _200 or _202 or _204 or _205 or decode_RS1_USE or _207)
  begin
    _182 = _188;
    if(_184)begin
      if((_185 == decode_INSTRUCTION[19 : 15]))begin
        _182 = _187;
      end
    end
    if(_192)begin
      if(_194)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _182 = _195;
        end
      end
    end
    if(_197)begin
      if(_199)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _182 = _200;
        end
      end
    end
    if(_202)begin
      if(_204)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _182 = _205;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _182 = _207;
    end
  end

  always @ (decode_INSTRUCTION or writeBack_INSTRUCTION or execute_INSTRUCTION or memory_INSTRUCTION or _184 or _185 or _189 or _190 or _192 or _194 or _196 or _197 or _199 or _201 or _202 or _204 or _206 or decode_RS2_USE or _208)
  begin
    _183 = _190;
    if(_184)begin
      if((_185 == decode_INSTRUCTION[24 : 20]))begin
        _183 = _189;
      end
    end
    if(_192)begin
      if(_194)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _183 = _196;
        end
      end
    end
    if(_197)begin
      if(_199)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _183 = _201;
        end
      end
    end
    if(_202)begin
      if(_204)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _183 = _206;
        end
      end
    end
    if((! decode_RS2_USE))begin
      _183 = _208;
    end
  end

  always @ (execute_SRC_LESS or execute_BranchPlugin_eq or _213 or _214 or _215 or _217 or _218)
  begin
    if((_213 == _214))begin
      _216 = execute_BranchPlugin_eq;
    end else if((_213 == _215))begin
      _216 = (! execute_BranchPlugin_eq);
    end else if(((_213 & _217) == _218))begin
      _216 = (! execute_SRC_LESS);
    end else begin
      _216 = execute_SRC_LESS;
    end
  end

  always @ (execute_BRANCH_CTRL or _210 or _211 or _212 or _216)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _219 = _210;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _219 = _211;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _219 = _212;
      end
      default : begin
        _219 = _216;
      end
    endcase
  end

  always @ (_226)
  begin
    _227[10] = _226;
    _227[9] = _226;
    _227[8] = _226;
    _227[7] = _226;
    _227[6] = _226;
    _227[5] = _226;
    _227[4] = _226;
    _227[3] = _226;
    _227[2] = _226;
    _227[1] = _226;
    _227[0] = _226;
  end

  always @ (_230)
  begin
    _231[19] = _230;
    _231[18] = _230;
    _231[17] = _230;
    _231[16] = _230;
    _231[15] = _230;
    _231[14] = _230;
    _231[13] = _230;
    _231[12] = _230;
    _231[11] = _230;
    _231[10] = _230;
    _231[9] = _230;
    _231[8] = _230;
    _231[7] = _230;
    _231[6] = _230;
    _231[5] = _230;
    _231[4] = _230;
    _231[3] = _230;
    _231[2] = _230;
    _231[1] = _230;
    _231[0] = _230;
  end

  always @ (_233)
  begin
    _234[18] = _233;
    _234[17] = _233;
    _234[16] = _233;
    _234[15] = _233;
    _234[14] = _233;
    _234[13] = _233;
    _234[12] = _233;
    _234[11] = _233;
    _234[10] = _233;
    _234[9] = _233;
    _234[8] = _233;
    _234[7] = _233;
    _234[6] = _233;
    _234[5] = _233;
    _234[4] = _233;
    _234[3] = _233;
    _234[2] = _233;
    _234[1] = _233;
    _234[0] = _233;
  end

  always @ (execute_INSTRUCTION or execute_BRANCH_CTRL or _227 or _228 or _231 or _234 or _235)
  begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _236 = {{_227,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},_228};
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _236 = {_231,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _236 = {{_234,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},_235};
      end
    endcase
  end

  always @ (writeBack_arbitration_isFiring or _48 or _49 or writeBack_FomalPlugin_haltFired or _54)
  begin
    _286 = writeBack_arbitration_isFiring;
    if(_48)begin
      _286 = _49;
    end
    if(writeBack_FomalPlugin_haltFired)begin
      _286 = _54;
    end
  end

  always @ (_13 or _48 or _51)
  begin
    _287 = _13;
    if(_48)begin
      _287 = _51;
    end
  end

  always @ (posedge clk)
  begin
    if(reset) begin
      prefetch_arbitration_isValid <= _1;
      fetch_arbitration_isValid <= _2;
      decode_arbitration_isValid <= _3;
      execute_arbitration_isValid <= _4;
      memory_arbitration_isValid <= _5;
      writeBack_arbitration_isValid <= _6;
      writeBack_FomalPlugin_order <= (64'b0000000000000000000000000000000000000000000000000000000000000000);
      _44 <= _43;
      _45 <= _43;
      _46 <= _43;
      _47 <= _43;
      _48 <= _43;
      writeBack_FomalPlugin_haltFired <= _52;
      prefetch_PcManagerSimplePlugin_pcReg <= (32'b00000000000000000000000000000000);
      prefetch_PcManagerSimplePlugin_inc <= _63;
      prefetch_IBusSimplePlugin_pendingCmd <= _73;
      _80 <= _79;
      _138 <= _139;
      _184 <= _186;
      writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
    end else begin
      prefetch_arbitration_isValid <= _62;
      if(((! fetch_arbitration_isStuck) || fetch_arbitration_removeIt))begin
        fetch_arbitration_isValid <= _279;
      end
      if(((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt)))begin
        fetch_arbitration_isValid <= prefetch_arbitration_isValid;
      end
      if(((! decode_arbitration_isStuck) || decode_arbitration_removeIt))begin
        decode_arbitration_isValid <= _280;
      end
      if(((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt)))begin
        decode_arbitration_isValid <= fetch_arbitration_isValid;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= _281;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= _282;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= _283;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      if(writeBack_arbitration_isFiring)begin
        writeBack_FomalPlugin_order <= _10;
      end
      _44 <= writeBack_FomalPlugin_haltRequest;
      _45 <= _44;
      _46 <= _45;
      _47 <= _46;
      _48 <= _47;
      if((_286 && _287))begin
        writeBack_FomalPlugin_haltFired <= _53;
      end
      if(prefetch_PcManagerSimplePlugin_samplePcNext)begin
        prefetch_PcManagerSimplePlugin_pcReg <= prefetch_PcManagerSimplePlugin_pc;
      end
      if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
        prefetch_PcManagerSimplePlugin_inc <= _66;
      end
      if(prefetch_arbitration_isFiring)begin
        prefetch_PcManagerSimplePlugin_inc <= _69;
      end
      if(iBus_rsp_ready)begin
        prefetch_IBusSimplePlugin_pendingCmd <= _74;
      end
      if((_284 && iBus_cmd_ready))begin
        prefetch_IBusSimplePlugin_pendingCmd <= _75;
      end
      if(iBus_rsp_ready)begin
        _80 <= _81;
      end
      if((! fetch_arbitration_isStuck))begin
        _80 <= _82;
      end
      _138 <= _137;
      _184 <= (_21 && writeBack_arbitration_isFiring);
      if((! writeBack_arbitration_isStuck))begin
        writeBack_REGFILE_WRITE_DATA <= _178;
      end
      if((! writeBack_arbitration_isStuck))begin
        writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
    end
  end

  always @ (posedge clk)
  begin
    if (!((! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck)) || (! _102))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!((! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck)) || (! _110))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    RegFilePlugin_regFile_port0_data <= RegFilePlugin_regFile[RegFilePlugin_regFile_port0_address];
    RegFilePlugin_regFile_port1_data <= RegFilePlugin_regFile[RegFilePlugin_regFile_port1_address];
    if(RegFilePlugin_regFile_port2_enable)begin
      RegFilePlugin_regFile[RegFilePlugin_regFile_port2_address] <= RegFilePlugin_regFile_port2_data;
    end
    if (!((prefetch_arbitration_removeIt == _261) || (! _262))) begin
      $display("ERROR removeIt should never be asserted on this stage");
    end
    if((! _80))begin
      _83 <= iBus_rsp_inst;
    end
    _185 <= _11[11 : 7];
    if((! memory_arbitration_isStuck))begin
      memory_REGFILE_WRITE_DATA <= execute_REGFILE_WRITE_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      execute_RS2_USE <= decode_RS2_USE;
    end
    if((! memory_arbitration_isStuck))begin
      memory_RS2_USE <= execute_RS2_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_RS2_USE <= memory_RS2_USE;
    end
    if((! execute_arbitration_isStuck))begin
      execute_RS1 <= _148;
    end
    if((! memory_arbitration_isStuck))begin
      memory_RS1 <= execute_RS1;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_RS1 <= memory_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_RS2 <= _153;
    end
    if((! memory_arbitration_isStuck))begin
      memory_RS2 <= execute_RS2;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_RS2 <= memory_RS2;
    end
    if((! memory_arbitration_isStuck))begin
      memory_FORMAL_MEM_WDATA <= execute_FORMAL_MEM_WDATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_FORMAL_MEM_WDATA <= memory_FORMAL_MEM_WDATA;
    end
    if((! memory_arbitration_isStuck))begin
      _246 <= execute_BRANCH_CALC;
    end
    if((! fetch_arbitration_isStuck))begin
      _247 <= _76;
    end
    if((! decode_arbitration_isStuck))begin
      _248 <= fetch_PC;
    end
    if((! execute_arbitration_isStuck))begin
      _249 <= _160;
    end
    if((! memory_arbitration_isStuck))begin
      _250 <= execute_PC;
    end
    if((! writeBack_arbitration_isStuck))begin
      _251 <= memory_PC;
    end
    if((! memory_arbitration_isStuck))begin
      memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      _252 <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      _253 <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      execute_SRC2 <= decode_SRC2;
    end
    if((! execute_arbitration_isStuck))begin
      execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      execute_RS1_USE <= decode_RS1_USE;
    end
    if((! memory_arbitration_isStuck))begin
      memory_RS1_USE <= execute_RS1_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_RS1_USE <= memory_RS1_USE;
    end
    if((! memory_arbitration_isStuck))begin
      memory_FORMAL_MEM_RMASK <= execute_FORMAL_MEM_RMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_FORMAL_MEM_RMASK <= memory_FORMAL_MEM_RMASK;
    end
    if((! memory_arbitration_isStuck))begin
      _254 <= execute_FORMAL_MEM_ADDR;
    end
    if((! writeBack_arbitration_isStuck))begin
      _255 <= memory_FORMAL_MEM_ADDR;
    end
    if((! fetch_arbitration_isStuck))begin
      fetch_FORMAL_HALT <= _25;
    end
    if((! decode_arbitration_isStuck))begin
      decode_FORMAL_HALT <= _29;
    end
    if((! execute_arbitration_isStuck))begin
      execute_FORMAL_HALT <= _32;
    end
    if((! memory_arbitration_isStuck))begin
      memory_FORMAL_HALT <= _35;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_FORMAL_HALT <= _38;
    end
    if((! execute_arbitration_isStuck))begin
      execute_BRANCH_CTRL <= decode_BRANCH_CTRL;
    end
    if((! execute_arbitration_isStuck))begin
      execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      execute_ALU_BITWISE_CTRL <= decode_ALU_BITWISE_CTRL;
    end
    if((! memory_arbitration_isStuck))begin
      memory_FORMAL_MEM_WMASK <= execute_FORMAL_MEM_WMASK;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_FORMAL_MEM_WMASK <= memory_FORMAL_MEM_WMASK;
    end
    if((! decode_arbitration_isStuck))begin
      decode_INSTRUCTION <= _87;
    end
    if((! execute_arbitration_isStuck))begin
      execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! fetch_arbitration_isStuck))begin
      _256 <= prefetch_FORMAL_PC_NEXT;
    end
    if((! decode_arbitration_isStuck))begin
      _257 <= fetch_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      _258 <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      _259 <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      _260 <= _72;
    end
    if((! execute_arbitration_isStuck))begin
      execute_ALU_CTRL <= decode_ALU_CTRL;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! memory_arbitration_isStuck))begin
      memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      execute_SRC1 <= decode_SRC1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_SHIFT_CTRL <= decode_SHIFT_CTRL;
    end
    if((! memory_arbitration_isStuck))begin
      memory_SHIFT_CTRL <= execute_SHIFT_CTRL;
    end
    if((! execute_arbitration_isStuck))begin
      execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
  end

endmodule

