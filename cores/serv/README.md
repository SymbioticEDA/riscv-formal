riscv-formal proofs for SErial RiscV (SERV)
===========================================

Quickstart guide:

First install Yosys, SymbiYosys, and the solvers. See
[here](http://symbiyosys.readthedocs.io/en/latest/quickstart.html#installing)
for instructions. Then build the version of SERV with RVFI support and
rsicv-tools, and generate the formal checks:

```
bash generate.sh
```

Then run the formal checks:

```
make -C checks -j$(nproc)
bash cexdata.sh
```
