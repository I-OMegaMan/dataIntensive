#!/bin/bash
key="ssh -i ~/.ssh/cloudprovider"
input="./cluster.cfg"
echo "beginning"
while IFS= read -r line
do
  $key $line << EOF
cd ~
git clone https://github.com/I-OMegaMan/dataIntensive.git
cd ./dataIntensive/asm1
sudo apt update
sudo apt-get install openjdk-8-jdk -y

if [! -d ~/hadoop ]; then
   mkdir ~/hadoop
fi

cd ~/hadoop
if [! -d ./hadoop-3.3.6 ]; then
   wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
   tar xvfz hadoop-3.3.6.tar.gz
fi
echo "THE HADOOP IS READY"
EOF
#~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
#export JAVA_HOME=/usr
#export HADOOP_HOME=~/hadoop-3.3.6
done < "$input"
