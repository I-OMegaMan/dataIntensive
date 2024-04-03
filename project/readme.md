# project
This project is designed to test various cyber security concepts using
a database of cracked passwords called rockyou 2021.
see:

https://github.com/ohmybahgosh/RockYou2021.txt

The database is a large set of previously real user passwords and
generated probable passwords. If you the reader look through the
database, there is a high chance you will see one of your own
passwords in the database.


# Approach

A four node cluster using HDFS and map reduce will be used.
The python programming language will be used to map and reduce 
data from std as per:

https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

# Experimental Setup

## Hadoop/Spark Configuration
The Hadoop/Spark setup used for this experiment will be based off the
../spark configuration of this git repository. A copy was made in this
directory to preserve the working code for assignment 3.







https://nyu-cds.github.io/python-bigdata/03-spark/
https://spark.apache.org/docs/latest/api/python/index.html
https://whiteboxml.com/blog/hadoop-with-python-i-pyspark
https://spark.apache.org/docs/latest/api/python/getting_started/quickstart_connect.html

