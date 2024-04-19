#!/usr/bin/env python
"""mapper.py"""
#Original code from
#https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
import sys
import hashlib
import io
input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='ISO-8859-15')
#Ravioli Ravioli!
theSecretMessage = bytes.fromhex("d892c6718a7af2cd14a9f6056795279b")


# input comes from STDIN (standard input)
for line in input_stream:
    # remove leading and trailing whitespace
    line = line.strip()
    h = hashlib.new('sha256')
    h.update(line.encode('utf-8'))
    # write the results to STDOUT (standard output);
    # what we output here will be the input for the
    # Reduce step, i.e. the input for reducer.py
    #print("%s\t%s" % (bytes(h.hexdigest()).hex(), 1))
    #decryptRes = sm.quickDecrypt(bytes.fromhex(h.hexdigest()),theSecretMessage)
    print("%s" % h.hexdigest())
