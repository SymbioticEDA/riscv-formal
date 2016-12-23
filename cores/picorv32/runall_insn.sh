#!/bin/bash

for insn in ../../insns/insn_*.v; do
	insn=${insn##*/insn_}
	insn=${insn%.v}
	echo "all:: insn_${insn}.log"
	echo "insn_${insn}.log:"
	echo "	bash insncheck.sh -i ${insn} > insn_${insn}.log"
done > runall_insn.mk

make -j$(nproc) -f runall_insn.mk

passed_list=$(egrep -l "^No output asserted in [0-9]+ frames." insn_*.log)
failed_list=$(egrep -L "^No output asserted in [0-9]+ frames." insn_*.log)

echo
echo "PASSED $(echo $passed_list | wc -w): $passed_list" | fmt

echo
echo "FAILED $(echo $failed_list | wc -w): $failed_list" | fmt

echo
exit $(echo $failed_list | wc -w)

