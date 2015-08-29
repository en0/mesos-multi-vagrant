#!/usr/bin/env bash

# REGISTRY=$(cat Dockerfile | grep pem | cut -d' ' -f2 | sed s/\.pem$//)
# 
# echo "Creating SSL Certificate..."
# openssl req \
#   -new \
#   -x509 \
#   -nodes \
#   -newkey rsa:4096 \
#   -keyout ${REGISTRY}.key \
#   -out ${REGISTRY}.crt \
#   -subj "/C=AU/ST=Iowa/L=Springfield/O=LFW/CN=${REGISTRY}" \
#   -days 360 > /dev/null 2>&1
# 
# echo "Creating PEM File..."
# cat ${REGISTRY}.crt ${REGISTRY}.key > ${REGISTRY}.pem

echo "Building HAPROXY container. This might take a moment..."
docker build -t haproxy:local . > /dev/null 2>&1

echo "Starting HAPROXY..."
docker -H "tcp://localhost:12375" run --restart=always -tid --hostname edge.weave.local -p 80:80 -p 443:443 haproxy:local

echo "Installing Host overrider for registry.weave.local..."
sudo sed -i s/localhost/localhost\ registry.weave.local/ /etc/hosts
