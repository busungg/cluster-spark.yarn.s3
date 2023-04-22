#!/usr/bin/env bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# path
export SPARK_HOME=/usr/local/spark
export SPARK_CONF_DIR="${SPARK_HOME}/conf"

# not standalone deploy mode
export HADOOP_CONF_DIR="${HADOOP_HOME}/etc/hadoop"
export YARN_CONF_DIR="${HADOOP_HOME}/etc/hadoop"

# storage directories to use on this node for shuffle and RDD data
# (Options read by executors and drivers running inside the cluster)
export SPARK_LOCAL_DIRS=/apps/tmp/spark/rdd

# driver
export SPARK_DRIVER_MEMORY=2G

# worker (standalone deploy mode)
#export SPARK_WORKER_CORES=2
#export SPARK_WORKER_MEMORY=4G
#export SPARK_WORKER_WEBUI_PORT=8081

# Spark Worker 노드에서 Executor가 사용하는 임시 파일이 저장되는 디렉토리를 설정하는 환경 변수
# Worker 노드는 클러스터에서 Task를 실행하는 데 사용되며, 이때 Executor가 Task를 실행하는 동안 생성하는 임시 파일 (예: 셔플 파일)을 저장하는 임시 디렉토리가 필요합니다. 이때, SPARK_WORKER_DIR은 Worker 노드에서 Executor가 사용하는 임시 파일이 저장될 경로를 지정합니다.
#export SPARK_WORKER_DIR=/home/spark/tmp/work

# excutor
export SPARK_EXECUTOR_CORES=2
export SPARK_EXECUTOR_MEMORY=2G

# (standalone deploy mode)
# spark만 사용 시 설정
#export SPARK_MASTER_HOST=master
#export SPARK_MASTER_PORT=7077
#export SPARK_MASTER_WEBUI_PORT=8080

# (standalone deploy mode)
# spark만 사용 시 설정
export SPARK_LOG_DIR=/apps/log/spark
export SPARK_LOG_MAX_FILES=365
export SPARK_PID_DIR=/apps/tmp/spark/pid

export SPARK_DIST_CLASSPATH="${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/tools/lib/*"