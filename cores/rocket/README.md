
riscv-formal proofs for rocket-chip
===================================

Quickstart guide:

First install Yosys, SymbiYosys, and the solvers. See
[here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for instructions. Then build the version of rocket-chip with RVFI support and
rsicv-tools, and generate the formal checks:

```
sudo apt-get install autoconf automake autotools-dev curl \
		device-tree-compiler libmpc-dev libmpfr-dev \
		libgmp-dev gawk build-essential bison flex \
		texinfo gperf libtool patchutils bc zlib1g-dev \
		libusb-1.0-0-dev openjdk-8-jdk-headless
bash generate.sh
```

Then run the formal checks:

```
make -C checks -j$(nproc)
```

Or if you just want to simulate Rocket with RVFIMonitor:

```
export CONFIG=DefaultConfigWithRVFIMonitors
export RISCV=$PWD/riscv-tools
cd rocket-chip/emulator
make -j$(nproc)
make run
```

Important Notes
===============

This check sets all dangling wires in the design to constant zero. Without this
there would be a problem with propagating Xs and the checks would fail. Obviously
this is a problem that needs to be addressed in the design, but for now we work
around it here so we can continue writing checks.

