define template
all:: insn_$(1)/PASS

insn_$(1)/PASS: insn_$(1).sby riscv-semantics/.stamp
	sby -f insn_$(1).sby

insn_$(1).sby: makejob.py riscv-semantics/.stamp
	python3 makejob.py $(1)

clean::
	rm -rf insn_$(1) insn_$(1).sby
endef

$(foreach job,$(shell cat ../../insns/isa_rv32i.txt),$(eval $(call template,$(job))))

riscv-semantics/.stamp:
	set -ex; git clone --recursive https://github.com/mit-plv/riscv-semantics; \
	cd riscv-semantics; ./install.sh; ./install-clash.sh; ./make-circuit.sh
	touch riscv-semantics/.stamp

distclean: clean
	rm -rf riscv-semantics
