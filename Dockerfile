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
    && curl -sL https://deb.nodesource.com/setup_13.x | bash -\
    && apt-get install -y nodejs\
    && apt-get install -y default-jre default-jdk\
    && apt-get install -y jq \
    && npm install pm2 -g
COPY entrypoint.sh ${SCRIPT_PATH}
COPY update_user_pass.py ${SCRIPT_PATH}
RUN chmod 755 ${SCRIPT_PATH}/entrypoint.sh
RUN chmod 755 ${SCRIPT_PATH}/update_user_pass.py
EXPOSE 22533/udp 22533/tcp
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/named"]
