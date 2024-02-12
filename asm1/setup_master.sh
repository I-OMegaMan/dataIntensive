#!/bin/bash
HADOOP_ROOT=~/hadoop
HADOOP_BIN_URL=https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
HADOOP_JAVA_PACKAGE=openjdk-8-jdk
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
cd ./dataIntensive/asm1

sudo apt update
sudo apt-get install $HADOOP_JAVA_PACKAGE -y

if test ! -d $HADOOP_ROOT; then
   mkdir $HADOOP_ROOT
fi

cd $HADOOP_ROOT
if test ! -d ./hadoop-3.3.6; then
   wget $HADOOP_BIN_URL
   tar xvfz hadoop-3.3.6.tar.gz
fi
echo "THE HADOOP IS READY"

