RISC-V Formal CSR Sematics
==========================

For the most part the CSR values output via RVFI match exactly the CSR values
observable via the ISA. But there are a few minor differences that are outlined
here.

Most importantly, for RV64 processors in RV32 mode, the values output via
RVFI are still following RV64 CSR encondings, including some of the information
that is not available through the RV32 ISA, such as SXL and UXL in `mstatus`.

Counters are always output as singe 64-bit wide CSRs even on RV32 targets.

M-mode CSRs
-----------

### Machine Information Registers

#### mvendorid, marchid, mimpid, mhartid

Nothing special for these CSRs.

### Machine Trap Setup

#### mstatus, misa

Nothing special for these CSRs. (Reminder: RV64 processors in RV32 mode are
expected to output the RV64 format.)

#### medeleg, mideleg, mie, mtvec

Nothing special for these CSRs.

#### mcounteren

Currently only the `IR` and `CY` bits of `mcounteren` are supported by
riscv-formal. The other bits are ignored.

### Machine Trap Handling

#### mscratch

Nothing special for this CSR.

#### mepc

The version of `mepc` observable through the ISA masks `mepc[1]` on CSR reads
when the processor is in a mode that does not supprt 16-bit instruction
alignment.  However, writes to that bit shall still modify the underlying
architectural state.

In riscv-formal semantics the `mepc` value output via RVFI must be the actual
architectural state with `mepc[1]` not masked.

#### mcause, mtval, mip

Nothing special for these CSRs.

### Machine Protection and Translation

TBD

### Machine Counter/Timers

#### mcycle, minstret

Always 64-bit wide, even on pure RV32 processors (no mcycleh/minstreth).

Incrementing those counters should happen "between instructions", this means
for example that an instruction that isn't a CSR write to `mcycle` should
always have `rvfi_csr_mcycle_rdata == rvfi_csr_mcycle_wdata`.

#### mhpmcounter<N>, mhpmevent<N>

Machine performance-monitoring counters are currently not supported by riscv-formal.

Debug-Mode CSRs
---------------

TBD

U-Mode CSRs
-----------

TBD

S-Mode CSRs
-----------

TBD
