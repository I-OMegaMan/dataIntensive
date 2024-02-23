#!/bin/bash
CONFIG_PATH=~/dataIntensive/asm1/hadoop-conf
if [ "$#" -eq 1 ]; then
	# select master or slave directory
	if [ "$1" = "master" ]; then
		echo "Configuring node as master."
		CONFIG_FILES=$CONFIG_PATH/master
		
	elif [ "$1" = "slave" ]; then
		echo "Configuring node as slave."
		CONFIG_FILES=$CONFIG_PATH/slave
	else 
		echo "Error: must provide \"master\" or \"slave\" as an argument."
		exit
	fi
else
	echo "Usage: $0 (master | slave)"
	exit
fi

# update apt
echo "Updating apt..."
sudo apt-get update

# install java and set env
echo "Installing Java..."
sudo apt-get install openjdk-8-jdk -y
export JAVA_HOME=/usr

if ! [ -d ~/hadoop-3.3.6 ]; then
	echo "Downloading Hadoop 3.3.6..."
	# hadoop is going to look for /bin/java so only give it the home directory
	wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz -P ~
	tar xvfz ~/hadoop-3.3.6.tar.gz -C ~
fi

export HADOOP_HOME=~/hadoop-3.3.6

HADOOP_CONFIG=$HADOOP_HOME/etc/hadoop

# copy common config files
echo "Copying common config files"
cp $CONFIG_PATH/common/.bashrc ~
chmod +x ~/.bashrc
. ~/.bashrc
for filename in $CONFIG_PATH/common/*; do
	echo "Copying $filename"
	if [ "$filename" != ".bashrc" ]; then
		cp $filename $HADOOP_CONFIG
	fi
done

# copy config files (master or slave)
echo "Copying $1 config files"
for filename in $CONFIG_FILES/*; do
	echo "Copying $filename"
	cp $filename $HADOOP_CONFIG
done

# homework 2: change permissions of /mydata to create the name and data node directories
sudo chmod 777 /mydata

# master and slave specific setup
echo "Doing $1-specific setup"
if [ "$1" = "master" ]; then
	if ! [ -d $HADOOP_HOME/hadoop-dir/namenode-dir ]; then
		sudo mkdir -p /mydata/namenode-dir	# for homework 2, put data in /mydata, which requires root privilege to be created
		echo "created namenode-dir"
	fi
	# format hdfs
	
	cd ~
	# NOTE: the current directory at the time of running this is where hadoop will look for hadoop-dir/namenode-dir, hence the "cd ~"
	$HADOOP_HOME/bin/hdfs namenode -format
	
elif [ "$1" = "slave" ]; then
	if ! [ -d $HADOOP_HOME/hadoop-dir/datanode-dir ]; then
		sudo mkdir -p /mydata/datanode-dir	# for homework 2, put data in /mydata, which requires root privilege to be created
		echo "created datanode-dir"
	fi
	
fi






