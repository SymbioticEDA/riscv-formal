#!/bin/sh

set -ex

export CONFIG=DefaultConfigWithRVFIMonitors
export MAKEFLAGS="-j$(nproc)"
export RISCV=$PWD/riscv-tools

enable_compressed=true
enable_64bits=true

if [ ! -d rocket-chip ]; then
	git clone https://github.com/freechipsproject/rocket-chip
	cd rocket-chip

	git checkout RVFI
	git submodule update --init

	if $enable_compressed; then
		( cd ../../../monitor && python3 generate.py -i rv32ic -p RVFIMonitor -c 2; ) > vsrc/RVFIMonitor.v
	else
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /new WithRVFIMonitors/ s/$/\n  new WithoutCompressed ++/; };' src/main/scala/system/Configs.scala
		( cd ../../../monitor && python3 generate.py -i rv32i -p RVFIMonitor -c 2; ) > vsrc/RVFIMonitor.v
	fi

	if ! $enable_64bits; then
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /freechips.rocketchip.tile.XLen/ s,^,//,; }' src/main/scala/system/Configs.scala
	fi

	sed -i '/^module/ s/\([A-Z]\+=\)/parameter &/g' vsrc/plusarg_reader.v
	sed -i 's/--top-module/-Wno-fatal &/' emulator/Makefrag-verilator

	cd ..
fi

if [ ! -d riscv-tools ]; then
	mkdir riscv-tools
	cd rocket-chip/riscv-tools
	git submodule update --init --recursive
	# sed -i 's/rv32ima/rv32i/g' build-rv32ima.sh
	./build.sh
	./build-rv32ima.sh
	cd ../..
fi

make -C rocket-chip/vsim verilog

rm -rf rocket-syn
mkdir -p rocket-syn

cat > rocket-syn/rocket-syn.ys << EOT
read_verilog rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v
read_verilog rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.behav_srams.v

read_verilog <<E
module plusarg_reader #(
	parameter [1023:0] FORMAT = "borked=%d",
	parameter integer DEFAULT = 0
) (
	output [31:0] out
);
	assign out = DEFAULT;
endmodule
E

verilog_defines -D RISCV_FORMAL
verilog_defines -D RISCV_FORMAL_NRET=2
verilog_defines -D RISCV_FORMAL_XLEN=$(if $enable_64bits; then echo 64; else echo 32; fi)
verilog_defines -D RISCV_FORMAL_ILEN=32

read_verilog -sv ../../checks/rvfi_macros.vh
read_verilog -sv ../../checks/rvfi_channel.sv
read_verilog -sv -D ROCKET_INIT wrapper.sv

# ---- Create RVFI on RocketWithRVFI ----

cd RocketWithRVFI

expose rvfi_mon_rvfi_insn
expose rvfi_mon_rvfi_mem_addr
expose rvfi_mon_rvfi_mem_rdata
expose rvfi_mon_rvfi_mem_rmask
expose rvfi_mon_rvfi_mem_wdata
expose rvfi_mon_rvfi_mem_wmask
expose rvfi_mon_rvfi_order
expose rvfi_mon_rvfi_pc_rdata
expose rvfi_mon_rvfi_pc_wdata
expose rvfi_mon_rvfi_rd_addr
expose rvfi_mon_rvfi_rd_wdata
expose rvfi_mon_rvfi_rs1_addr
expose rvfi_mon_rvfi_rs1_rdata
expose rvfi_mon_rvfi_rs2_addr
expose rvfi_mon_rvfi_rs2_rdata
expose rvfi_mon_rvfi_trap
expose rvfi_mon_rvfi_halt
expose rvfi_mon_rvfi_intr
expose rvfi_mon_rvfi_valid

rename rvfi_mon_rvfi_insn      rvfi_insn
rename rvfi_mon_rvfi_mem_addr  rvfi_mem_addr
rename rvfi_mon_rvfi_mem_rdata rvfi_mem_rdata
rename rvfi_mon_rvfi_mem_rmask rvfi_mem_rmask
rename rvfi_mon_rvfi_mem_wdata rvfi_mem_wdata
rename rvfi_mon_rvfi_mem_wmask rvfi_mem_wmask
rename rvfi_mon_rvfi_order     rvfi_order
rename rvfi_mon_rvfi_pc_rdata  rvfi_pc_rdata
rename rvfi_mon_rvfi_pc_wdata  rvfi_pc_wdata
rename rvfi_mon_rvfi_rd_addr   rvfi_rd_addr
rename rvfi_mon_rvfi_rd_wdata  rvfi_rd_wdata
rename rvfi_mon_rvfi_rs1_addr  rvfi_rs1_addr
rename rvfi_mon_rvfi_rs1_rdata rvfi_rs1_rdata
rename rvfi_mon_rvfi_rs2_addr  rvfi_rs2_addr
rename rvfi_mon_rvfi_rs2_rdata rvfi_rs2_rdata
rename rvfi_mon_rvfi_trap      rvfi_trap
rename rvfi_mon_rvfi_halt      rvfi_halt
rename rvfi_mon_rvfi_intr      rvfi_intr
rename rvfi_mon_rvfi_valid     rvfi_valid

