$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.0.jar \
                        -D mapred.reduce.tasks=48 \
                        -mapper ~/dataIntensive/project/python/mapper.py \
                        -reducer ~/dataIntensive/project/python/reducer.py \
                        -input /rockyou.txt \
                        -output /rockout
