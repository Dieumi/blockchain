FROM ubuntu:20.04
USER root 
RUN apt-get update && \
    apt-get install nodejs -y && \
    apt-get install npm -y  && \
    npm install --ignore-scripts -g truffle  

RUN apt-get install software-properties-common -y && \
    add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get install ethereum -y  && \
    apt install git-all -y  && \
    apt-get install -y libusb-1.0-0 && \
    apt-get install -y libusb-dev && \
    mkdir private-ethereum 



COPY ./copy /private-ethereum

RUN cd private-ethereum/ &&\
    git clone https://github.com/Dieumi/blockchain.git

EXPOSE 30303 30304 8543 8546



ENTRYPOINT ["/bin/sh","./private-ethereum/scripts/init.sh"]