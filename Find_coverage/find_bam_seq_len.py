#!/usr/bin/env python3

import sys
file=sys.argv[1]
with open (file) as f:
    file = f.read()

each_seq = file.split("\n")[:-1]

seq_len = len(each_seq[0])

print(seq_len)