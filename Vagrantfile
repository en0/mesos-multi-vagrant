# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.provider "libvirt" do |lv|
    lv.memory = "1024"
  end

  config.vm.define "master" do |master|
    master.vm.box = "mesos-master.box"
    master.vm.network "private_network", ip: "172.31.0.100", netmask: "255.255.0.0"
    master.vm.provision "shell", inline: <<-SHELL
      sudo service mesos-master stop
      sudo service marathon stop
      sudo service chronos stop
      sudo service zookeeper stop
      echo "zk://172.31.0.100:2181/mesos" | sudo tee /etc/mesos/zk
      echo "172.31.0.100" | sudo tee /etc/mesos-master/ip
      echo "Vagrant" | sudo tee /etc/mesos-master/cluster
      echo "master" | sudo tee /etc/mesos-master/hostname
      sudo service zookeeper start
      sudo service mesos-master start
      sudo service marathon start
      sudo service chronos start
      sudo exec /usr/local/bin/etcd --name="default" \
        --advertise-client-urls="http://172.31.0.100:2379,http://172.31.0.100:4001" \
        --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
        --listen-peer-urls="http://0.0.0.0:2380" \
        --initial-advertise-peer-urls="http://172.31.0.100:2380" \
        --initial-cluster-token="$(uuidgen)" \
        --initial-cluster="default=http://172.31.0.100:2380" \
        --initial-cluster-state="new" >> /var/log/etcd.log 2>&1
    SHELL
  end

  config.vm.define "slave1" do |slave1|
    slave1.vm.box = "mesos-slave.box"
    slave1.vm.network "private_network", ip: "172.31.0.101", netmask: "255.255.0.0"
    slave1.vm.provision "shell", inline: <<-SHELL
      sudo service mesos-slave stop
      echo "zk://172.31.0.100:2181/mesos" | sudo tee /etc/mesos/zk
      echo "172.31.0.101" | sudo tee /etc/mesos-slave/ip
      echo "slave1" | sudo tee /etc/mesos-slave/hostname
      sudo service mesos-slave start
      sudo exec /usr/local/bin/etcd --proxy on --initial-cluster="default=http://172.31.0.100:2380"
    SHELL
  end

  config.vm.define "slave2", autostart: false do |slave2|
    slave2.vm.box = "mesos-slave.box"
    slave2.vm.network "private_network", ip: "172.31.0.102", netmask: "255.255.0.0"
    slave2.vm.provision "shell", inline: <<-SHELL
      sudo service mesos-slave stop
      echo "zk://172.31.0.100:2181/mesos" | sudo tee /etc/mesos/zk
      echo "172.31.0.102" | sudo tee /etc/mesos-slave/ip
      echo "slave2" | sudo tee /etc/mesos-slave/hostname
      sudo service mesos-slave start
      sudo exec /usr/local/bin/etcd --proxy on --initial-cluster="default=http://172.31.0.100:2380"
    SHELL
  end

  config.vm.define "slave3", autostart: false do |slave3|
    slave3.vm.box = "mesos-slave.box"
    slave3.vm.network "private_network", ip: "172.31.0.103", netmask: "255.255.0.0"
    slave3.vm.provision "shell", inline: <<-SHELL
      sudo service mesos-slave stop
      echo "zk://172.31.0.100:2181/mesos" | sudo tee /etc/mesos/zk
      echo "172.31.0.103" | sudo tee /etc/mesos-slave/ip
      echo "slave3" | sudo tee /etc/mesos-slave/hostname
      sudo service mesos-slave start
      sudo exec /usr/local/bin/etcd --proxy on --initial-cluster="default=http://172.31.0.100:2380"
    SHELL
  end

  config.vm.box_check_update = false
end
