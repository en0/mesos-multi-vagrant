#!/bin/sh

# Install docker
wget -O docker.sh https://get.docker.com/
sudo chmod +x docker.sh
sudo ./docker.sh
sudo rm docker.sh

# Disable master services
echo manual | sudo tee  /etc/init/mesos-master.override
echo manual | sudo tee  /etc/init/zookeeper.override

# Install containerizors
echo 'docker,mesos' | sudo tee /etc/mesos-slave/containerizers
echo '5mins' | sudo tee /etc/mesos-slave/executor_registration_timeout
