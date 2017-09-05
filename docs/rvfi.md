
RISC-V Formal Interface (RVFI)
==============================

RVFI Specification
------------------

In the following specification the term `XLEN` refers to the width of an `x` register in bits, as described in the RISC-V ISA specification. The term `NRET` refers to the maximum number of instructions that the core under test can retire in one cycle. If more than one of the retired instruction writes the same register, the channel with the highest index contains the instruction that wins the conflict. The term `ILEN` refers to the maximum instruction width for the processor under test.

The Interface consists only of output signals. Each signal is a concatenation of `NRET` values of constant width, effectively creating `NRET` channels. For simplicity, the following descriptions refer to one such channel. For example, we refer to `rvfi_valid` as a 1-bit signal, not a `NRET`-bits signal.

    output [NRET        - 1 : 0] rvfi_valid
    output [NRET *   64 - 1 : 0] rvfi_order
    output [NRET * ILEN - 1 : 0] rvfi_insn
    output [NRET        - 1 : 0] rvfi_trap
    output [NRET        - 1 : 0] rvfi_halt
    output [NRET        - 1 : 0] rvfi_intr

When the core retires an instruction, it asserts the `rvfi_valid` signal and uses the signals described below to output the details of the retired instruction. The signals below are only valid during such a cycle and can be driven to arbitrary values in a cycle in which `rvfi_valid` is not asserted.

The `rvfi_order` field must be set to the instruction index. No indices must be used twice and there must be no gaps. Instructions may be retired in a reordered fashion, as long as causality is preserved (register and memory write operations must be retired before the read operations that depend on them).

`rvfi_insn` is the instruction word for the retired instruction. In case of an instruction with fewer than `ILEN` bits, the upper bits of this output must be all zero. For compressed instructions the compressed instruction word must be output on this port. For fused instructions the complete fused instruction sequence must be output.

`rvfi_trap` must be set for an instruction that cannot be decoded as a legal instruction, such as 0x00000000.

In addition, `rvfi_trap` may be set for a misaligned memory read or write. In this case the configuration switch `RISCV_FORMAL_TRAP_ALIGNED_MEM` must be set to enable the same behavior in the riscv-formal insn models. `rvfi_trap` may also be set for a jump instruction that jumps to a misaligned instruction. In this case the configuration switch `RISCV_FORMAL_TRAP_ALIGNED_INSN` must be set to enable the same behavior in the riscv-formal insn models.

The signal `rvfi_halt` must be set when the instruction is the last instruction that the core retires before halting execution. It should not be set for an instruction that triggers a trap condition if the CPU reacts to the trap by executing a trap handler. This signal enables verification of liveness properties.

Finally `rvfi_intr` must be set for the first instruction that is part of a trap handler, i.e. an instruction that has a `rvfi_pc_rdata` that does not match the `rvfi_pc_wdata` of the previous instruction.

    output [NRET *    5 - 1 : 0] rvfi_rs1_addr
    output [NRET *    5 - 1 : 0] rvfi_rs2_addr
    output [NRET * XLEN - 1 : 0] rvfi_rs1_rdata
    output [NRET * XLEN - 1 : 0] rvfi_rs2_rdata

`rvfi_rs1_addr` and `rvfi_rs2_addr` are the decoded `rs1` and `rs1` register addresses for the retired instruction. For an instruction that reads no `rs1`/`rs2` register, this output can have an arbitrary value. However, if this output is nonzero then `rvfi_rs1_rdata` must carry the value stored in that register in the pre-state.

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

For memory operations (`rvfi_mem_rmask` and/or `rvfi_mem_wmask` are non-zero), `rvfi_mem_addr` holds the accessed memory location.

When the define `RISCV_FORMAL_ALIGNED_MEM` is set, the address must have a 4-byte alignment for `XLEN=32` and an 8-byte alignment for `XLEN=64`. When the define is not set, then the address must point directly to the LSB or the word / half word / byte that is accessed.

`rvfi_mem_rmask` is a bitmask that specifies which bytes in `rvfi_mem_rdata` contain valid read data from `rvfi_mem_addr`.

`rvfi_mem_wmask` is a bitmask that specifies which bytes in `rvfi_mem_wdata` contain valid data that is written to `rvfi_mem_addr`.

