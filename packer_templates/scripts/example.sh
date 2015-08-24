#!/bin/sh

# Clone example source tree and build
git clone https://github.com/en0/webskel2.git
cd webskel2
docker build -t webskel:latest .
echo "Example website files located at: $(pwd)"
