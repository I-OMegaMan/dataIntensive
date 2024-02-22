#!/bin/bash
#### SSH CONFIG
. "./user.cfg" #get the user config and CLOUDLAB_USER
sshId=~/.ssh/cloudprovider #which SSH identity to use
sshCmd="ssh -i ${sshId} ${CLOUDLAB_USER}@"
workers="./workers.cfg" #worker host names or IP addresses separated by net lines
master="./master.cfg"  #master host name or IP address (one only)
###############


#NAMENODE START
masterNode=$(head -n1 $master)
echo "Starting name node ${masterNode}"
masterSsh=$sshCmd$masterNode
$masterSsh "hdfs --daemon start namenode"

#WORKER START Set up each worker
while IFS= read -r line
do
    workerSSH=$sshCmd$line
    echo "setup for ${line}"
    $workerSSH "hdfs --daemon start datanode"
done < "$workers"
#end of worker setup


