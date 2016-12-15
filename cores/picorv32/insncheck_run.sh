#!/bin/bash

for insn in ../../insns/*.vh; do
	insn=${insn##*/insn_}
	insn=${insn%.vh}
	echo "all:: insn_${insn}.log"
	echo "insn_${insn}.log:"
	echo "	bash insncheck.sh -i ${insn} > insn_${insn}.log"
done > insncheck_run.mk

make -j$(nproc) -f insncheck_run.mk

passed_list=$(grep -l "^No output asserted in 25 frames." insn_*.log)
failed_list=$(grep -L "^No output asserted in 25 frames." insn_*.log)

echo
echo "PASSED $(echo $passed_list | wc -w): $passed_list" | fmt

echo
echo "FAILED $(echo $failed_list | wc -w): $failed_list" | fmt

echo
exit $(echo $failed_list | wc -w)

