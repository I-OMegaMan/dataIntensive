#!/usr/bin/env python
"""reducer.py"""
#Original code from
#https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
import sys
import hashlib
import secretMessage as sm
# input comes from STDIN (standard input)

theSecretMessage = bytes.fromhex("c2843aa1e53c8089486cee9d28c42789")
for line in sys.stdin:
    line = line.strip()
    decryptRes = sm.quickDecrypt(bytes.fromhex(line),theSecretMessage)
    try:
        res = decryptRes.decode('ascii')
        print(f"{res}")
    except:
        pass
    
