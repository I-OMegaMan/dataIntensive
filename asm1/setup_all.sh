#!/bin/bash
sshCmd="ssh -i ~/.ssh/cloudprovider"
workers="./workers.cfg"
master="./master.cfg"
configScript="./setup_master.sh"

masterNode=$(head -n1 $master)
echo "Setting up master $masterNode"
cat $configScript | $sshCmd $masterNode

while IFS= read -r line
do
    echo "setup for $line"
    cat $configScript | $sshCmd $line
done < "$workers"
#~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
#export JAVA_HOME=/usr
#export HADOOP_HOME=~/hadoop-3.3.6

 
