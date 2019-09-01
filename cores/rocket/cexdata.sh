#!/bin/bash

set -ex
cexdata="cexdata-$(date '+%Y%m%d')"

rm -rf $cexdata
mkdir $cexdata

while read dir; do echo "$dir	$(git -C $dir log -n1 --oneline)"; \
	done < <( echo .; find rocket-chip -name '.git' -printf '%h\n'; ) | \
	expand -t30 > $cexdata/version.txt

cp rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v $cexdata/rocketchip.v
cp rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.fir $cexdata/rocketchip.fir
gzip $cexdata/rocketchip.v $cexdata/rocketchip.fir

cp rocket-chip/src/main/scala/system/Configs.scala $cexdata/Configs.scala
git -C rocket-chip diff src/main/scala/system/Configs.scala > $cexdata/Configs.scala.diff

vcd2fst rocket-syn/init.vcd $cexdata/init.fst

for x in checks/*/{FAIL,ERROR} coverage/{FAIL,ERROR}; do
	test -f $x || continue
	x=${x%/FAIL}
	x=${x%/ERROR}
	y=${x#checks/}
	cp $x/logfile.txt $cexdata/$y.log
	if test -f $x/engine_*/trace.vcd; then
		cp $x/engine_*/trace.vcd $cexdata/$y.vcd
		if grep -q "^isa rv64" checks.cfg; then
			python3 disasm.py --64 $cexdata/$y.vcd > $cexdata/$y.asm
		fi
		if grep -q "^isa rv32" checks.cfg; then
			python3 disasm.py $cexdata/$y.vcd > $cexdata/$y.asm
		fi
		vcd2fst $cexdata/$y.vcd $cexdata/$y.fst
		rm -f $cexdata/$y.vcd
	fi
done

for x in checks/*.sby; do
	x=${x%.sby}
	x=${x#checks/}
	if [ -f checks/$x/PASS ]; then
		printf "%-20s %s %10s\n" $x pass  $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' checks/$x/logfile.txt)
	elif [ -f checks/$x/FAIL ]; then
		printf "%-20s %s %10s\n" $x FAIL  $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' checks/$x/logfile.txt)
	elif [ -f checks/$x/ERROR ]; then
		printf "%-20s %s\n" $x ERROR
	else
		printf "%-20s %s\n" $x unknown
	fi
done | awk '{ print gensub(":", "", "g", $3), $0; }' | sort -n | cut -f2- -d' ' > $cexdata/status.txt

rm -f $cexdata.zip
zip -r $cexdata.zip $cexdata/

