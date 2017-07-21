
RISCV-FORMAL Configuration Macros
=================================

The riscv-formal insn models and checkers are configured using a few Verilog
pre-processor macros. They must be defined bofore reading any riscv-formal
verilog files. The first riscv-formal verilog file read after defining the
macros must be [rvfi_macros.vh](../checks/rvfi_macros.vh).

Example configuration:

    `define RISCV_FORMAL
    `define RISCV_FORMAL_NRET 1
    `define RISCV_FORMAL_XLEN 32
    `define RISCV_FORMAL_ILEN 32
    `define RISCV_FORMAL_COMPRESSED
    `define RISCV_FORMAL_ALIGNED_MEM

Defining `RISCV_FORMAL`, `RISCV_FORMAL_NRET`, `RISCV_FORMAL_XLEN`, and
`RISCV_FORMAL_ILEN` is mandatory.

RISCV_FORMAL
------------

This macro should be set whenever riscv-formal is used. It is actually never
used by any of the riscv-formal Verilog files, it it can be used for example
by cores under test to enable or disable generation of the RVFI ports.

RISCV_FORMAL_NRET
-----------------

The number of channels for the RVFI port (and thus the theoretical maximum
number of instructions the core can retire via RVFI in one cycle).

RISCV_FORMAL_XLEN
-----------------

The width of integer registers in the ISA implemented by the core under test.
Valid values are 32, 64, and 128. Only 32 is fully supported at the moment.

RISCV_FORMAL_ILEN
-----------------

The maximum width of an instruction retired by the core. For cores supporting
fused instructions this is the maximum length of a complete fused instruction.

RISCV_FORMAL_COMPRESSED
-----------------------

For cores supporting the RISC-V Compressed ISA is define must be set.

RISCV_FORMAL_ALIGNED_MEM
------------------------

Cores that only have hardware support for word-aligned memory access may choose
to retire memory load/store operations for smaller units (half-words, bytes)
word aligned with the appropiate `rmask/wmask` values to select the correct
bytes. In this case the `RISCV_FORMAL_ALIGNED_MEM` macro must be defined.

RISCV_FORMAL_TRAP_ALIGNED_MEM
-----------------------------

A core may report a misaligned memort access as "illegal instruction" by raising
the `rvfi_trap` line when retiring the instruction via RVFI. For those cores the
macro `RISCV_FORMAL_TRAP_ALIGNED_MEM` must be defined.

RISCV_FORMAL_TRAP_ALIGNED_INSN
------------------------------

A core may report a misaligned instruction as "illegal instruction" by raising
the `rvfi_trap` line when retiring the instruction via RVFI. For those cores the
macro `RISCV_FORMAL_TRAP_ALIGNED_INSN` must be defined.

RISCV_FORMAL_BLACKBOX_REGS
--------------------------

When checking for correct implementation of the RISC-V instructions ("insncheck")
it is possible to black-box the processor register file. This macro may be used
in the core under test to black-box the register file.

RISCV_FORMAL_BLACKBOX_ALU
-------------------------

When checking for consistency of the stream of retired instructions (such as
"regcheck") it is possible to black-box the actual ALU operations. This macro
may be used in the core under test to black-box the ALU.

