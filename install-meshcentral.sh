#!/usr/bin/env bash

sudo yum install --assumeyes --quiet \
     wget

sudo docker pull olberger/meshcentral2:latest

sudo docker run -d --name meshcentral -p 80:80/tcp -p 443:443/tcp olberger/meshcentral2:latest

sleep 10

sudo docker logs meshcentral

sleep 10

wget https://localhost/meshagents?script=1 --no-check-certificate -O ./meshinstall.sh

echo "meshcentral should be available on https://localhost:8443/"

