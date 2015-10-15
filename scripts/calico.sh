#!/usr/bin/env bash

wget https://github.com/projectcalico/calico-docker/releases/download/v0.4.9/calicoctl
# Add SHA sum check
chmod +x calicoctl
mv calicoctl /usr/local/bin/

cp /vagrant/calico.upstart /etc/init.d/calico
chmod +x /etc/init.d/calico

echo 'xt_set' | tee -a /etc/modules
echo 'ipip' | tee -a /etc/modules

modprobe xt_set
modprobe ipip

docker pull calico/node:v0.4.9
