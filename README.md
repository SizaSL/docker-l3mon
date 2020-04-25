# L3MON Docker

- [Introduction](#introduction)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Example](#Example-YAML-for-Docker-compose-or-Portainer)
  - [Persistence](#persistence)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Shell Access](#shell-access)
- [Disclaimer](#Disclaimer)

# Introduction
This repository is to create a [Docker](https://www.docker.com/) container image for [L3MON](https://github.com/D3VL/L3MON) a cloud based remote Android management suite powered by [NodeJS](https://nodejs.org).

L3MON is open source cloud-based remote Android management suite. It is powered by NodeJS an asynchronous event-driven JavaScript runtime designed to build scalable network applications. Some of L3MONs many features include
- GPS Logging
- Microphone Recording
- View Contacts
- SMS logs
- Send SMS
- Call Logs
- View Installed Apps
- Live Clipboard Logging
- Live Notification Logging
- View Wifi Networks (logs previously seen)
- File Explorer & Downloader
- Command Queuing
- Built-In APK Builder

# Getting started

## Installation
- Clone this repo into your local directory and cd into it. 
- Build the image using following command,
    ```bash
      docker build -t sizasl/l3mon:0.1 .
    ```

## Quickstart
Download and extract [L3MON release v1.1.0](https://github.com/D3VL/L3MON/releases/tag/1.1.0) into volume directory of docker host machine.

Start L3MON server using:
```bash
  docker run --name l3mon -d --restart=always \
    --publish 22533:22533/udp --publish 22533:22533/tcp \
    --publish 22222:22222/udp --publish 22222:22222/tcp \
    --volume /PATH_TO_DOCKER_VOLUME_DIRECTORY:/L3MON-v1.1.0 \
    sizasl/l3mon:0.1
```
### Example YAML for Docker-compose or Portainer
```yml
services:
  l3mon:
    image: siza/l3mon:0.1
    restart: always
    networks:
      - l3mon-public
    volumes:
      - /data/l3mon_data:/L3MON-v1.1.0
      - /etc/localtime:/etc/localtime:ro 
    ports:
      - 22533:22533/udp
      - 22533:22533/tcp
      - 22222:22222/udp
      - 22222:22222/tcp
    secrets:
      - l3mon-pass
    environment:
      L3MON_USER: "admin"
      L3MON_PASS: /run/secrets/l3mon-pass
    deploy:
      placement:
        constraints:
          - node.hostname == l3mon-server
```
## User and Password
Default "user:passoword" is "admin:admin". You can simply change it via environment variable passed it to the container. ```entrypoint.sh``` and helper Python script ```update_user_pass.py``` will take care of converting your password into md5 format which is the requirement of L3MON server. Best practice is using docker secret function as shown in above example configuration. 

## Persistence
L3MON server data will be saved and persist in host volume directory across container shutdown and restart.

# Maintenance
## Upgrading
Simply removing content of docker host volume directory, download and extract new release from [L3MON release](https://github.com/D3VL/L3MON/releases) page then restart the container.

## Shell Access
```bash
  docker exec -it l3mon bash
```
# Disclaimer
<b>
Author Provides no warranty with this software and will not be responsible for any direct or indirect damage caused due to the usage of this tool.
This project is built for Educational purpose ONLY.
</b>