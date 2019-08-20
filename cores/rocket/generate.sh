#!/bin/sh

set -ex

export CONFIG=DefaultConfigWithRVFIMonitors
export MAKEFLAGS="-j$(nproc)"
export RISCV=$PWD/riscv-tools

enable_compressed=true
enable_inithack=true
enable_64bits=true
enable_muldiv=true
enable_misa=true
enable_pmp=false

if [ ! -d rocket-chip ]; then
	git clone --recurse-submodules git@github.com:sifive/rocket-chip-grand-central.git rocket-chip
	cd rocket-chip

	# git checkout bc22847
	# git submodule update --recursive

	if $enable_compressed; then
		( cd ../../../monitor && python3 generate.py -i rv$(if $enable_64bits; then echo 64; else echo 32; fi)ic -p RVFIMonitor -c 2; ) > src/main/resources/vsrc/RVFIMonitor.v
	else
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /new WithRVFIMonitors/ s/$/\n  new WithoutCompressed ++/; };' src/main/scala/system/Configs.scala
		( cd ../../../monitor && python3 generate.py -i rv$(if $enable_64bits; then echo 64; else echo 32; fi)i -p RVFIMonitor -c 2; ) > src/main/resources/vsrc/RVFIMonitor.v
	fi

	if $enable_misa; then
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /new WithoutMISAWrite/ d; };' src/main/scala/system/Configs.scala
	fi

	if $enable_muldiv; then
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /new WithoutMulDiv/ d; };' src/main/scala/system/Configs.scala
	fi

	if $enable_64bits; then
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /freechips.rocketchip.tile.XLen/ s,32,64,; }' src/main/scala/system/Configs.scala
	else
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /freechips.rocketchip.tile.XLen/ s,64,32,; }' src/main/scala/system/Configs.scala
	fi

	if ! $enable_pmp; then
		sed -i -e '/DefaultConfigWithRVFIMonitors/,/^)/ { /new WithNPMP/ s/[0-9]\+/0/; };' src/main/scala/system/Configs.scala
	fi

	sed -i 's/--top-module/-Wno-fatal &/' emulator/Makefrag-verilator

	cd ..
fi

if [ ! -d riscv-tools ]; then
	mkdir riscv-tools
	rm -rf riscv-tools-build
	git clone https://github.com/riscv/riscv-tools riscv-tools-build
	cd riscv-tools-build
	git checkout $(cat ../rocket-chip/riscv-tools.hash)
	git submodule update --init --recursive
	# sed -i 's/rv32ima/rv32i/g' build-rv32ima.sh
	./build.sh
	./build-rv32ima.sh
	cd ..
fi

make -C rocket-chip/vsim verilog

rm -rf rocket-syn
mkdir -p rocket-syn

cat > rocket-syn/rocket-syn.ys << EOT
verific -sv rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v
verific -sv rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.behav_srams.v
verific -sv rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors/plusarg_reader.v
verific -sv rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors/AsyncResetReg.v
verific -sv rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors/SimDTM.v

verific -vlog-define RISCV_FORMAL
verific -vlog-define RISCV_FORMAL_NRET=2
verific -vlog-define RISCV_FORMAL_XLEN=$(if $enable_64bits; then echo 64; else echo 32; fi)
verific -vlog-define RISCV_FORMAL_ILEN=32
verific -vlog-define RISCV_FORMAL_UMODE
verific -vlog-define RISCV_FORMAL_EXTAMO
verific -vlog-define RISCV_FORMAL_CSR_MCYCLE
verific -vlog-define RISCV_FORMAL_CSR_MINSTRET
verific -vlog-define RISCV_FORMAL_CSR_MISA

verific -vlog-define ROCKET_INIT
$(if $enable_inithack; then echo "verific -vlog-define ROCKET_INITHACK"; fi)

verific -sv ../../checks/rvfi_macros.vh ../../checks/rvfi_channel.sv wrapper.sv rocketrvfi.sv
verific -import -extnets rvfi_wrapper

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

