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
    line = line.strip()
    splLine = line.split()
    if(len(splLine) == 3):
        possibleString = bytes.fromhex(splLine[1])
        try:
            res = possibleString.decode('utf-8')
            print(f"{res} 1")
        except:
            pass
