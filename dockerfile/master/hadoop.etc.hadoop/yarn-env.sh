#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

###
# Resource Manager specific parameters
###


# Specify the JVM options to be used when starting the ResourceManager.
# These options will be appended to the options specified as HADOOP_OPTS
# and therefore may override any similar flags set in HADOOP_OPTS
#
# Examples for a Sun/Oracle JDK:
# a) override the appsummary log file:
# export YARN_RESOURCEMANAGER_OPTS="-Dyarn.server.resourcemanager.appsummary.log.file=rm-appsummary.log -Dyarn.server.resourcemanager.appsummary.logger=INFO,RMSUMMARY"
#
# b) Set JMX options
# export YARN_RESOURCEMANAGER_OPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=1026"
#
# c) Set garbage collection logs from hadoop-env.sh
# export YARN_RESOURCE_MANAGER_OPTS="${HADOOP_GC_SETTINGS} -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"
#
# d) ... or set them directly
# export YARN_RESOURCEMANAGER_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -Xloggc:${HADOOP_LOG_DIR}/gc-rm.log-$(date +'%Y%m%d%H%M')"
#
# e) Enable ResourceManager audit logging
export YARN_RESOURCEMANAGER_OPTS="-Drm.audit.logger=INFO,RMAUDIT"

###
# Node Manager specific parameters
###

# Specify the JVM options to be used when starting the NodeManager.
# These options will be appended to the options specified as HADOOP_OPTS
# and therefore may override any similar flags set in HADOOP_OPTS
#
# a) Enable NodeManager audit logging
export YARN_NODEMANAGER_OPTS="-Dnm.audit.logger=INFO,NMAUDIT"