#!/bin/bash

#Update System
sudo apt-get update
sudo apt-get install -y aptitude
sudo aptitude install -y software-properties-common python-software-properties
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get -y update
sudo apt-get -y install git ufw

#Setup firewall
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22 #connections will be local or via tunneling
sudo ufw enable

#Install Docker
sudo apt-get install -y docker-ce


current=`pwd`

#Setup testnet and mainnet
docker run -d --restart=always --name btctest -p 3002:3001 -p 18332:18332 -p 18333:18333 -v $current/testnet:/root/.bitcore figassis/docker-bitcore
docker run -d --restart=always --name btcmain -p 3001:3001 -p 8332:8332 -p 8333:8333 -v $current/mainnet:/root/.bitcore figassis/docker-bitcore