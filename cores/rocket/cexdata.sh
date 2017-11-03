#!/bin/bash

set -ex

rm -rf cexdata
mkdir cexdata

cp rocket-chip/vsim/generated-src/freechips.rocketchip.system.DefaultConfigWithRVFIMonitors.v cexdata/

for x in checks/*/FAIL; do
	x=${x%/FAIL}
	x=${x#checks/}
	cp checks/$x/logfile.txt cexdata/$x.log
	cp checks/$x/engine_0/trace.vcd cexdata/$x.vcd
done

rm -f cexdata.zip
zip -r cexdata.zip cexdata/

