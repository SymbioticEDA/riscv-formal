
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

RISCV_FORMAL_STRICT_READ
------------------------

By default the instruction checkers allow the core to read a register even if
the specification says the instruction shouldn't read a register (e.g. a read
on the `rs2` port for an instruction that only uses `rs1`). When this define is
set the instruction checker enforces that instructions that shouldn't read from
a register file port actually don't read from that port.

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


Macros defined by rvfi_macros.vh
================================

The Verilog file `rvfi_macros.vh` defines a few useful helper macros.

RVFI_WIRES, RVFI_OUTPUTS, RVFI_INPUTS, RVFI_CONN
------------------------------------------------

Macros to declare wires, ouptut ports, or input ports for all `rvfi_*` signals. The last
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

