#!/bin/bash

set -ex

echo "all: checks" > testbugs.mk
echo "checks::" >> testbugs.mk
echo "	\$(MAKE) -C checks" >> testbugs.mk
if [ ! -d checks ]; then
	python3 ../../checks/genchecks.py
fi
for bug in 001 002 003 004 005; do
	sed "s/PICORV32_TESTBUG_NONE/PICORV32_TESTBUG_${bug}/" < checks.cfg > testbug${bug}.cfg
	echo "checks::" >> testbugs.mk
	echo "	\$(MAKE) -C testbug${bug}" >> testbugs.mk
	if [ ! -d testbug${bug} ]; then
		python3 ../../checks/genchecks.py testbug${bug}
	fi
done
