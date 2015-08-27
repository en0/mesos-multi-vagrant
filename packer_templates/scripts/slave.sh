#!/bin/sh

# Install docker
wget -O docker.sh https://get.docker.com/
sudo chmod +x docker.sh
sudo ./docker.sh
sudo rm docker.sh

# Install weave
sudo wget -O /usr/local/bin/weave http://git.io/weave
sudo chmod a+x /usr/local/bin/weave

# Pull required images for weave
sudo docker pull weaveworks/weave:1.0.2
sudo docker pull weaveworks/weavedns:1.0.2
sudo docker pull weaveworks/weaveexec:1.0.2

# Disable master services
echo manual | sudo tee  /etc/init/mesos-master.override
echo manual | sudo tee  /etc/init/zookeeper.override

# Install containerizors
echo 'docker,mesos' | sudo tee /etc/mesos-slave/containerizers
echo '5mins' | sudo tee /etc/mesos-slave/executor_registration_timeout
