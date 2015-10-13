#!/bin/sh

# Disable master services
echo manual | tee  /etc/init/mesos-master.override
echo manual | tee  /etc/init/zookeeper.override

# Install containerizors
echo 'docker,mesos' | tee /etc/mesos-slave/containerizers
echo '5mins' | tee /etc/mesos-slave/executor_registration_timeout

# Setup Zookeeper
echo "zk://172.31.0.100:2181/mesos" | tee /etc/mesos/zk
