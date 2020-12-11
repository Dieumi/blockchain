#!/bin/sh

cd private-ethereum 
echo ${ETH_ACC_PASSWORD} >> list.txt
echo ${ETH_FIRST_PEER}
echo ${ETH_GENERATE_ACCOUNT}


adress=$(geth --datadir ./datadir --password list.txt account new | grep "Public address of the key:" | cut -d':' -f2) 
echo "test0"
adress=$(echo ${adress} | tr -d ' ')

genesis="{ 
  \"config\": {
    \"chainId\": 2020,
    \"homesteadBlock\": 0,
    \"eip150Block\": 0,
    \"eip150Hash\": \"0x0000000000000000000000000000000000000000000000000000000000000000\",
    \"eip155Block\": 0,
    \"eip158Block\": 0,
    \"byzantiumBlock\": 0,
    \"constantinopleBlock\": 0,
    \"petersburgBlock\": 0,
    \"ethash\": {}
  },
  \"difficulty\": \"1\",
  \"gasLimit\": \"2000000\",
  \"alloc\": {
    \"${adress}\": { 
    \"balance\": \"100000000000000000000000\" 
    }
  }
}"

echo ${genesis}
echo ${genesis} > genesis.json
geth --datadir ./myDataDir init ./genesis.json
geth --datadir ./datadir init ./genesis.json
mv  ./myDataDir/keystore ./datadir/keystore

geth --port ${ETH_PORT} --networkid 1234 --datadir=./datadir  --http --http.port ${ETH_HTTP_PORT} --http.addr 127.0.0.1  --http.api "eth,net,web3,personal,miner,admin" --allow-insecure-unlock 



