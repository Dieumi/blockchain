#!/bin/sh

cd private-ethereum/blockchain
echo ${ETH_ACC_PASSWORD} >> list.txt

adress=$(geth --datadir ./datadir --password list.txt account new | grep "Public address of the key:" | cut -d':' -f2) 

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
  \"difficulty\": \"100\",
  \"gasLimit\": \"2000000\",
  \"alloc\": {
    \"${adress}\": { 
    \"balance\": \"100000000000000000000000\" 
    }
  }
}"


if [ ${ETH_DEPLOY_SMART_CONTRACT}=true ];
then
 echo "Set adress for deploying" 
 sed -i "s|from:|from: \"${adress}\" |g" truffle-config.js 
fi

echo ${genesis} > genesis.json

geth --datadir ./myDataDir init ./genesis.json
geth --datadir ./datadir init ./genesis.json
mv  ./myDataDir/keystore ./datadir/keystore

ls copy/scripts/

geth --preload "/copy/scripts/miner.js" --port ${ETH_PORT} --networkid 1234 --datadir=./datadir  --http --http.port ${ETH_HTTP_PORT} --http.addr 127.0.0.1  --rpcapi "eth,net,web3,personal,miner,admin" --allow-insecure-unlock --unlock ${adress} --password list.txt --mine 

