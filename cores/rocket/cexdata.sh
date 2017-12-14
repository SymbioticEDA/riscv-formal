#!/bin/bash

set -ex

rm -rf cexdata
mkdir cexdata

cp rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v cexdata/
( cd rocket-chip; git diff src/main/scala/system/Configs.scala; ) > cexdata/Configs.scala.diff

for x in checks/*/FAIL; do
	x=${x%/FAIL}
	x=${x#checks/}
	cp checks/$x/logfile.txt cexdata/$x.log
	cp checks/$x/engine_0/trace.vcd cexdata/$x.vcd
	if grep -q "^isa rv64" checks.cfg; then
		python3 disasm.py --64 cexdata/$x.vcd > cexdata/$x.asm
	fi
	if grep -q "^isa rv32" checks.cfg; then
		python3 disasm.py cexdata/$x.vcd > cexdata/$x.asm
	fi
done

rm -f cexdata.zip
zip -r cexdata.zip cexdata/

