
Examples of bugs found by riscv-formal
======================================

This page lists a few examples of common types of bugs found by riscv-formal.

This page is intentionally a bit vague on the details. Its purpose is to give
readers an idea of what kind of bugs can be found with riscv-formal, not to
pillory implementations for long fixed bugs.

Instruction Semantics
---------------------

Some parts of the instruction semantics are easy to get wrong and are not
tested very well by standard test-benches like riscv-torture or booting a linux
kernel.

### Reserved C-extension opcodes and hint instructions

The C-extension opcode map contains several reserved opcodes (that should
trigger an illegal instruction trap) and hint instructions (that should be
treated as NOPs). Some implementations get some of those opcodes wrong, and
riscv-formal has found bugs like this.

There were even instances of implementations that fixed issues like that, and
then later reversed the fixes because someone looking over the code misread the
standard and thought they would fix a bug but instead they re-introduced one. A
good example why one should not only verify their implementation once, but
continuously keep verifying it as long as changes are made to the design, even
in cases where those changes are considered "only trivial minor changes".

### JALR clears LSB after addition

The JALR instruction adds an immediate to its source register, clears the LSB
of the sum, and then jumps to the resulting address. (It also stores the
address of the next instruction in the desitination register.)

The code C compilers generate usually (always?) have the LSB of the sum already cleared, so
a bug in an implementation where the LSB is not cleared by the instruction (but, for example, an
instruction address misaligned trap is triggered instead) is usually not
discovered by just running compiler-generated code. With riscv-formal I have
found this exact bug in several implementations.

Troubles with bypassing and forwarding
--------------------------------------

In pipelined architectures bypassing and forwarding are used to avoid pipeline
stalls. Bugs in bypassing and forwarding often are only triggered by a specific
sequence of instructions, combined with just the right (wrong?) timing for
external events (such as completion of a memory operation). I have found several
bugs like this with riscv-formal.

Issues with reset
-----------------

Reset issues can be incredibly hard to find using simulation. One
implementation had a reset problem in the divider so that one could start a
division, then reset the processor while the divide is in flight, and then
divide again as one of the first instructions after reset. If the timing was
just right then this second division would return immediately, with the result
of the divide that was launched before the reset.

Weird and bizarre programs
--------------------------

Some assembler code snippets are so bizarre that rarely someone writes a test
for them. But a proper implementation of RISC-V should of course still cope
with those cases correctly.

### Disabling the C ISA extension while not 32-bit aligned

On a processor that supports it, one can enable or disable individual ISA
extensions by writing to the `misa` CSR. Disabling the C extension in an
instruction that isn't aligned to a 32-bit word should cause the processor to
trigger an instruction address misaligned trap for the next instruction. One
processor had a bug so that when the next instruction was a load, that load was
not killed properly and then caused some strange effects when the load
finally completed.

Noteworthy about this case is that disabling the C ISA extension while not
32-bit aligned is not sufficient to reproduce the bug. Instead this CSR write
must be combined with a load instruction that should be killed by the trap, and
then it must be checked if the destination register of that load changes at a
later time (when the not-properly-killed load finishes).

