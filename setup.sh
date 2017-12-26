#!/bin/bash

#We assume docker is already running on this machine
#And that we have enough space to host both the mainnet and testnet blockchains

#Setup firewall
sudo apt-get update && sudo apt-get -y install git ufw
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22 #connections will be local or via tunneling
sudo ufw enable

#Setup testnet and mainnet
current=`pwd`
docker run -d --restart=always --name btctest -p 3002:3001 -p 18332:18332 -p 18333:18333 -v $current/testnet:/root/.bitcore figassis/docker-bitcore
docker run -d --restart=always --name btcmain -p 3001:3001 -p 8332:8332 -p 8333:8333 -v $current/mainnet:/root/.bitcore figassis/docker-bitcore