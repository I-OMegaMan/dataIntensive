#!/bin/bash
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
git checkout matt_asm3
cd ./dataIntensive/spark
chmod +x sparkNodeSetup.sh
./sparkNodeSetup.sh master
