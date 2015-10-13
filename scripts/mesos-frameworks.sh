#!/bin/sh

# Setup java ppa for marathon java8 dependency
apt-get -y install software-properties-common python-software-properties
apt-add-repository ppa:webupd8team/java
apt-get update
echo 'oracle-java9-installer shared/accepted-oracle-license-v1-1 select true' | \
     /usr/bin/debconf-set-selections

# Install chronos and marathon
apt-get -y install chronos marathon

# Disable slave
echo manual | tee  /etc/init/mesos-slave.override
