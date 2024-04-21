# Authors

Matt Myers

Roarke Myers

# Introduction
## Hadoop AES Dictionary Attack
This project is designed to test various cyber-security concepts using
a database of cracked passwords called rockyou.
see:
https://github.com/praetorian-inc/Hob0Rules/blob/master/wordlists/rockyou.txt.gz

The database is a large set of previously hacked/leaked real user passwords and
generated probable passwords. If you, the reader, look through the
database, there is a high chance you will see one of your own
passwords in the database. Note: This project originally used the
larger rockyou2021 dataset
(https://github.com/ohmybahgosh/RockYou2021.txt) but the original
smaller rockyou.txt was used instead since it proved easier to load
onto the test cluster and produces the same result as a larger
dataset.

## Objective
Create a map reduce job which reads cracked passwords from a text
database and produces an output list of possible ascii encoded text
within an aes256 encrypted block. The map reduce job will be run in a
variety of situations to experiment with performance.

## Assumptions and Scenario
A secret message was intercepted from a person of interest. Recon on
the target person produced number of assumptions can be made about
this secret message:

1. The message contains ascii text.
2. The AES initialization vector is zero (A VERY common security flaw).
3. AES key selected for this encryption is based on the sha256 of a string in the rockyou password database.
4. The data is within a single AES256 16 byte block.

In practice this scenario is somewhat realistic since AES256 keys are
often the sha256 of some string known by the programmer. Though is
would be considered incredibly sloppy it is still common practice.

## About AES256 and SHA256
AES256 is a symmetric encryption algorithm meaning it relies on a
single secret key known by both the sender and receiver. SHA256 is a
fast hashing algorithm that is widely used and considered (at the time
of this writing, 2024) to be secure. The output of a SHA256 hash is 32
bytes, which makes it perfect for generating 32 byte AES256 secret
keys.

## About Hadoop and Mapreduce
Hadoop is an Apache foundation implementation of the map reduce
algorithm (orginally by Google) paired with a distributed file system
called HDFS (Hadoop Filesystem).  Hadoop allows for consumer grade
computers to be joined together to form a powerful and robust
distributed computing platform. Hadoop is written in the Java
programming language but provides API and interfaces for virtually any
language.

A streaming API is included in Hadoop which allows data being
processed to be read and written from stdin. This results in a simple
interface which is very similar to piping commands in bash or
powershell.

# High Level Approach
A mapper and reducer python script were written to use the Hadoop
streaming interface. Hadoop feeds each password string from
rockyou.txt to the mapper script takes the SHA256 of each password in
the rockyou.txt and outputs the 32 byte result as a string into the
reducer script. The reducer script takes the 32 byte SHA256 and
attempts to crack the 16 byte encrypted message. Since the string is
known to be ascii encoded, an ascii decode is attempted on the
decrytped string. Any successful ascii decode result is printed as a
result. The output buffer is small enough that a human can visually
inspect the decoded data to see if any message is human readable.

## Cluster Configuration
The following configurations are used for this experiment:
1. Single computer without hadoop
2. 2 Node cluster with hadoop.
3. 4 Node cluster with hadoop.
4. 4 Node cluster with hadoop and different reducer thread sizes.
https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
https://hadoop.apache.org/docs/current/hadoop-streaming/HadoopStreaming.html

# Setup Instructions
## Hardware Requirements
1. Ubuntu 22.04 with root access.
2. A drive of at-least 100Gb, mounted to the root directory at /mydata.
3. Each node in the cluster must share an ssh key with one another.
   This means each node can access the other node.
4. Python 3.10+ Installed.
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



## Experimental Setup
## Hadoop/Spark Configuration
The Hadoop/Spark setup used for this experiment will be based off the
../spark configuration of this git repository. A copy was made in this
directory to preserve the working code for assignment 3.

## HDFS and Map Reduce Job
The text data from rockyou will be uploaded onto HDFS. From here, a
python map script will be used to first process the text into
sha256. Next, a reduce script will take the hash and attempt to crack
the string. The reduce script will detect ascii encoding and if found, 
will print the hash and the string.

# Evaluation Methodology
The time to crack the 16 byte AES block will be a figure of merit for this experiment.
This time will be measured by gauging how long it takes to complete the map reduce job.


# Problems
Originally the setup was going to use a Map only hadoop job but we
decided to break the project into a mapping sha256 task and a reducing
aes crack task.




# References and Helpful Links
https://hadoop.apache.org/docs/current/hadoop-streaming/HadoopStreaming.html

https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

https://nyu-cds.github.io/python-bigdata/03-spark/

https://spark.apache.org/docs/latest/api/python/index.html

https://whiteboxml.com/blog/hadoop-with-python-i-pyspark

https://spark.apache.org/docs/latest/api/python/getting_started/quickstart_connect.html

https://github.com/ohmybahgosh/RockYou2021.txt

https://hadoop.apache.org/docs/r1.2.1/streaming.html
# Python Libraries used
https://cryptography.io/en/latest/
pip install cryptography