delete rvfi_mon
cd ..

# ---- Create RVFI on RocketTile_rocket ----

cd RocketTile_rocket

add -output rvfi_insn       $(if $enable_64bits; then echo  64; else echo  64; fi)
add -output rvfi_mem_addr   $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_mem_rdata  $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_mem_rmask  $(if $enable_64bits; then echo  16; else echo   8; fi)
add -output rvfi_mem_wdata  $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_mem_wmask  $(if $enable_64bits; then echo  16; else echo   8; fi)
add -output rvfi_order      $(if $enable_64bits; then echo 128; else echo 128; fi)
add -output rvfi_pc_rdata   $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_pc_wdata   $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_rd_addr    $(if $enable_64bits; then echo  10; else echo  10; fi)
add -output rvfi_rd_wdata   $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_rs1_addr   $(if $enable_64bits; then echo  10; else echo  10; fi)
add -output rvfi_rs1_rdata  $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_rs2_addr   $(if $enable_64bits; then echo  10; else echo  10; fi)
add -output rvfi_rs2_rdata  $(if $enable_64bits; then echo 128; else echo  64; fi)
add -output rvfi_trap       $(if $enable_64bits; then echo   2; else echo   2; fi)
add -output rvfi_halt       $(if $enable_64bits; then echo   2; else echo   2; fi)
add -output rvfi_intr       $(if $enable_64bits; then echo   2; else echo   2; fi)
add -output rvfi_valid      $(if $enable_64bits; then echo   2; else echo   2; fi)

connect -port core rvfi_insn      rvfi_insn
connect -port core rvfi_mem_addr  rvfi_mem_addr
connect -port core rvfi_mem_rdata rvfi_mem_rdata
connect -port core rvfi_mem_rmask rvfi_mem_rmask
connect -port core rvfi_mem_wdata rvfi_mem_wdata
connect -port core rvfi_mem_wmask rvfi_mem_wmask
connect -port core rvfi_order     rvfi_order
connect -port core rvfi_pc_rdata  rvfi_pc_rdata
connect -port core rvfi_pc_wdata  rvfi_pc_wdata
connect -port core rvfi_rd_addr   rvfi_rd_addr
connect -port core rvfi_rd_wdata  rvfi_rd_wdata
connect -port core rvfi_rs1_addr  rvfi_rs1_addr
connect -port core rvfi_rs1_rdata rvfi_rs1_rdata
connect -port core rvfi_rs2_addr  rvfi_rs2_addr
connect -port core rvfi_rs2_rdata rvfi_rs2_rdata
connect -port core rvfi_trap      rvfi_trap
connect -port core rvfi_halt      rvfi_halt
connect -port core rvfi_intr      rvfi_intr
connect -port core rvfi_valid     rvfi_valid

cd ..

# ---- Simulate init sequence ----

hierarchy -top rvfi_wrapper
prep -nordff
uniquify
hierarchy

setundef -undriven -zero w:*
opt -fast

write_ilang rocket-syn/init.il
sim -clock clock -reset reset -rstlen 10 -zinit -w -vcd rocket-syn/init.vcd -n 300

# ---- Generate netlists ----

rename rvfi_wrapper.uut RocketTile_rocket
hierarchy -top RocketTile_rocket
uniquify
hierarchy

# rename -hide w:_*

write_ilang rocket-syn/rocket-hier.il

# flatten
# opt -fast
#
# write_ilang rocket-syn/rocket-flat.il
#
# opt -full
# memory_map
# opt -fast
# techmap
# opt -fast
# abc -fast
# opt_clean
# stat
#
# write_ilang rocket-syn/rocket-gates.il
EOT

yosys -v2 -l rocket-syn/rocket-syn.log rocket-syn/rocket-syn.ys

cat > checks.cfg <<EOT
[options]
isa rv$(if $enable_64bits; then echo  64; else echo  32; fi)i$(if $enable_compressed; then echo c; fi)
nret 2

insn          35
reg     25    35
pc_fwd  25    35
pc_bwd  25    35
unique  25 30 35
causal  25    35
# hang  25    50

[defines]
\`define ROCKET_NORESET
\`define NO_MISA
// \`define NO_SYSTEM
// \`define NO_LDX0
// \`define FAST_MEM

[script-sources]
read_verilog -sv @basedir@/tests/coverage/riscv_rv32i_insn.v
read_verilog -sv @basedir@/cores/@core@/wrapper.sv
read_ilang @basedir@/cores/@core@/@core@-syn/@ilang_file@

[filter-checks]
+ insn_(lb|lbu|lh|lhu|lw|c_lw|c_lwsp)_ch1
- insn_.*_ch1
EOT

