#!/bin/sh

PACKAGES="
curl
unzip
vim-tiny
nmap
git
"

apt-get update --fix-missing
apt-get -y upgrade
apt-get -y install $PACKAGES
