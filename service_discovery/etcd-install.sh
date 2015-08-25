#!/usr/bin/env bash

wget https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz
tar xzf etcd-v2.1.2-linux-amd64.tar.gz
sudo mkdir -p /usr/local/bin/ /var/etcd/
sudo cp etcd-v2.1.2-linux-amd64/etcd /usr/local/bin/etcd
rm -rf etcd-v2.1.2-linux-amd64/
# Install upstart script
sudo chmod +x /etc/init.d/etcd 
