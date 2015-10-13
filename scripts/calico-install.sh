#!/usr/bin/env bash

# Project Calico Step by step
# We should check the hash after the http download
wget https://github.com/projectcalico/calico-docker/releases/download/v0.4.9/calicoctl
# add sha sum check
chmod +x calicoctl
mv calicoctl /usr/local/bin/
# modprobe xt_set
# modprobe ipip

docker pull calico/node:v0.4.9
