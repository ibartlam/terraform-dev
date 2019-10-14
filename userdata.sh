#!/bin/bash -v
apt-get update -y
#apt-get upgrade -y
#apt-get remove docker docker-engine docker.io
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
sudo groupadd docker
sudo usermod -aG docker ubuntu
