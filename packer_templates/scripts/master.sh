#!/bin/sh

# Install chronos and marathon
sudo apt-get -y install chronos marathon

# Disable slave
echo manual | sudo tee  /etc/init/mesos-slave.override
