#!/bin/bash
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
cd ./dataIntensive/asm1
sudo apt update
sudo apt-get install openjdk-8-jdk -y

if test ! -d ~/hadoop; then
   mkdir ~/hadoop
fi

cd ~/hadoop
if test ! -d ./hadoop-3.3.6; then
   wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
   tar xvfz hadoop-3.3.6.tar.gz
fi
echo "THE HADOOP IS READY"

