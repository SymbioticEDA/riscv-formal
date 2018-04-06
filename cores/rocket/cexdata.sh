#!/bin/bash

set -ex

rm -rf cexdata
mkdir cexdata

{
	echo "rocket-chip version:"
	git -C rocket-chip log -n1 --format=fuller
	echo
	echo "riscv-formal version:"
	git log -n1 --format=fuller
} > cexdata/version.txt

cp rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v cexdata/rocketchip.v
cp rocket-chip/src/main/scala/system/Configs.scala cexdata/Configs.scala
git -C rocket-chip diff src/main/scala/system/Configs.scala > cexdata/Configs.scala.diff
cp rocket-syn/init.vcd cexdata/init.vcd

for x in checks/*/FAIL; do
	test -f $x || continue
	x=${x%/FAIL}
	x=${x#checks/}
	cp checks/$x/logfile.txt cexdata/$x.log
	cp checks/$x/engine_*/trace.vcd cexdata/$x.vcd
	if grep -q "^isa rv64" checks.cfg; then
		python3 disasm.py --64 cexdata/$x.vcd > cexdata/$x.asm
	fi
	if grep -q "^isa rv32" checks.cfg; then
		python3 disasm.py cexdata/$x.vcd > cexdata/$x.asm
	fi
done

for x in checks/*.sby; do
	x=${x%.sby}
	x=${x#checks/}
	if [ -f checks/$x/PASS ]; then
		printf "%-20s %s %10s\n" $x pass $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' checks/$x/logfile.txt)
	elif [ -f checks/$x/FAIL ]; then
		printf "%-20s %s %10s\n" $x FAIL $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' checks/$x/logfile.txt)
	else
		printf "%-20s %s\n" $x unknown
	fi
done | sort -nk3 > cexdata/status.txt

rm -f cexdata.zip
zip -r cexdata.zip cexdata/

