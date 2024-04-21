#!/bin/bash
cat ../rockyou/rockyou.txt | python ./mapper.py | python ./reducer.py
