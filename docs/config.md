
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
used by any of the riscv-formal Verilog files, it can be used by cores under
test to enable or disable generation of the RVFI ports.

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

RISCV_FORMAL_UMODE
------------------

This macro must be defined when the core under tests supports U-mode.

RISCV_FORMAL_SMODE
------------------

This macro must be defined when the core under tests supports S-mode.

RISCV_FORMAL_COMPRESSED
-----------------------

For cores supporting the RISC-V Compressed ISA this define must be set.

RISCV_FORMAL_ALTOPS
-------------------

This macro must be defined if the core under tests implements [alternative arithmetic semantic](https://github.com/SymbioticEDA/riscv-formal/blob/master/docs/rvfi.md#alternative-arithmetic-operations).

RISCV_FORMAL_ALIGNED_MEM
------------------------

Cores that only have hardware support for word-aligned memory access may choose
to retire memory load/store operations for smaller units (half-words, bytes)
word aligned with the appropiate `rmask/wmask` values to select the correct
bytes. In this case the `RISCV_FORMAL_ALIGNED_MEM` macro must be defined.

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

RISCV_FORMAL_FAIRNESS
---------------------

When checking for liveness of the core, then the peripherals and abstractions
used in the check must guarantee fairness. This macro should be tested by the
peripherals and abstractions to decide if fairness guarantees should be enabled.

RISCV_FORMAL_VALIDADDR(addr)
----------------------------

Set this to an expression of `addr` that evaluates to 1 when the given address
is a valid physical address for the processor under test.

RISCV_FORMAL_WAITINSN(insn)
---------------------------

Set this to an expression of `insn` that evaluates to 1 when the given instruction
is a wait instruction similar to WFI. (WFI does not need to be recognized by the
expression. This is for non-standard instructions in addition to WFI.)

RISCV_FORMAL_PMA_MAP
--------------------

Set this to the name of a module that takes an address as input and outputs
the PMA info for that address. The exact interface of such a module is not
entirely defined yet.


Macros defined by rvfi_macros.vh
================================

The Verilog file `rvfi_macros.vh` defines a few useful helper macros.

RVFI_WIRES, RVFI_OUTPUTS, RVFI_INPUTS, RVFI_CONN
------------------------------------------------

Macros to declare wires, output ports, or input ports for all `rvfi_*` signals. The last
macro is for creating the proper connections on module instances. This macros can be
useful for routing the `rvfi_*` signals through the design hierarchy.

rvformal_rand_reg and rvformal_const_rand_reg
---------------------------------------------

Macros for defining unconstrained signals (`rvformal_rand_reg`) or constant signals with
an unconstrained initial value (`rvformal_const_rand_reg`).

Usage example:

    `rvformal_rand_reg [7:0] anyseq;
    `rvformal_const_rand_reg [7:0] anyconst;

For formal verification with Yosys (i.e. when `YOSYS` is defined), this will be
converted to the following code:

    rand reg [7:0] anyseq;
    const rand reg [7:0] anyconst;

For simulation (i.e. when `SIMULATION` is defined), this will be converted to:

    reg [7:0] anyseq;
    reg [7:0] anyconst;

And otherwise (for use with any formal verification tool):

    wire [7:0] anyseq;
    reg [7:0] anyconst;

