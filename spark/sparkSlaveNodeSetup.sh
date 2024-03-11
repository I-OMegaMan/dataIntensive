#!/bin/bash
#Script for configuring a node for hadoop and spark

CONFIG_PATH=~/dataIntensive/spark/hadoop-conf
echo "Configuring node as slave."
CONFIG_FILES=$CONFIG_PATH/slave

# update apt
echo "Updating apt..."
sudo apt-get update

# install java and set env
echo "Installing Java8..."
sudo apt-get install openjdk-8-jdk -y
export JAVA_HOME=/usr

#install hadoop
if ! [ -d ~/hadoop-3.2.0 ]; then
	echo "Downloading Hadoop 3.2.0..."
	# hadoop is going to look for /bin/java so only give it the home directory
	wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz -P ~
	tar xvfz ~/hadoop-3.2.0.tar.gz -C ~
fi

#This is also handled during the bash.rc step
export HADOOP_HOME=~/hadoop-3.2.0
HADOOP_CONFIG=$HADOOP_HOME/etc/hadoop

# copy common config files
echo "Copying common config files"
cp $CONFIG_PATH/common/.bashrc ~
chmod +x ~/.bashrc
. ~/.bashrc

#copy all the hadoop xml files.
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


# homework 3: change permissions of /mydata to create the name and data node directories
sudo chmod 777 /mydata
if [ -d /mydata/hadoop ]; then
	rm -R /mydata/hadoop
fi
mkdir -p /mydata/hadoop	# for homework 3, put data in /mydata, which requires root privilege to be created
echo "created /mydata/hadoop"
sudo chmod 777 /mydata/hadoop
