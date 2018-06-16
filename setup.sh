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
mainapi=3001
testapi=3002

mainrpc=8332
testrpc=18332

maininbound=8333
testinbound=18333


#Bitcoin Setup
docker run -d --restart=always --name btctest -p $testapi:3001 -p $testrpc:18332 -p $testinbound:18333 -v $current/testnet:/root/.bitcore figassis/docker-bitcore:bitcoin
docker run -d --restart=always --name btcmain -p $mainapi:3001 -p $mainrpc:8332 -p $maininbound:8333 -v $current/mainnet:/root/.bitcore figassis/docker-bitcore:bitcoin

#Litecoin Setup
let mainapi+=2
let testapi+=2

let mainrpc+=2
let testrpc+=2

let maininbound+=2
let testinbound+=2

docker run -d --restart=always --name ltctest -p $testapi:3001 -p $testrpc:19332 -p $testinbound:19335 -v $current/ltctestnet:/root/.litecoin figassis/docker-bitcore:litecoin
docker run -d --restart=always --name ltcmain -p $mainapi:3001 -p $mainrpc:9332 -p $maininbound:9333 -v $current/ltcmainnet:/root/.litecoin figassis/docker-bitcore:litecoin

#Litecoin Setup
let mainapi+=2
let testapi+=2

let mainrpc+=2
let testrpc+=2

let maininbound+=2
let testinbound+=2

docker run -d --restart=always --name dashtest -p $testapi:3001 -p $testrpc:9998 -p $testinbound:19999 -v $current/dashtestnet:/root/.dashcore figassis/docker-bitcore:dash
docker run -d --restart=always --name dashmain -p $mainapi:3001 -p $mainrpc:9998 -p $maininbound:9999 -v $current/dashmainnet:/root/.dashcore figassis/docker-bitcore:dash