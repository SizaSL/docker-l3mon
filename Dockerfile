FROM ubuntu:18.04

LABEL maintainer="sizasl@gmail.com"

# Default user name "admin" with password "admin"
ENV L3MON_USER=admin\
    L3MON_PASS=admin\
    L3MON_HOME=/L3MON-v1.1.0\
    SCRIPT_PATH=/usr/local/bin

RUN apt-get update\
    && apt-get install -y unzip\
    && apt-get install -y wget\
    && apt-get install -y curl\
    && curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -\
    && apt-get install -y nodejs\
    && apt-get install -y default-jre default-jdk\
    && apt-get install -y jq \
    && npm install pm2 -g
    