rename rvfi_wrapper.rocket_rvfi_tile RocketTileWithRVFI
hierarchy -top RocketTileWithRVFI
uniquify
chtype -set MulDiv RocketTileWithRVFI.rocket_tile.core/div
hierarchy

# rename -hide w:_*

$(if ! $enable_inithack; then echo "# "; fi)setparam -set INIT 16384'bx RocketTileWithRVFI.rocket_tile.frontend.icache.data_arrays_*/ram
write_ilang rocket-syn/rocket-hier.il
EOT

yosys -v2 -l rocket-syn/rocket-syn.log rocket-syn/rocket-syn.ys

cat > checks.cfg <<EOT
[options]
isa rv$(if $enable_64bits; then echo  64; else echo  32; fi)i$(if $enable_muldiv; then echo m; fi)$(if $enable_compressed; then echo c; fi)
nret 2
solver boolector
dumpsmt2

[depth]
insn    $(if $enable_inithack; then echo "      20"; else echo "      35"; fi)
ill     $(if $enable_inithack; then echo "      20"; else echo "      35"; fi)
reg     $(if $enable_inithack; then echo " 5    15"; else echo "20    30"; fi)
pc_fwd  $(if $enable_inithack; then echo " 5    15"; else echo "20    30"; fi)
pc_bwd  $(if $enable_inithack; then echo " 5    15"; else echo "20    30"; fi)
unique  $(if $enable_inithack; then echo "10 15 20"; else echo "25 30 35"; fi)
causal  $(if $enable_inithack; then echo " 5    15"; else echo "20    30"; fi)
hang    $(if $enable_inithack; then echo "10    40"; else echo "20    50"; fi)

reg_ch1 $(if $enable_inithack; then echo " 5    15"; else echo "20    30"; fi)

csrw    $(if $enable_inithack; then echo "      20"; else echo "      35"; fi)

[csrs]
mcycle
minstret
misa

[sort]
hang
(reg|causal)_ch?
insn_.*_ch1

[defines]
\`define ROCKET_NORESET
\`define RISCV_FORMAL_VALIDADDR(addr) ({31{addr[32]}} == addr[63:33])
\`define RISCV_FORMAL_WAITINSN(insn) ((insn) == 32'b_0011000_00101_00000_000_00000_1110011)
\`define RISCV_FORMAL_PMA_MAP rocket_pma_map
\`define RISCV_FORMAL_EXTAMO
\`define RISCV_FORMAL_ALTOPS

[script-sources]
read_verilog -sv @basedir@/tests/coverage/riscv_rv32i_insn.v
read_verilog -sv @basedir@/cores/@core@/wrapper.sv
read_ilang @basedir@/cores/@core@/@core@-syn/@ilang_file@

[filter-checks]
+ insn_(lb|lbu|lh|lhu|lw|lwu|ld|c_lw|c_lwsp|c_ld|c_ldsp)_ch1
+ insn_(mul|mulh|mulhsu|mulhu|div|divu|rem|remu|mulw|divw|divuw|remw|remuw)_ch1
- (insn_.*|csrw_.*|ill)_ch1
EOT

python3 ../../checks/genchecks.py

# see https://nbviewer.jupyter.org/url/svn.clifford.at/fmbench/2018B/report.ipynb
#sed -i '/^smtbmc/ s/boolector/yices/' checks/insn_b{ge,lt,geu,ltu}_ch0.sby
#sed -i '/^smtbmc/ s/boolector/yices/' checks/{pc_bwd_ch0,unique_ch1,causal_ch0}.sby
#sed -i '/^smtbmc/ s/boolector/yices/' checks/insn_j*.sby
#sed -i '/^smtbmc/ s/boolector/yices/' checks/insn_c_{xor,mv,or,sw}_*.sby
#sed -i '/^smtbmc/ s/boolector/yices/' checks/insn_{xor,sw,sh,addi}_*.sby
