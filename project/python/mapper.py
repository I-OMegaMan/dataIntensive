#!/usr/bin/env python
"""mapper.py"""
#Original code from
#https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
import sys
import hashlib
import io
#Handles input encoding
input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='ISO-8859-15')

# input comes from STDIN (standard input)
for line in input_stream:
    # remove leading and trailing whitespace
    line = line.strip()
    h = hashlib.new('sha256')
    h.update(line.encode('utf-8'))
    # write the results to STDOUT (standard output);
    # what we output here will be the input for the
    # Reduce step, i.e. the input for reducer.py
    print("%s" % h.hexdigest())
