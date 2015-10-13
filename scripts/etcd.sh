#!/bin/sh

# Install etcd from static-linked packages
wget https://github.com/coreos/etcd/releases/download/v2.2.0/etcd-v2.2.0-linux-amd64.tar.gz
tar vxf etcd-v2.2.0-linux-amd64.tar.gz
mkdir -p /usr/local/bin/ /var/etcd/
cp etcd-v2.2.0-linux-amd64/etcd /usr/local/bin/
cp etcd-v2.2.0-linux-amd64/etcdctl /usr/local/bin/
rm -rf etcd-v2.2.0-linux-amd64*

cp /vagrant/etcd.upstart /etc/init.d/etcd
chmod +x /etc/init.d/etcd
chown root:root /etc/init.d/etcd
