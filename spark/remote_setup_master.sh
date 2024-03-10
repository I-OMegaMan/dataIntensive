#!/bin/bash
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
cd ./dataIntensive/asm1
chmod +x nodeSetup.sh
./nodeSetup.sh master
. ~/.bashrc
