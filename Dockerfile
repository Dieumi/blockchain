FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install nodejs -y && \
    apt-get install npm -y && \
    apt-get install software-properties-common -y && \
    add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get install ethereum -y  && \
    mkdir private-ethereum 

COPY ./copy /private-ethereum


EXPOSE 30303 30304 8543 8546



ENTRYPOINT ["/bin/sh","./private-ethereum/scripts/init.sh"]