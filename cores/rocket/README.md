
riscv-formal proofs for rocket-chip
===================================

Quickstart guide:

First install Yosys, SymbiYosys, and the solvers. See
[here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for instructions. Then build the version of rocket-chip with RVFI support and
rsicv-tools:

```
sudo apt-get install autoconf automake autotools-dev curl \
		device-tree-compiler libmpc-dev libmpfr-dev \
		libgmp-dev gawk build-essential bison flex \
		texinfo gperf libtool patchutils bc zlib1g-dev
bash rocket-chip.sh
```

Then generate the instruction checker proofs and run them:

```
python3 insncheck.py
cd insncheck
make -j$(nproc)
```

