
define template
all:: insn_$(1)/PASS

insn_$(1)/PASS: insn_$(1).sby verilog
	sby -f insn_$(1).sby

insn_$(1).sby: makejob.py
	python3 makejob.py $(1)

clean::
	rm -rf insn_$(1) insn_$(1).sby
endef

$(foreach job,$(shell cat ../../insns/isa_rv32i.txt),$(eval $(call template,$(job))))

verilog:
	wget -O verilog.tar.gz https://github.com/mit-plv/riscv-semantics/raw/master/src/verilog.tar.gz
	tar xvzf verilog.tar.gz

