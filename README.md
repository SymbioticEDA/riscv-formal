RISC-V Formal Verification Framework
====================================

**This repository is up to 6 months behind the non-public development repository. Be patient. I'll continue pushing updates from the development repository in November 2017.** 

**This is work in progress. The interfaces described below are likely to change and the current implementation of everything mentioned below is incomplete.**

About
-----

`riscv-formal` is a framework for formal verification of RISC-V processors.

It consists of the following components:
- A processor-independent formal description of the RISC-V ISA
- A set of formal testbenches for each processor supported by the framework
- The specification for the RISC-V Formal Interface (RVFI) that must be implemented by a processor core to interface with `riscv-formal`.

See [cores/picorv32/](cores/picorv32/) for example bindings for the PicoRV32 processor core.

A processor core usually will implement RVFI as an optional feature that is only enabled for verification. Sequential equivalence check can be used to prove equivalence of the processor versions with and without RVFI.

The current focus is on implementing formal models of all instructions from the RISC-V RV32I and RV64I ISAs, and formally verifying those models against the models used in the RISC-V "Spike" ISA simulator.

`riscv-formal` uses the FOSS SymbiYosys formal verification flow. All properties are expressed using immediate assertions/assumptions for maximal compatibility with other tools.

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

RISC-V Formal Interface (RVFI)
------------------------------

In the following specification the term `XLEN` refers to the width of an `x` register in bits, as described in the RISC-V ISA specification. The term `NRET` refers to the maximum number of instructions that the core under test can retire in one cycle. If more than one of the retired instruction writes the same register, the channel with the highest index contains the instruction that wins the conflict.

The Interface consists only of output signals. Each signal is a concatenation of `NRET` values of constant width, effectively creating `NRET` channels. For simplicity, the following descriptions refer to one such channel. For example, we refer to `rvfi_valid` as a 1-bit signal, not a `NRET`-bits signal.

    output [NRET        - 1 : 0] rvfi_valid
    output [NRET *    8 - 1 : 0] rvfi_order
    output [NRET *   32 - 1 : 0] rvfi_insn
    output [NRET        - 1 : 0] rvfi_trap

When the core retires an instruction, it asserts the `rvfi_valid` signal and uses the signals described below to output the details of the retired instruction. The signals below are only valid during such a cycle and can be driven to arbitrary values in a cycle in which `rvfi_valid` is not asserted.

Cores that retire all instructions in-order may set `rvfi_order` to constant zero. Cores that retire instructions out-of-order must set this field to the instruction index so that they can be sorted within `riscv-formal` test-benches when needed. Right now no such sorter is implemented and cores that retire instructions out-of-order are not supported.

`rvfi_insn` is the 32-bit or 16-bit instruction word. In case of a 16-bit instruction the upper 16-bits of this output may carry an arbitrary bit pattern. The current RVFI specification does not support instructions wider than 32 bits.

The `rvfi_trap` signal that is high for an instruction that traps and low otherwise. The signals associated with the post-state may have arbitrary values when `rvfi_trap` is asserted. `rvfi_rs1_addr` and `rvfi_rs2_addr` may have arbitrary values when `rvfi_trap` is asserted, but `rvfi_rs1_rdata` and `rvfi_rs2_rdata` must be consistent with the register file for nonzero `rvfi_rs1_addr` and `rvfi_rs2_addr` (and zero when `x0` is addressed). Which instruction traps depends on the implemented ISA. Make sure to configure riscv-formal to match the ISA implemented by the core under test.

    output [NRET *    5 - 1 : 0] rvfi_rs1_addr
    output [NRET *    5 - 1 : 0] rvfi_rs2_addr
    output [NRET * XLEN - 1 : 0] rvfi_rs1_rdata
    output [NRET * XLEN - 1 : 0] rvfi_rs2_rdata

`rvfi_rs1_addr` and `rvfi_rs2_addr` are the decoded `rs1` and `rs1` register addresses for the retired instruction. For an instruction that reads no `rs1`/`rs2` register, this output can have an arbitrary value. However, if this output is nonzero then `rvfi_rs1_rdata` must carry the value stored in that register in the pre-state, regardless if the instruction actually reads `rs1`.

