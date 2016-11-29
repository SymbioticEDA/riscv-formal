RISC-V Formal Verification Framework
====================================

About
-----

`riscv-formal` is a framework for formal verification of RISC-V processors.

It consists of the following components:
- A processor-independent formal description of the RISC-V ISA
- A set of formal testbenches for each processor supported by the framework
- The specification for the RISC-V Formal Interface (RVFI) that must be implemented by a processor core to interface with `riscv-formal`.

See [cores/picorv32/](cores/picorv32/) for example bindings for the PicoRV32 processor core.

A processor core usually will implement RVFI as an optional feature that is only enabled for verification. Sequential equivalence check can be used to prove equivalence of the processor versions with and without RVFI.

RVFI in its current form supports multiple-issue in-order processors, but current work focuses on single-issue in-order cores. Out-of-order cores must be able to generate an in-order sequence of retired instructions.

The current RVFI specification does not support verification memory load and store operations.

The current focus is on implementing formal models of all (non-ld/st) instructions from the RISC-V RV32I and RV64I ISAs, and formally verifying those models agains the models used in the RISC-V "Spike" ISA simulator.

`riscv-formal` uses the FOSS Yosys-SMTBMC Verilog verification flow. All properties are expressed using immediate assertions/assumptions for maximal compatibility with other tools.

Related Work
------------

ARM's [ISA-Formal Framework](https://alastairreid.github.io/papers/cav2016_isa_formal.pdf) follows a similar set of ideas and has inspired the work on `riscv-formal`.

Test Procedure
--------------

The following formal test are performed to verify ISA complience of a RISC-V processors with `riscv-formal`. Depending on aspects like the strenght of safety properties present in the core, the overall complexity of the core, and the verification requirements for the given application, the following tests might be set up as bounded model chacks or as unbounded verification tasks.

### Verifying correct instruction fetch

The core is embedded in a formal test bench that connects the core to a read-only instruction memory. For all retired instructions output through the RVFI port of the core, the fetched instruction is compared to the actual instruction word in the memory location pointed to by the pre-state program counter (pc).

See `memcheck.v` in [cores/picorv32/](cores/picorv32/) for an example implementation.

### Verifying consistency between instructions

The core is embedded in a formal test bench with an unconstrained memory interface (i.e. memory is outside of the formal test bench, no modelling of memory is neccessary). A sequence of instruction is generated and it is checked if pre- and post-states of this instruction sequence are consistent, i.e. when a register is written by one instruction, and read by a later instruction (without other writes to the same register between those two instructions), then the written value must be the value that is read back. This test checks for consistency of all `x` registers and the program counter.

See `regcheck.v` in [cores/picorv32/](cores/picorv32/) for one possible implementation of this test.

### Verifying correctness of individual instructions

The core is embedded in a formal test bench with an unconstrained memory interface and connected to the generic (core-independent) `insn_checker` core. The `insn_checker` core is configured (using Verilog defines) to a specific channel and instruction. The testbench enables the `insn_checker` core in one specific cycle. This test is repeated for each instruction in the ISA specification, proving that the core implements all instructions from the ISA correctly.

See `insncheck.v` in [cores/picorv32/](cores/picorv32/) for an example implementation.

RISC-V Formal Interface (RVFI)
------------------------------

In the following specification the term `XLEN` refers to the width of an `x` register in bits, as described in the RISC-V ISA specification. The term `NRET` refers to the maximum number of instructions that the core under test can retire in one cycle. If more than one of the retired instruction writes the the same register, the channel with the highest index contains the instruction that wins the conflict.

The Interface consists only of output signals. Each signal is a concatenation of `NRET` values of constant width, effectively creating `NRET` channels. For simplicity, the following descriptions refer to one such channel. For example, we refer to `rvfi_valid` as a 1-bit signal, not a `NRET`-bits signal.

### `output [NRET        - 1 : 0] rvfi_valid`

When the core retires an instruction, it asserts the `rvfi_valid` signal and uses the signals described below to output the details of the retired instruction. The signals below are only valid during such a cycle and can be driven to arbitrary values in a cycle in which `rvfi_valid` is not asserted.

### `output [NRET *   32 - 1 : 0] rvfi_insn`

This is the 32-bit or 16-bit instruction word. In case of a 16-bit instruction the upper 16-bits of this output may carry an arbitrary bit pattern. The current RVFI specification does not support instructions wider than 32 bits.

### `output [NRET *    5 - 1 : 0] rvfi_rs1`

This is the decoded `rs1` register for the retired instruction. For an instruction that reads no `rs1` register, this output can have an arbitrary value. However, if this output is nonzero then `rvfi_pre_rs1` must carry the value stored in that register in the pre-state, regardless if the instruction actually reads `rs1`.

### `output [NRET *    5 - 1 : 0] rvfi_rs2`

This is the decoded `rs2` register for the retired instruction. For an instruction that reads no `rs2` register, this output can have an arbitrary value. However, if this output is nonzero then `rvfi_pre_rs2` must carry the value stored in that register in the pre-state, regardless if the instruction actually reads `rs2`.

### `output [NRET *    5 - 1 : 0] rvfi_rd`

This is the decoded `rd` register for the retired instruction. For an instruction that writes no `rd` register, this output must always be zero.

### `output [NRET * XLEN - 1 : 0] rvfi_pre_pc`

This is the program counter (`pc`) before execution of this instruction. I.e. this is the address of the retired instruction.

### `output [NRET * XLEN - 1 : 0] rvfi_pre_rs1`

This is the value of the `x` register addressed by `rs1` before execution of this instruction. This output must be zero when `rs1` is zero.

### `output [NRET * XLEN - 1 : 0] rvfi_pre_rs2`

This is the value of the `x` register addressed by `rs2` before execution of this instruction. This output must be zero when `rs2` is zero.

### `output [NRET * XLEN - 1 : 0] rvfi_post_pc`

This is the value of the program counter after execution of this instruction. For a non-banching 32-bit instruction this is `rvfi_pre_pc + 4`.

### `output [NRET * XLEN - 1 : 0] rvfi_post_rd`

This is the value of the `x` register addressed by `rd` after execution of this instruction. This output must be zero when `rd` is zero.