`rvfi_mem_rdata` is the pre-state data read from `rvfi_mem_addr`. `rvfi_mem_rmask` specifies which bytes are valid.

`rvfi_mem_wdata` is the post-state data written to `rvfi_mem_addr`. `rvfi_mem_wmask` specifies which bytes are valid.

When `RISCV_FORMAL_ALIGNED_MEM` is set then `riscv-formal` assumes that unaligned memory access causes a trap.


RVFI TODOs and Requests for Comments
------------------------------------

The following section contains notes on future extensions to RVFI. They will come part of the spec as soon as there is at least one core that implements the feature, and a matching formal check that utilises the feature. In many cases the additional ports will only be used (and expected from the core) when additional to-be-defined `RISCV_FORMAL_*` Verilog defines are set.

### Support for RV64 ISAs

Models for RV64I-only instructions are still missing. They will be added as soon as a RV64 processor with RVFI support becomes available.

### Support for fused instructions

Fused instructions are simply handled as larger instructions in RVFI. Additional `rvfi_rs*` ports (or even `rvfi_rd*` ports) may be added to accommodate the fused instructions.

No instruction models for fused instructions have been created yet.

Alternatively fused instructions may be output as individual instructions in separate RVFI channels.

### Control and Status Registers (CSRs)

For each supported CSR there will be four additional output ports:

    output [NRET * XLEN - 1 : 0] rvfi_csr_<csrname>_rmask
    output [NRET * XLEN - 1 : 0] rvfi_csr_<csrname>_wmask
    output [NRET * XLEN - 1 : 0] rvfi_csr_<csrname>_rdata
    output [NRET * XLEN - 1 : 0] rvfi_csr_<csrname>_wdata

The `rmask` and `wmask` ports specify which bits of `rdata` and `wdata` are valid.

It is always valid for an instruction to activate more `rmask`/`rdata` bits
than required by the instruction, as long as the reported bits correctly reflect
the machine state.

If reading a CSR has side effects, those side effects are not triggered by raised
`rmask` bits but by the type of the instruction.

### Modelling of Floating-Point State

The following is the proposed RVFI extension for floating point ISAs:

    output [NRET *    5 - 1 : 0] rvfi_frs1_addr
    output [NRET *    5 - 1 : 0] rvfi_frs2_addr
    output [NRET *    5 - 1 : 0] rvfi_frs3_addr
    output [NRET *    5 - 1 : 0] rvfi_frd_addr
    output [NRET        - 1 : 0] rvfi_frs1_rvalid
    output [NRET        - 1 : 0] rvfi_frs2_rvalid
    output [NRET        - 1 : 0] rvfi_frs3_rvalid
    output [NRET        - 1 : 0] rvfi_frd_wvalid
    output [NRET * FLEN - 1 : 0] rvfi_frs1_rdata
    output [NRET * FLEN - 1 : 0] rvfi_frs2_rdata
    output [NRET * FLEN - 1 : 0] rvfi_frs3_rdata
    output [NRET * FLEN - 1 : 0] rvfi_frd_wdata
    output [NRET * XLEN - 1 : 0] rvfi_csr_fcsr_rmask
    output [NRET * XLEN - 1 : 0] rvfi_csr_fcsr_wmask
    output [NRET * XLEN - 1 : 0] rvfi_csr_fcsr_rdata
    output [NRET * XLEN - 1 : 0] rvfi_csr_fcsr_wdata

Since `f0` is not a zero register, additional `*_[rw]valid` signals are required to indicate if `frs1`, `frs2`, `frs3`, and `frd` and their corresponding pre- or post-values are valid.

The FPU model in `riscv-formal` will be swappable (using a Verilog define) with with a pseudo-model that is using cheaper operations instead of proper floating point math. This enables efficient verification of cores that can be configured to support a similar FPU model. (A similar functionality will be provided for M-extension instructions.)

### Modelling of Atomic Memory Operations

AMO instructions (`AMOSWAP.W`, etc.) can be modelled using the existing `rvfi_mem_*` interface by asserting bits in both `rvfi_mem_rmask` and `rvfi_mem_wmask`.

There is also no extension to the RVFI port necessary to accommodate the `LR`, `SC`, `FENCE` and `FENCE.I` instructions.

Verification of this instructions for a single-core systems can be done using the RVFI port only. A strategy must be defined to verify their correct behavior in multicore systems.