`rvfi_rs1_rdata`/`rvfi_rs2_rdata` is the value of the `x` register addressed by `rs1`/`rs2` before execution of this instruction. This output must be zero when `rs1`/`rs2` is zero.

    output [NRET *    5 - 1 : 0] rvfi_rd_addr
    output [NRET * XLEN - 1 : 0] rvfi_rd_wdata

`rvfi_rd_addr` is the decoded `rd` register address for the retired instruction. For an instruction that writes no `rd` register, this output must always be zero.

`rvfi_rd_wdata` is the value of the `x` register addressed by `rd` after execution of this instruction. This output must be zero when `rd` is zero.

    output [NRET * XLEN - 1 : 0] rvfi_pc_rdata
    output [NRET * XLEN - 1 : 0] rvfi_pc_wdata

This is the program counter (`pc`) before (`rvfi_pc_rdata`) and after (`rvfi_pc_wdata`) execution of this instruction. I.e. this is the address of the retired instruction and the address of the next instruction.

    output [NRET * XLEN   - 1 : 0] rvfi_mem_addr
    output [NRET * XLEN/8 - 1 : 0] rvfi_mem_rmask
    output [NRET * XLEN/8 - 1 : 0] rvfi_mem_wmask
    output [NRET * XLEN   - 1 : 0] rvfi_mem_rdata
    output [NRET * XLEN   - 1 : 0] rvfi_mem_wdata

For memory operations (`rvfi_mem_rmask` and/or `rvfi_mem_wmask` are non-zero), `rvfi_mem_addr` holds the accessed memory location. The address must have a 4-byte alignment for `XLEN=32` and an 8-byte alignment for `XLEN=64`.

`rvfi_mem_rmask` is a bitmask that specifies which bytes in `rvfi_mem_rdata` contain valid read data from `rvfi_mem_addr`.

`rvfi_mem_wmask` is a bitmask that specifies which bytes in `rvfi_mem_wdata` contain valid data that is written to `rvfi_mem_addr`.

`rvfi_mem_rdata` is the pre-state data read from `rvfi_mem_addr`. `rvfi_mem_rmask` specifies which bytes are valid.

`rvfi_mem_wdata` is the post-state data written to `rvfi_mem_addr`. `rvfi_mem_wmask` specifies which bytes are valid.

The current `riscv-formal` implementation assumes that unaligned memory access causes a trap. This is actually not what the ISA spec says. The spec says that unaligned memory access can be slow, hinting at that it can be implemented in a trap handler for cores that do not support that in hardware. A configuration switch must be added to `riscv-formal` for configuring if the core supports unaligned memory access in hardware.

RVFI TODOs and Requests for Comments
------------------------------------

### Support for RV64 ISAs

Models for RV64I-only instructions are still missing. They will be added as soon as a RV64 processor with RVFI support is available.

### Support for Compressed ISAs

There are no models for the compressed instructions yet. The proposal is to verify them as if they where separate instructions, i.e. not merge them with the models for uncompressed instructions.

### Modelling of Floating-Point State

The following is the proposed RVFI extension for floating point ISAs:

```
output [NRET *    5 - 1 : 0] rvfi_frs1_addr,
output [NRET *    5 - 1 : 0] rvfi_frs2_addr,
output [NRET *    5 - 1 : 0] rvfi_frs3_addr,
output [NRET *    5 - 1 : 0] rvfi_frd_addr,
output [NRET        - 1 : 0] rvfi_frs1_valid,
output [NRET        - 1 : 0] rvfi_frs2_valid,
output [NRET        - 1 : 0] rvfi_frs3_valid,
output [NRET        - 1 : 0] rvfi_frd_valid,
output [NRET * FLEN - 1 : 0] rvfi_frs1_rdata,
output [NRET * FLEN - 1 : 0] rvfi_frs2_rdata,
output [NRET * FLEN - 1 : 0] rvfi_frs3_rdata,
output [NRET *    3 - 1 : 0] rvfi_frm_rdata,
output [NRET * FLEN - 1 : 0] rvfi_frd_wdata,
output [NRET *    5 - 1 : 0] rvfi_sfflags,
```

