#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



###
# Generic settings for HADOOP
###
export HADOOP_TMP_HOME=/apps/tmp
export HADOOP_LOG_HOME=/apps/log

# Location of Hadoop's configuration information.  i.e., where this
# file is living. If this is not defined, Hadoop will attempt to
# locate it based upon its execution path.
export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop


# Extra Java runtime options for all Hadoop commands. We don't support
# IPv6 yet/still, so by default the preference is set to IPv4.
export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true"

# Some parts of the shell code may do special things dependent upon
# the operating system.  We have to set this here. See the next
# section as to why....
export HADOOP_OS_TYPE=${HADOOP_OS_TYPE:-$(uname -s)}

# Enable optional, bundled Hadoop features
# This is a comma delimited list.  It may NOT be overridden via .hadooprc
# Entries may be added/removed as needed.
export HADOOP_OPTIONAL_TOOLS="hadoop-kafka,hadoop-aliyun,hadoop-azure,hadoop-azure-datalake,hadoop-aws"

###
# Options for remote shell connectivity
###

# There are some optional components of hadoop that allow for
# command and control of remote hosts.  For example,
# start-dfs.sh will attempt to bring up all NNs, DNS, etc.

# Options to pass to SSH when one of the "log into a host and
# start/stop daemons" scripts is executed
export HADOOP_SSH_OPTS="-o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=10s"

# Filename which contains all of the hosts for any remote execution
# helper scripts # such as workers.sh, start-dfs.sh, etc.
#export HADOOP_WORKERS="${HADOOP_CONF_DIR}/workers"

###
# Options for all daemons
###
#

# Where (primarily) daemon log files are stored.
# ${HADOOP_HOME}/logs by default.
# Java property: hadoop.log.dir
export HADOOP_LOG_DIR=${HADOOP_LOG_HOME}/hadoop

# A string representing this instance of hadoop. $USER by default.
# This is used in writing log and pid files, so keep that in mind!
# Java property: hadoop.id.str
export HADOOP_IDENT_STRING=$USER

# How many seconds to pause after stopping a daemon
export HADOOP_STOP_TIMEOUT=5

# Where pid files are stored.  /tmp by default.
export HADOOP_PID_DIR=${HADOOP_TMP_HOME}/hadoop/pid

# Default log4j setting for interactive commands
# Java property: hadoop.root.logger
export HADOOP_ROOT_LOGGER=INFO,console

# Default log4j setting for daemons spawned explicitly by
# --daemon option of hadoop, hdfs, mapred and yarn command.
# Java property: hadoop.root.logger
export HADOOP_DAEMON_ROOT_LOGGER=INFO,RFA

# Default log level and output location for security-related messages.
# You will almost certainly want to change this on a per-daemon basis via
# the Java property (i.e., -Dhadoop.security.logger=foo). (Note that the
# defaults for the NN and 2NN override this by default.)
# Java property: hadoop.security.logger
export HADOOP_SECURITY_LOGGER=INFO,NullAppender