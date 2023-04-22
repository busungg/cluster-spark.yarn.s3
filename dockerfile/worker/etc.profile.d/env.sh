#!/bin/bash

if [ -z "$JAVA_HOME" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.362.b09-2.el8_7.x86_64
  export PATH="$PATH:$JAVA_HOME:$JAVA_HOME/bin"
fi

if [ -z "$HADOOP_HOME" ]; then
  export HADOOP_HOME=/usr/local/hadoop
  export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin"
fi

if [ -z "$SPARK_HOME" ]; then
  export SPARK_HOME=/usr/local/spark
  export PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
fi