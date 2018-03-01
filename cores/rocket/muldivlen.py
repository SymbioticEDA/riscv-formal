#!/usr/bin/env python3

import os
from Verilog_VCD.Verilog_VCD import parse_vcd

lines = list()

for i in range(100):
    fn = None
    in1 = None
    in2 = None
    vcd = "muldivlen_cover/engine_0/trace%d.vcd" % i
    if not os.path.isfile(vcd):
        break
    for netinfo in parse_vcd(vcd).values():
        for net in netinfo['nets']:
            if net["hier"] != "muldivlen":
                continue
            if net["name"] == "io_req_bits_fn":
                fn = netinfo['tv'][0][1]
            if net["name"] == "io_req_bits_in1":
                in1 = netinfo['tv'][0][1]
            if net["name"] == "io_req_bits_in2":
                in2 = netinfo['tv'][0][1]
    lines.append("%s %s %s" % (fn, in1, in2))

assert(len(lines) == 24)

for line in sorted(lines):
    print(line)

