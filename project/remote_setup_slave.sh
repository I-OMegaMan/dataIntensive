#!/bin/bash
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
cd ./dataIntensive/project
chmod +x sparkNodeSetup.sh
./sparkNodeSetup.sh slave
. ~/.bashrc
