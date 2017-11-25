
riscv-formal proofs for VexRiscv
================================

### Current state:
Test a simple VexRiscv configuration (https://github.com/SpinalHDL/VexRiscv/blob/formal/src/main/scala/vexriscv/demo/FormalSimple.scala)

All standards checks are passing
- Instruction Checks
- PC Checks
- Register Checks
- Causality
- Liveness

Other tests passing :
- Instruction Memory check

### Quickstart guide:

First install Yosys, SymbiYosys, and the solvers. See [here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for instructions.

To run all checks:

```
python3 ../../checks/genchecks.py
make -C checks -j$(nproc)
```

To run again a single check which had failed:

```
#A single time
python3 ../../checks/genchecks.py

#Each time
export test=insn_beq_ch0; rm -r checks/$test; make -C checks -j$(nproc) $test/PASS; python3 disasm.py checks/$test/engine_0/trace.vcd
```


Running the instruction memory check : 

```
sby -f imemcheck.sby
```

### Todo:
- Integrate others VexRiscv configurations into the framework
- Add Data Memcheck check
- Add Checking for equivalence of core with and without RVFI check
- Add Complete check
- Add Cover check




