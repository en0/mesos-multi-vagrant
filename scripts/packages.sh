PACKAGES="
curl
unzip
vim-tiny
mesos
"

# Setup additional repos
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

# Add the repository
echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main" | \
      sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

# Install etcd from static-linked packages
wget https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz
tar xzf etcd-v2.1.2-linux-amd64.tar.gz
sudo mkdir -p /usr/local/bin/ /var/etcd/
sudo cp etcd-v2.1.2-linux-amd64/{etcd,etcdctl} /usr/local/bin/
rm -rf etcd-v2.1.2-linux-amd64*

# Install packages
apt-get -y install $PACKAGES
