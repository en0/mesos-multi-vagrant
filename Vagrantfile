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
    master.vm.box = "ubuntu-14.04.3-server-amd64.box"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "172.31.0.100", netmask: "255.255.0.0"
    master.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    master.vm.provision "shell", path: "scripts/sysadmin.sh"
    master.vm.provision "shell", path: "scripts/mesos-install.sh"
    master.vm.provision "shell", path: "scripts/etcd.sh"
    master.vm.provision "shell", inline: <<-SHELL
      cp /vagrant/etcd-master.conf /etc/default/etcd
      update-rc.d etcd defaults
    SHELL
    master.vm.provision "shell", path: "scripts/mesos-frameworks.sh"
    master.vm.provision "shell", inline: <<-SHELL
      service mesos-master stop
      service marathon stop
      service chronos stop
      service zookeeper stop
      echo "zk://172.31.0.100:2181/mesos" | tee /etc/mesos/zk
      echo "172.31.0.100" | tee /etc/mesos-master/ip
      echo "Vagrant" | tee /etc/mesos-master/cluster
      echo "master" | tee /etc/mesos-master/hostname
      service zookeeper start
      service etcd start
      service mesos-master start
      service marathon start
      service chronos start
    SHELL
  end

  config.vm.define "slave1" do |slave1|
    slave1.vm.box = "ubuntu-14.04.3-server-amd64.box"
    slave1.vm.hostname = "slave1"
    slave1.vm.network "private_network", ip: "172.31.0.101", netmask: "255.255.0.0"
    slave1.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    slave1.vm.provision "shell", path: "scripts/sysadmin.sh"
    slave1.vm.provision "shell", path: "scripts/docker.sh"
    slave1.vm.provision "shell", path: "scripts/mesos-install.sh"
    slave1.vm.provision "shell", path: "scripts/mesos-slave-setup.sh"
    slave1.vm.provision "shell", inline: <<-SHELL
      echo "172.31.0.101" | tee /etc/mesos-slave/ip
      echo "slave1" | tee /etc/mesos-slave/hostname
      service mesos-slave start
    SHELL
    slave1.vm.provision "shell", path: "scripts/etcd.sh"
    slave1.vm.provision "shell", inline: <<-SHELL
      cp /vagrant/etcd-slave.conf /etc/default/etcd
      service etcd start
      update-rc.d etcd defaults
    SHELL
    slave1.vm.provision "shell", path: "scripts/calico-install.sh"
    slave1.vm.provision "shell", inline: "calicoctl node --ip=172.31.0.101"
    slave1.vm.provision "shell", path: "scripts/example.sh"
  end

  config.vm.define "slave2", autostart: false do |slave2|
    slave2.vm.box = "ubuntu-14.04.3-server-amd64.box"
    slave2.vm.hostname = "slave2"
    slave2.vm.network "private_network", ip: "172.31.0.102", netmask: "255.255.0.0"
    slave2.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    slave2.vm.provision "shell", path: "scripts/sysadmin.sh"
    slave2.vm.provision "shell", path: "scripts/docker.sh"
    slave2.vm.provision "shell", path: "scripts/mesos-install.sh"
    slave2.vm.provision "shell", path: "scripts/mesos-slave-setup.sh"
    slave2.vm.provision "shell", inline: <<-SHELL
      echo "172.31.0.102" | tee /etc/mesos-slave/ip
      echo "slave1" | tee /etc/mesos-slave/hostname
      service mesos-slave start
    SHELL
    slave2.vm.provision "shell", path: "scripts/etcd.sh"
    slave2.vm.provision "shell", inline: <<-SHELL
      cp /vagrant/etcd-slave.conf /etc/default/etcd
      service etcd start
      update-rc.d etcd defaults
    SHELL
    slave2.vm.provision "shell", path: "scripts/calico-install.sh"
    slave2.vm.provision "shell", inline: "calicoctl node --ip=172.31.0.102"
    slave2.vm.provision "shell", path: "scripts/example.sh"
  end

  config.vm.define "slave3", autostart: false do |slave3|
    slave3.vm.box = "ubuntu-14.04.3-server-amd64.box"
    slave3.vm.hostname = "slave3"
    slave3.vm.network "private_network", ip: "172.31.0.103", netmask: "255.255.0.0"
    slave3.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    slave3.vm.provision "shell", path: "scripts/sysadmin.sh"
    slave3.vm.provision "shell", path: "scripts/mesos.sh"
    slave3.vm.provision "shell", path: "scripts/etcd.sh"
#    slave3.vm.provision "shell", path: "scripts/docker.sh"
    slave3.vm.provision "shell", path: "scripts/slave.sh"
    slave3.vm.provision "shell", path: "scripts/example.sh"
    slave3.vm.provision "shell", inline: <<-SHELL
      service mesos-slave stop
      echo "zk://172.31.0.100:2181/mesos" | tee /etc/mesos/zk
      echo "172.31.0.103" | tee /etc/mesos-slave/ip
      echo "slave3" | tee /etc/mesos-slave/hostname
      mv /vagrant/etcd.upstart /etc/init.d/etcd
      chmod +x /etc/init.d/etcd
      chown root:root /etc/init.d/etcd
      mv /vagrant/etcd-slave.conf /etc/default/etcd
      chown root:root /etc/default/etcd
      service etcd start
      service mesos-slave start
    SHELL
  end

  config.vm.box_check_update = false
  config.vm.synced_folder "resources/", "/vagrant"
end
