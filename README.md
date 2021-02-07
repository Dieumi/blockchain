## blockchain Infrastructure
Private Coin


## Technologie utilise :
    ***Geth ***,
    ***Solc ***,
    ***Solidity ***,
    ***Web3 (Librairie Blockchain opensource)***,
    ***Docker ***
    ***Ethereum***

## Docker run

docker build -t privateth . 
docker run -v /path+/to/your/volume/myvolume/:/tmp/volume --net=host --env-file=envfile.env privateth


## Smart Contract 



# Install geth & truffle 
$ sudo apt-get install nodejs
$ sudo apt-get install npm
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository -y ppa:ethereum/ethereum
$ sudo apt-get update
$ sudo apt-get install ethereum
$ npm install -g truffle

# init blockchain 
geth --datadir ./dataDir init ./genesis.json

# genesis file
##### Check init ##########
"{ 
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
  \"gasLimit\": \"9000000000\",
  \"alloc\": {
    \"${adress}\": { 
    \"balance\": \"100000000000000000000000\" 
    }
  }
}"

