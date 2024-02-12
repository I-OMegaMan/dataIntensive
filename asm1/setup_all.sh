#!/bin/bash
. "./user.cfg" #get the user config and CLOUDLAB_USER
sshId=~/.ssh/cloudprovider #which SSH identity to use
sshCmd="ssh -i ${sshId} ${CLOUDLAB_USER}@"
workers="./workers.cfg" #worker host names or IP addresses separated by net lines
master="./master.cfg"  #master host name or IP address (one only)

xmlConfigScript="./hadoopConfig/xml_config.sh"
configScript="./setup_master.sh"
format_master="./format_master.sh"

masterNode=$(head -n1 $master)
echo "Setting up master $masterNode"
masterSsh=$sshCmd$masterNode
cat $configScript | $masterSsh
cat $format_master | $masterSsh
echo "xml config setup for master $master"
cat $xmlConfigScript | $masterSsh
scp -i $sshId ./hadoopConfig/*.xml ${CLOUDLAB_USER}@$masterNode:~/hadoop/config/
echo "setting up salves file"
scp -i $sshId ./workers.cfg ${CLOUDLAB_USER}@$masterNode:~/hadoop/config/slaves

while IFS= read -r line
do
    workerSSH=$sshCmd$line
    echo "setup for ${line}"
    cat $configScript | $workerSSH
    echo "xml config setup for ${line}"
    cat $xmlConfigScript | $workerSSH
    scp -i $sshId ./hadoopConfig/*.xml ${CLOUDLAB_USER}@$line:~/hadoop/config/
    
done < "$workers"
#~/hw1/hadoop-3.3.6
#hadoop is going to look for /bin/java so only give it the home directory
#export JAVA_HOME=/usr
#export HADOOP_HOME=~/hadoop-3.3.6

 
