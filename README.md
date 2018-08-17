
RISC-V Formal Verification Framework
====================================

**This is work in progress. The interfaces described here are likely to change as the project matures.**

About
-----

`riscv-formal` is a framework for formal verification of RISC-V processors.

It consists of the following components:
- A processor-independent formal description of the RISC-V ISA
- A set of formal testbenches for each processor supported by the framework
- The specification for the [RISC-V Formal Interface (RVFI)](docs/rvfi.md) that must be implemented by a processor core to interface with `riscv-formal`.
- Some auxiliary proofs and scripts, for example to prove correctness of the ISA spec agains riscv-isa-sim.

See [cores/picorv32/](cores/picorv32/) for example bindings for the PicoRV32 processor core.

A processor core usually will implement RVFI as an optional feature that is only enabled for verification. Sequential equivalence check can be used to prove equivalence of the processor versions with and without RVFI.

The current focus is on implementing formal models of all instructions from the RISC-V RV32I and RV64I ISAs, and formally verifying those models against the models used in the RISC-V "Spike" ISA simulator.

`riscv-formal` uses the FOSS SymbiYosys formal verification flow. All properties are expressed using immediate assertions/assumptions for maximal compatibility with other tools.

Table of contents
-----------------

- [Quickstart Guide](docs/quickstart.md)
- [The RVFI Interface Specification](docs/rvfi.md)
- [RISC-V Formal CSR Sematics](docs/csrs.md)
- [Configuration macros used by riscv-formal](docs/config.md)
- [The riscv-formal Verification Procedure](docs/procedure.md)
- [Examples of bugs found with riscv-formal](docs/examplebugs.md)
- [References and related work](docs/references.md)

See also [this presentation slides](http://www.clifford.at/papers/2017/riscv-formal/) for an introduction to riscv-formal.

