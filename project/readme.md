# Authors

Matt Myers

Roarke Myers

4/24/2024

## Hadoop Distributed Dictionary Attack: Overview
This project performs a distributed dictionary attack on an AES256
encrypted message using the Hadoop Filesystem and MapReduce
framework. Different configurations are used to test how fast the
setup can crack the secret message.

The database used for the dictionary attack is a large set of
previously hacked/leaked real user passwords called rockyou.txt
(https://github.com/praetorian-inc/Hob0Rules/blob/master/wordlists/rockyou.txt.gz). The
database is commonly used for password strength testing and pen-testing.

## Objective
Create a MapReduce job which reads cracked passwords from a text
database and produces an output list of possible ASCII encoded text
within an AES256 encrypted block. The map reduce job will be run in a
variety of situations to experiment with performance.

## About AES256 and SHA256
AES256 is a symmetric encryption algorithm meaning it relies on a
single secret key known by both the sender and receiver. SHA256 is a
fast hashing algorithm that is widely used and considered (at the time
of this writing, 2024) to be secure, meaning there are no mathematical
means to reverse the hash. SHA256 produces a 32 byte hash which makes
it perfect for generating 32 byte AES256 secret keys.

## About Hadoop and MapReduce
Hadoop is an Apache foundation implementation of the MapReduce
algorithm (originally by Google) paired with a distributed filesystem
called HDFS (Hadoop Filesystem).  Hadoop allows for consumer grade
computers to be joined together to form a powerful and robust
distributed computing platform. Hadoop is written in the Java
programming language but provides API and interfaces for virtually any
language.

A streaming API is included in Hadoop which allows data being
processed to be read and written from stdin. This results in a simple
interface which is very similar to piping commands in bash or
powershell.

## Assumptions and Scenario
A secret message "c2843aa1e53c8089486cee9d28c42789" was intercepted
from a person of interest. Recon on the target produced a number of
assumptions that can be made about this secret message:

1. The message contains ASCII text.
2. The AES initialization vector is zero.
3. AES key selected for this encryption is based on the SHA256 of a string in the rockyou password database.
4. The data is within a single AES256 16 byte block.

The listed items above allow the problem space of brute forcing a
AES256 key to be dramatically reduced, and in practice are realistic,
though incredibly sloppy.

## Mapper and Reducer Scripts
A mapper and reducer python script were written to use the Hadoop
streaming interface. Hadoop feeds each password string from
rockyou.txt to the mapper script which performs the SHA256 and prints
the result. Hadoop feeds the resulting 32 byte key string to the
reducer script which uses the key string to attempt to crack the 16
byte encrypted message. Since the string is known to be ascii encoded,
an ascii decode is attempted on the decrypted string. Any successful
ascii decode result is printed as a result. The output buffer is small
enough that a human can visually inspect the decoded data to see if
any message is human readable.

## Cluster Configuration
The experiment was run in the following configurations:
1. Single PC: A single computer running python and piping the mapper.py output to the reducer.py script.
2. 2 Node cluster: A Hadoop Namenode with one datanode.
3. 4 Node cluster: A Hadoop Namenode with three datanodes.
4. 4 Nodes with Varying reducer threads: Increasing the number of
   reducer threads.

The cloud provider, cloudlab, is used for this experiment.
(https://www.cloudlab.us/).

# Setup Instructions
## Hardware Requirements
1. Ubuntu 22.04 with root access.
2. A drive of at-least 100GB, mounted to the root directory at /mydata.
3. Each node in the cluster must share an ssh key with one another.
   This means each node can access the other node.
4. Python 3.10+ Installed on each machine.
5. Full internet access and access to ubuntu repositories.
6. For ease of implementation set the hostname of the master node
   (namenode) to node0 and the workers to node1, node2, and node3
   respectively.
7. Git installed on all hardware.

## Setup Procedure
To avoid errors, follow the procedure in the exact order as shown:
1. For each worker node, ssh into the node and copy and paste
   the contents of ./remote_setup_slave.sh.
2. For the namenode, ssh into the node and copy and paste the contents of
   ./remote_setup_master.sh

## Verification of Setup
1. ssh into the namenode (node0) and type $HADOOP_HOME/sbin/stop-all.sh
2. Ensure the command runs and all namenodes are stopped.
3. type $HADOOP_HOME/sbin/start-dfs.sh, ensure hdfs starts without errors.
4. type $HADOOP_HOME/sbin/start-yarn.sh, ensure yarn starts without errors.
5. type $HADOOP_HOME/bin/hadoop fs -ls / ensure /rockyou.txt exists on hdfs.

Note: A common issue is that rockyou.txt did not get copied to hdfs in the setup script.
If this occurs copy rockyou.txt to hdfs using $HADOOP_HOME/bin/hadoop fs -copyFromLocal /mydata/rockyou/rockyou.txt /
Any other issues can be debugged using the logs located in $HADOOP_HOME/logs.

## Executing the Experiment
### Single CPU Run
1. On your local machine download rockyou.txt to ./rockyou/
2. Call time ./python/testMapper.sh.
3. Allow execution to finish. Record the resulting time.
### Two node cluster.
1. ssh into the cluster namenode (node0).
2. open $HADOOP_HOME/etc/workers in your editor of choice.
3. Ensure only node1 appears $HADOOP_HOME/etc/workers
4. Save and close $HADOOP_HOME/etc/workers.
5. Follow the Verification of Setup procedure above and ensure no errors occur.
6. Start the MapReduce job by calling ./project_run.sh. NOTE: if desired, edit -D mapred.reduce.tasks=N to set the number of reducer tasks.
6. When the MapReduce job completes, copy the console output to a file on your local machine.
7. Copy the results from HDFS to the namenode drive using the command:
   $HADOOP_HOME/bin/hadoop fs -copyFromLocal /rockout/*
8. Examine or copy the results from the namenode.
### Four or N node cluster.
1. Follow the steps above with the exception of adding each datanode host name to $HADOOP_HOME/etc/workers (steps 3-4).

# Results

| Configuration                   | Time to Complete |
|---------------------------------|------------------|
| Single computer (no hadoop)     | 30+ Minutes      |
| 2 Node cluster                  | 27m 1s           |
| 4 Node cluster with hadoop      | 20m 38s          |
| 4 Node cluster with hadoop T=12 | 2m 31s           |
| 4 Node cluster with hadoop T=24 | 1m 47s           |
| 4 Node cluster with hadoop T=48 | 1m 57s           |

Note: T denotes the number of reducer threads used.

# Discussion of Results
The dictionary attack script completed successfully in each
configuration. When using more than one thread, the results appear in
a number of part-N files where N denotes the number of threads used in
the streaming command. The secret message "Ravioli Ravioli!" was found
in the results of each run.

A dramatic increase in completion speed can be seen as
the number of nodes used increases along with the number of reducer
threads used. Diminishing returns are observed once the number of
reducer threads is increased beyond 12. This is likely due to the
number of threads increasing beyond the number of cores, eventually
resulting in an increase in time in the case of T=48.

# Future Work and Improvements
Python is a convenient language but is notoriously slow. The scripts
could be optimized by using a generator instead of the "for line in
stdin". The mapper and reducer could also be written in optimized C or
a compiled language to see if additional speed increases could be
achieved.

# References and Helpful Links
Description of the Hadoop streaming interface:

https://hadoop.apache.org/docs/current/hadoop-streaming/HadoopStreaming.html

Using python with the hadoop streaming interface:

https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

Original Rockyou.txt dictionary:

https://github.com/praetorian-inc/Hob0Rules/blob/master/wordlists/rockyou.txt.gz

100GB version of rockyou.txt:

https://github.com/ohmybahgosh/RockYou2021.txt

Link to the original github:

https://github.com/I-OMegaMan/dataIntensive/tree/main/project


# Python Libraries used:
cryptography, for AES256 encryption:
https://cryptography.io/en/latest/

