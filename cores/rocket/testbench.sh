#!/bin/bash
set -ex
iverilog -o testbench -s testbench testbench.v \
		rocket-chip/vsim/generated-src/rocketchip.DefaultConfigWithRVFIMonitors.v \
		rocket-chip/vsim/generated-src/rocketchip.DefaultConfigWithRVFIMonitors.behav_srams.v \
		rocket-chip/vsrc/plusarg_reader.v rocket-chip/vsrc/RVFIMonitor.v
./testbench +vcd=testbench.vcd
