#!/bin/bash
# takes two paramters, the domain name and the email to be associated with the certificate
DOMAIN=$1 #rbi-oktay.<my_public_ip>.sslip.io
EMAIL=$2 #oktay.savdi@gmail.com
 
export DOMAIN=${DOMAIN}
export EMAIL=${EMAIL}
 
# Phase 1
docker-compose -f ./docker-compose-initiate.yaml up -d nginx
docker-compose -f ./docker-compose-initiate.yaml up certbot
docker-compose -f ./docker-compose-initiate.yaml down
 
# some configurations for let's encrypt
curl -L --create-dirs -o ./letsencrypt/options-ssl-nginx.conf https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf
openssl dhparam -out ./letsencrypt/ssl-dhparams.pem 2048
 
# Phase 2
docker-compose -f ./docker-compose.yaml up -d
