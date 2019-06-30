#!/bin/bash

set -ex
cexdata="cexdata-$(date '+%Y%m%d')"

rm -rf $cexdata
mkdir $cexdata

for x in {checks,testbug[0-9][0-9][0-9]}/*/FAIL; do
	test -f $x || continue
	x=${x%/FAIL}
	y=${x/\//_}
	cp $x/logfile.txt $cexdata/$y.log
	if test -f $x/engine_*/trace.vcd; then
		cp $x/engine_*/trace.vcd $cexdata/$y.vcd
		python3 disasm.py $cexdata/$y.vcd > $cexdata/$y.asm
	fi
done

for x in {checks,testbug[0-9][0-9][0-9]}/*.sby; do
	test -f $x || continue
	x=${x%.sby}
	if [ -f $x/PASS ]; then
		printf "%-30s %s %10s\n" $x pass $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' $x/logfile.txt)
	elif [ -f $x/FAIL ]; then
		printf "%-30s %s %10s\n" $x FAIL $(sed '/Elapsed process time/ { s/.*\]: //; s/ .*//; p; }; d;' $x/logfile.txt)
	else
		printf "%-30s %s\n" $x unknown
	fi
done | awk '{ print gensub(":", "", "g", $3), $0; }' | sort -n | cut -f2- -d' ' > $cexdata/status.txt

rm -f $cexdata.zip
zip -r $cexdata.zip $cexdata/