Since `f0` is not a zero register, additional `*_valid` signals are required to indicate if `frs1`, `frs2`, `frs3`, and `frd` and their corresponding pre- or post-values are valid.

For instructions that do not use the floating point rounding mode the signal `rvfi_frm_rdata` may be set to `3'b111` instead of the current rounding mode.

The signal `rvfi_sfflags` has the bits set that this instruction sets in the `fflags` CSR. A bit in `fflags` that was already set in the pre-state, and is not set again by this instruction, must not be set in `rvfi_sfflags`.

The FPU model in `riscv-formal` will be swappable (using a Verilog define) with with a pseudo-model that is using cheaper operations instead of proper floating point math. This enables efficient verification of cores that can be configured to support a similar FPU model. (A similar functionality will be provided for M-extension instructions.)

### RVFI Peep Interface

The RVFI Peep Interface is an optional list of additional RVFI ports that significantly simplify the formal proofs to verify consistency between instructions.

```
input  [NRET *    5 - 1 : 0] rvfi_peep_rx_addr,
output [NRET * XLEN - 1 : 0] rvfi_peep_rx_rdata,
output [NRET * XLEN - 1 : 0] rvfi_peep_rx_wdata,
```

The `_addr` port is guaranteed to be driven to a constant value by the formal test-bench. The `_rdata` and `_wdata` ports will be driven to the pre- and post-state values for the specified register, independent of if the current instruction reads or modifies the specified register.

A similar interface is proposed for floating point registers:

```
input  [NRET *    5 - 1 : 0] rvfi_peep_rf_addr,
output [NRET * FLEN - 1 : 0] rvfi_peep_rf_rdata,
output [NRET * FLEN - 1 : 0] rvfi_peep_rf_wdata,
```

### Modelling of Atomic Memory Operations

AMO instructions (`AMOSWAP.W`, etc.) can be modelled using the existing `rvfi_mem_*` interface by asserting bits in both `rvfi_mem_rmask` and `rvfi_mem_wmask`.

The is also no extension to the RVFI port necessary to accommodate the `LR`, `SC`, `FENCE` and `FENCE.I` instructions.

Verification of this instructions for a single-core systems can be done using the RVFI port only. A strategy must be defined to verify their correct behavior in multicore systems. This is TBD.

### Modelling of CSRs and Privileged Machine State

The current thinking is along the following lines: At least two CSR peep ports are added as well as a port for the privilege mode in pre- and post-state.

```
input  [NRET *   12 - 1 : 0] rvfi_peep_csr0_addr,
output [NRET * XLEN - 1 : 0] rvfi_peep_csr0_rdata,
output [NRET * XLEN - 1 : 0] rvfi_peep_csr0_wdata,

input  [NRET *   12 - 1 : 0] rvfi_peep_csr1_addr,
output [NRET * XLEN - 1 : 0] rvfi_peep_csr1_rdata,
output [NRET * XLEN - 1 : 0] rvfi_peep_csr1_wdata,

output [NRET *    2 - 1 : 0] rvfi_mode_rdata,
output [NRET *    2 - 1 : 0] rvfi_mode_wdata,
```

Like there is an individual proof for each instruction, individual proofs (or set of proofs) can be added for each processor feature using CSRs.

A careful investigation of the draft privileged spec is required to determine if two CSR peep ports are sufficient to prove all features described in the spec. For some CSRs, such as `mstatus`, it might be desirable to add a dedicated RVFI port, similar to the `rvfi_mode_rdata` and `rvfi_mode_wdata` ports.

### Verification of riscv-formal models against spike models

The plan for this is to use a to-be-written C-back-end in Yosys to convert the insn models used in `riscv-formal` to C code, and formally verify that C code against the spike models using a C model checker, such as ESBMC or CProver.

