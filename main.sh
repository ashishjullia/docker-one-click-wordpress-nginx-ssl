#!/bin/bash
# # Update system
# sudo apt update -y

# # Install curl
# sudo apt install -y curl

# # Install docker and docker-compose
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh

# sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# # Create services "nodeJS", "webserver (nginx)" and "certbot"
# sudo docker-compose up -d

# # Update the docker-compose.yml file
# sudo sed -i 's/--staging/--force-recreate/g' ./docker-compose.yml

export DOMAIN='geekylanetest.com'
export DOMAIN_WWW='www.geekylanetest.com'
export PROD_OR_STAGING='--staging'

envsubst < "default.conf.template" > "default.conf"
envsubst < "docker-compose.yml.template" > "docker-compose.yml"

# # Create the containers
# sudo docker-compose up -d 

# sleep 10

# sudo docker-compose stop webserver
mkdir dhparam && \
sudo openssl dhparam -out $PWD/dhparam/dhparam-2048.pem 2048

envsubst < "default-ssl.conf.template" > "default.conf"

sudo docker-compose up -d --force-recreate --no-deps webserver

