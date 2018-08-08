
Quick Start Guide
=================

So you want to get your hands dirty with riscv-formal? Install the tools and
pick one of the exercises below.

See also [this presentation slides](http://www.clifford.at/papers/2017/riscv-formal/) for an introduction to riscv-formal.

Prerequisites
-------------

You'll need Yosys, SymbiYosys, and Boolector for the formal proofs. See
[here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for install instructions.

Some of those tools are packaged for some of the major Linux distribution, but
those packages are sometimes a few years old and do not work with riscv-formal.
Follow the descriptions linked above and install from the latest sources instead.

If you want to inspect counter example traces you will need
[gtkwave](http://gtkwave.sourceforge.net/). Whatever version of gtkwave is
pre-packaged in your distribution is probably fine.

If you want to disassemble the code executed in the counter example traces you
will need an installation of 32 bit [riscv-tools](https://github.com/riscv/riscv-tools),
specifically you'll need `riscv32-unknown-elf-gcc` and `riscv32-unknown-elf-objdump`
in your `$PATH`.

For the 2nd exercise the PicoRV32 Makefile expects a toolchain with certain
properties in `/opt/riscv32i`. The easiest way to build this is to check out
the [PicoRV32 github repo](https://github.com/cliffordwolf/picorv32) and run
`make -j$(nproc) build-riscv32i-tools` (see [this](https://github.com/cliffordwolf/picorv32#building-a-pure-rv32i-toolchain)
for prerequisites and more documentation on the process).

For the 2nd exercise you will also need [Icarus Verilog](http://iverilog.icarus.com/).
If your distribution packages v10 or better then this is fine, otherwise you'll
need to build it from source.

Exercise 1: Formally verify a core
----------------------------------

Formally verify that PicoRV32 complies with the RISC-V ISA:

```
cd cores/picorv32
wget -O picorv32.v https://raw.githubusercontent.com/cliffordwolf/picorv32/master/picorv32.v
python3 ../../checks/genchecks.py
make -C checks -j$(nproc)
```

This will run on the order of four CPU hours (AMD Bulldozer at 3.6 GHz). It
is over 60 individual checks than can all run in parallel if the machine has
sufficient memory and cores. So if you run it on a large server you can
completely verify the core in just a few minutes.

Now make a random change to `picorv32.v` and re-run the tests:

```
python3 ../../checks/genchecks.py
make -C checks -j$(nproc)
```

The check will likely fail now. (It will if the change did break ISA compliance
of the core.)

If you have a 32 bit version of riscv-tools installed (`riscv32-unknown-elf-gcc` and
`riscv32-unknown-elf-objdump` are in `$PATH`) then you can use `disasm.py` to display
the sequence of instructions that caused the error.

Let's say `liveness_ch0` is the check that failed:

```
python3 disasm.py checks/liveness_ch0/engine_0/trace.vcd
```

Or you can simply use gtkwave to display the counter example trace:

```
gtkwave checks/liveness_ch0/engine_0/trace.vcd checks.gtkw
```

Exercise 2: Build an RVFI Monitor and run it
-------------------------------------------

An RVFI Monitor can be run side-by-side with your core and will detect when the
core violates the ISA spec. RVFI monitors are synthesizable, so in addition to
simulation they can also be used in FPGA emulation testing.

Let's build an RVFI Monitor to be used with PicoRV32. PicoRV32 supports the
rv32ic ISA (`-i rv32ic`), its RVFI port is one channel wide (`-c 1`), and it
performs memory operations with word alignment (`-a`):

```
cd monitor
python3 generate.py -i rv32ic -c 1 -a -p picorv32_rvfimon > picorv32_rvfimon.v
```

Next we need to clone the PicoRV32 git repository and copy the monitor core:

```
git clone https://github.com/cliffordwolf/picorv32.git
cp picorv32_rvfimon.v picorv32/rvfimon.v
cd picorv32
```

And then run the test bench with RVFI monitor support:

```
make test_rvf
```

(You will need to make minor changes to the Makefile if you don't have an rv32i
toolchain installed in `/opt/riscv32i`.)

You can now try making changes to `picorv32.v` and see if the RVFI monitor catches
errors in the test bench when you re-run `make test_rvf`.

You can also try running `generate.py` with `-V`. This will generate a monitor that
prints some information about each packet it sees on the RVFI port.

