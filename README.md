RISC-V Formal Verification Framework
====================================

**This is work in progress. The interfaces described below are likely to change and the current implementation of everything mentioned below is incomplete.**

About
-----

`riscv-formal` is a framework for formal verification of RISC-V processors.

It consists of the following components:
- A processor-independent formal description of the RISC-V ISA
- A set of formal testbenches for each processor supported by the framework
- The specification for the [RISC-V Formal Interface (RVFI)](docs/rfvi.md) that must be implemented by a processor core to interface with `riscv-formal`.

See [cores/picorv32/](cores/picorv32/) for example bindings for the PicoRV32 processor core.

A processor core usually will implement RVFI as an optional feature that is only enabled for verification. Sequential equivalence check can be used to prove equivalence of the processor versions with and without RVFI.

The current focus is on implementing formal models of all instructions from the RISC-V RV32I and RV64I ISAs, and formally verifying those models against the models used in the RISC-V "Spike" ISA simulator.

`riscv-formal` uses the FOSS SymbiYosys formal verification flow. All properties are expressed using immediate assertions/assumptions for maximal compatibility with other tools.

See [docs/rfvi.md](docs/rfvi.md) for a description of the RISC-V Formal Interface (RVFI).

Related Work
------------

ARM's [ISA-Formal Framework](https://alastairreid.github.io/papers/cav2016_isa_formal.pdf) follows a similar set of ideas and has inspired the work on `riscv-formal`.

Other RISC-V formal verification projects and related materials:

- [Kami: A Framework for (RISC-V) HW Verification](https://riscv.org/wp-content/uploads/2016/07/Wed1130_Kami_Framework_Murali_Vijayaraghavan.pdf)
- [Verifying a RISC-V Processor, Nirav Dave, Prashanth Mundkur, SRI International](https://riscv.org/wp-content/uploads/2015/06/riscv-verification-workshop-june2015.pdf)

Please [open an issue](https://github.com/cliffordwolf/riscv-formal/issues/new) if you known of other RISC-V formal verification projects I should link to in this section.

Verification Procedure
----------------------

The following formal test are performed to verify ISA compliance of RISC-V processors with `riscv-formal`. Depending on aspects like the strength of safety properties present in the core, the overall complexity of the core, and the verification requirements for the given application, the following tests might be set up as bounded model checks or as unbounded verification tasks.

### Verifying correct instruction fetch

The core is embedded in a formal test bench that connects the core to a read-only instruction memory. For all retired instructions output through the RVFI port of the core, the fetched instruction is compared to the actual instruction word in the memory location pointed to by the pre-state program counter (pc).

See `imemcheck.v` in [cores/picorv32/](cores/picorv32/) for an example implementation.

### Verifying consistency between instructions

The core is embedded in a formal test bench with an unconstrained memory interface (i.e. memory is outside of the formal test bench, no modelling of memory is necessary). A sequence of instruction is generated and it is checked if pre- and post-states of this instruction sequence are consistent, i.e. when a register is written by one instruction, and read by a later instruction (without other writes to the same register between those two instructions), then the written value must be the value that is read back. This test checks for consistency of all `x` registers and the program counter.

See `regcheck.v` and `pccheck.v` in [cores/picorv32/](cores/picorv32/) for one possible implementation of this test.

### Verifying consistency of memory operations

The core is embedded in a formal test bench and a sequence of instruction is generated. It is checked if memory writes and later memory reads to the same memory address is consistent.

See `dmemcheck.v` in [cores/picorv32/](cores/picorv32/) for one possible implementation of this test.

### Verifying correctness of individual instructions

The core is embedded in a formal test bench with an unconstrained memory interface and connected to the generic (core-independent) `insn_checker` core. The `insn_checker` core is configured (using Verilog defines) to a specific channel and instruction. The testbench enables the `insn_checker` core in one specific cycle. This test is repeated for each instruction in the ISA specification, proving that the core implements all instructions from the ISA correctly.

See `insncheck.v` in [cores/picorv32/](cores/picorv32/) for an example implementation.

### Checking for equivalence of core with and without RVFI

An equivalence check of the core with and without RVFI (with respect to the non-RVFI outputs) is performed. This proves that the verification results for the core with enabled RVFI also prove that the (non-RVFI) production core is correct without extra burden on the core designer to isolate the RVFI implementation from the rest of the core.

See `equiv.sh` in [cores/picorv32/](cores/picorv32/) for an example implementation.

### Verification of riscv-formal models against spike models

The checks in [tests/spike/](tests/spike/) use the Yosys SimpleC back-end and CBMC to check the `riscv-formal` models and the C instruction models from spike for equivalence.

