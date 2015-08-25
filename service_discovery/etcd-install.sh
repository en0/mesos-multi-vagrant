#!/usr/bin/env bash

## Included in base box ##
# wget https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz
# tar xzf etcd-v2.1.2-linux-amd64.tar.gz
# sudo mkdir -p /usr/local/bin/ /var/etcd/
# sudo cp etcd-v2.1.2-linux-amd64/{etcd,etcdctl} /usr/local/bin/
# rm -rf etcd-v2.1.2-linux-amd64*

## MASTER - Included in Vagrantfile
# sudo exec /usr/local/bin/etcd --name="default" \
#              --advertise-client-urls="http://172.31.0.100:2379,http://172.31.0.100:4001" \
#              --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
#              --listen-peer-urls="http://0.0.0.0:2380" \
#              --initial-advertise-peer-urls="http://172.31.0.100:2380" \
#              --initial-cluster-token="$(uuidgen)" \
#              --initial-cluster="default=http://172.31.0.100:2380" \
#              --initial-cluster-state="new" >> /var/log/etcd.log 2>&1

## SLAVE - Included in Vagrantfile
# sudo exec /usr/local/bin/etcd --proxy on --initial-cluster="default=http://172.31.0.100:2380"
