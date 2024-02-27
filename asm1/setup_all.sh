#!/bin/bash
#setup_all.sh
#Used to do the initial setup of hadoop on a newly created
#cloudlab cluster

#USERNAME CONFIGURATION
#Make sure you create user.cfg and have it define
#CLOUDLAB_USER=your user name
#user.cfg is separate so you don't end up with your username
#on the public github
. "./user.cfg" #get the user config and CLOUDLAB_USER

#SSH CONFIGURATION
#which SSH identity to use This is the path to the
#public key you gave cloudlab. If this key is not set up
#and associated with your cloud lab user ssh will
#give you error messages.
sshId=~/.ssh/cloudprovider 
sshCmd="ssh -i ${sshId} ${CLOUDLAB_USER}@"
scpCmd="scp -i ${sshId} ${CLOUDLAB_USER}@"

#WORKER AND MASTER CONFIG
#Create workers.cfg and master.cfg
#in the directory of this script
#Again, this is done because you don't want these addresses
#to appear in the public git repo
#worker host names or PUBLIC IP addresses separated by new lines
workers="./workers.cfg"
#master host name or PUBLIC IP address (one only)
master="./master.cfg"

xmlConfigScript="./hadoopConfig/xml_config.sh"
#This script is used to
#1. Download and install Java
#2. Download and install Hadoop
#3. Clone this git repo onto the machine
configScript="./setup_master.sh"
configRemoteMaster="./remote_setup_master.sh"
configRemoteSlave="./remote_setup_slave.sh"
#remote directory locations
#Config files need to be copied to this location
#Note ~ resolves to THIS SHELL's home not the remote one so don't use it
remoteHadoopDir=/users/$CLOUDLAB_USER/hadoop/hadoop-3.3.6
hadoopEtc=$remoteHadoopDir/etc/hadoop/
#end of remote directory locations

#NAMENODE CONFIG set up the master node aka name node
masterNode=$(head -n1 $master)
echo "Setting up master $masterNode"
masterSsh=$sshCmd$masterNode
cat $configRemoteMaster | $masterSsh

#WORKER CONFIG Set up each worker
while IFS= read -r line
do
    workerSSH=$sshCmd$line
    echo "setup for ${line}"
    cat $configRemoteSlave | $workerSSH
done < "$workers"
#end of worker setup
 
