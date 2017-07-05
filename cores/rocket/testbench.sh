#!/bin/bash

set -ex

tracetb=insncheck/insn_add/engine_0/trace_tb.v

egrep -v 'UUT.(core.rvfi_|core.io_status_dprv|core.csr.io_time|core.csr.io_status_dprv|frontend.icache.io_resp_bits)' $tracetb > testbench.v

iverilog -o testbench -s testbench testbench.v \
		rocket-chip/vsim/generated-src/rocketchip.DefaultConfigWithRVFIMonitors.v \
		rocket-chip/vsim/generated-src/rocketchip.DefaultConfigWithRVFIMonitors.behav_srams.v \
		rocket-chip/vsrc/plusarg_reader.v rocket-chip/vsrc/RVFIMonitor.v
./testbench +vcd=testbench.vcd
