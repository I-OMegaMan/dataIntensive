#!/bin/bash
sshCmd="ssh -i ~/.ssh/cloudprovider"
input="./cluster.cfg"
masterSetup="./setup_master.sh"
echo "beginning"
while IFS= read -r line
do
    echo "setup for $line"
    cat $masterSetup | $sshCmd $line
done < "$input"
#~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
#export JAVA_HOME=/usr
#export HADOOP_HOME=~/hadoop-3.3.6

 
