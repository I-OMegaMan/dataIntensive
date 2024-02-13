#!/bin/bash
. "./user.cfg" #get the user config and CLOUDLAB_USER
sshId=~/.ssh/cloudprovider #which SSH identity to use
sshCmd="ssh -i ${sshId} ${CLOUDLAB_USER}@"
workers="./workers.cfg" #worker host names or IP addresses separated by net lines
master="./master.cfg"  #master host name or IP address (one only)

xmlConfigScript="./hadoopConfig/xml_config.sh"
configScript="./setup_master.sh"
format_master="./format_master.sh"

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
cat $configScript | $masterSsh
cat $format_master | $masterSsh
echo "xml config setup for master $master"
cat $xmlConfigScript | $masterSsh
#copy the config files to the hadoop etc folder
scp -i $sshId ./hadoopConfig/*.xml ${CLOUDLAB_USER}@$masterNode:$hadoopEtc
echo "setting up salves file"
scp -i $sshId ./workers.cfg ${CLOUDLAB_USER}@$masterNode:$hadoopEtc/workers
#End of master config


#WORKER CONFIG Set up each worker
while IFS= read -r line
do
    workerSSH=$sshCmd$line
    echo "setup for ${line}"
    cat $configScript | $workerSSH
    echo "xml config setup for ${line}"
    cat $xmlConfigScript | $workerSSH
    scp -i $sshId ./hadoopConfig/*.xml ${CLOUDLAB_USER}@$line:$hadoopEtc
done < "$workers"
#end of worker setup
 
