#!/bin/bash

for check in reg pc imem dmem; do
	echo "all:: cons_${check}.log"
	echo "cons_${check}.log:"
	echo "	bash conscheck.sh -c ${check} > cons_${check}.log"
done > runall_cons.mk

make -j$(nproc) -f runall_cons.mk

passed_list=$(egrep -l "^No output asserted in [0-9]+ frames." cons_*.log)
failed_list=$(egrep -L "^No output asserted in [0-9]+ frames." cons_*.log)

echo
echo "PASSED $(echo $passed_list | wc -w): $passed_list" | fmt

echo
echo "FAILED $(echo $failed_list | wc -w): $failed_list" | fmt

echo
exit $(echo $failed_list | wc -w)

