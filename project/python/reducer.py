#!/usr/bin/env python
"""reducer.py"""
#Original code from
#https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
import sys
import hashlib

# input comes from STDIN (standard input)
# 
for line in sys.stdin:
    # TBD Skeleton code
    # remove leading and trailing whitespace
#    line = line.strip()
#    h = hashlib.new('sha256')
#    h.update(line)
    # write the results to STDOUT (standard output);
    # what we output here will be the input for the
    # Reduce step, i.e. the input for reducer.py
    #
    # tab-delimited; the trivial word count is 1
#    print("%s\t%s" % (h.hexdigest(), 1))

