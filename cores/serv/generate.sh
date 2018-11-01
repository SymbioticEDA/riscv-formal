#!/bin/bash
set -ex
rm -rf serv-src
git clone git@github.com:olofk/serv.git serv-src
sed -i -e '/define RISCV_FORMAL/ d;' serv-src/rtl/serv_top.v
python3 ../../checks/genchecks.py
