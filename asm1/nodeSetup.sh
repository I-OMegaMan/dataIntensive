#!/bin/bash
git clone git@github.com:I-OMegaMan/dataIntensive.git
cd ~
cd ./dataIntensive/asm1
sudo apt-get install openjdk-8-jdk -y
mkdir ~/hw1/
cd ~/hw1/
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
tar xvfz hadoop-3.3.6.tar.gz
~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
export JAVA_HOME=/usr
export HADOOP_HOME=~/hadoop-3.3.6
