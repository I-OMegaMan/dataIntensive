#!/bin/bash
. "./user.cfg" #get the user config and CLOUDLAB_USER
sshCmd="ssh -i ~/.ssh/cloudprovider ${CLOUDLAB_USER}@"
workers="./workers.cfg" #worker host names or IP addresses separated by net lines
master="./master.cfg"  #master host name or IP address (one only)

configScript="./setup_master.sh"
format_master="./format_master.sh"

masterNode=$(head -n1 $master)
echo "Setting up master $masterNode"
masterSsh=$sshCmd$masterNode
cat $configScript | $masterSsh
cat $format_master | $masterSsh

while IFS= read -r line
do
    workerSSH=$sshCmd$line
    echo "setup for $line"
    cat $configScript | $workerSSH
done < "$workers"
#~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
#export JAVA_HOME=/usr
#export HADOOP_HOME=~/hadoop-3.3.6

 
