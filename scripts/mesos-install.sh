#!/bin/sh

# Setup mesosphere ppa
apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

# Add the repository
echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main" | \
      tee /etc/apt/sources.list.d/mesosphere.list
apt-get -y update

# Install packages
apt-get -y install mesos
