#!/bin/bash

# Pre-pull docker containers
sudo docker pull weaveworks/weave:1.0.2 > /dev/null 2>&1
sudo docker pull weaveworks/weavedns:1.0.2 > /dev/null 2>&1
sudo docker pull weaveworks/weaveexec:1.0.2 > /dev/null 2>&1

# Install weave
sudo wget -q git.io/weave
sudo mv weave /usr/local/bin/
sudo chmod a+x /usr/local/bin/weave

# Launch weave
sudo weave launch $1
sudo weave launch-dns
sudo weave launch-proxy

# Export for docker proxy
echo $(weave proxy-env) | sudo tee -a /etc/environment
source /etc/environment
