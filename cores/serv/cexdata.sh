#!/bin/bash

set -ex

rm -rf cexdata
mkdir cexdata

while read dir; do echo "$dir	$(git -C $dir log -n1 --oneline)"; \
	done < <( echo .; find serv-src -name '.git' -printf '%h\n'; ) | \
	expand -t30 > cexdata/version.txt

for x in checks/*/FAIL; do
	test -f $x || continue
	x=${x%/FAIL}
	y=${x#checks/}
	cp $x/logfile.txt cexdata/$y.log
	if test -f $x/engine_*/trace.vcd; then
		cp $x/engine_*/trace.vcd cexdata/$y.vcd
		if grep -q "^isa rv64" checks.cfg; then
			python3 disasm.py --64 cexdata/$y.vcd > cexdata/$y.asm
		fi
		if grep -q "^isa rv32" checks.cfg; then
			python3 disasm.py cexdata/$y.vcd > cexdata/$y.asm
		fi
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
done | awk '{ print gensub(":", "", "g", $3), $0; }' | sort -n | cut -f2- -d' ' > cexdata/status.txt

rm -f cexdata.zip
zip -r cexdata.zip cexdata/

