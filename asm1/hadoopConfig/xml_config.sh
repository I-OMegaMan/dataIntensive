#!/bin/bash
HADOOP_CONF_DIR=~/hadoop/config
echo "checking for config dir"
if test -d $HADOOP_CONF_DIR; then
   echo "making config dir"
   mkdir $HADOOP_CONF_DIR
fi
export HADOOP_CONF_DIR=$HADOOP_CONF_DIR
