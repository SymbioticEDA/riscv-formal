#!/usr/bin/env python3

times = dict()

for w in ["warm", "cold"]:
    for m in ["parallel", "serial", "single"]:
        runtime = 0
        with open("results_%s.txt" % w) as f:
            for line in f:
                line = line.split()
                if line[2].startswith(m):
                    runtime += float(line[1])
        times["%s_%s" % (w, m)] = runtime

for k, v in sorted(times.items()):
    print("%-20s %8.2f" % (k, v))

