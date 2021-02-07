#!/bin/sh

cd private-ethereum/blockchain
echo ${ETH_ACC_PASSWORD} >> list.txt
genesis="{ 
  \"config\": {
    \"chainId\": 1234,
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
  \"gasLimit\": \"9000000000000\",
  \"alloc\": {
    \"${ADRESS}\": { 
    \"balance\": \"100000000000000000000000\" 
    }
  }
}"


echo ${genesis} > genesis.json


geth --datadir ./datadir init ./genesis.json

if [ ${ETH_FIRST_GEN}=true ];
then
  mv  ../UTC/keystore ./datadir/
  geth  --port ${ETH_PORT} --verbosity 6 --networkid 1234 --datadir=./datadir --syncmode 'full' --nodiscover --miner.gasprice=0   --http --http.port ${ETH_HTTP_PORT} --http.addr ${ETH_HTTP_DNS}  --rpcapi "eth,net,web3,personal,miner,admin" --http.corsdomain "*"  --allow-insecure-unlock --unlock ${ADRESS} --password list.txt 
else
  geth  --port ${ETH_PORT} --verbosity 6 --networkid 1234 --datadir=./datadir --syncmode 'full' --nodiscover --miner.gasprice=0 --http --http.port ${ETH_HTTP_PORT} --http.addr ${ETH_HTTP_DNS}  --rpcapi "eth,net,web3,personal,miner,admin" --http.corsdomain "*"   --allow-insecure-unlock  
fi