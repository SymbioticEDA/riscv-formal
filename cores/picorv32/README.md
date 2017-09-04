
riscv-formal proofs for picorv32
================================

Quickstart guide:

First install Yosys, SymbiYosys, and the solvers. See
[here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for instructions.  Then download the core, generate the formal checks and run them:

```
wget -O picorv32.v https://raw.githubusercontent.com/cliffordwolf/picorv32/master/picorv32.v
python3 ../../checks/genchecks.py
make -C checks -j$(nproc)
```

