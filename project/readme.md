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

## Approach
A four node cluster using HDFS and map reduce will be used
The python programming language will be used to map and reduce 
data from std as per:

https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

and 

https://hadoop.apache.org/docs/current/hadoop-streaming/HadoopStreaming.html

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
