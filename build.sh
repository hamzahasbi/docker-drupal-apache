#!/bin/bash

echo "---- Let's build your Lamp stack ----"

[ -d data ] || mkdir data

mode='fastcgi'
domain='localhost'
sslcert=0
project='dev'

if [ -z "$1" ]
then
  read -p "FastCGI or P¨HP MOD answer should be (fastcgi or php_mod) : " mode
else
  mode=$1
fi
if [ -z "$2" ]
then
  read -p "Path to your web app to be mounted as docroot : " docroot
else
  docroot=$2
fi
if [ -z "$3" ]
then
  read -p "Local domain name (default : localhost) : " domain
else
  domain=$3
fi
if [ -z "$4" ]
then
  read -p "Project Name: " project
else
  project=$4
fi
if [ -z "$5" ]
then
  read -p "Do you want to generate self signed ssl certicate (default to false) you'll need to configure it in docker-compose file(true/false): " sslcert
else
  sslcert=$5
fi

[ -z "$1" ] && mode='fastcgi'
[ -z "$3" ] && domain="localhost"
[ -z "$5" ] && sslcert=false
[ -z "$docroot" ] && echo "Docroot is mandatory since it does not have a default value" && exit 0


if [ "$sslcert" = true ] ; then
  # ---------SSL Certificate ------------#
  [ -d ssl ] || mkdir ssl
  openssl genrsa -des3 -passout pass:x -out ./ssl/server.pass.key 2048
  openssl rsa -passin pass:x -in ./ssl/server.pass.key -out ./ssl/server.key
  rm ./ssl/server.pass.key
  openssl req -new -key ./ssl/server.key -out ./ssl/server.csr
  # subj flag if you don't want an interactive genration 
  # @example -subj "/C=MA/ST=FEZ/L=FEZ/O=Void/OU=Ar Department/CN=domain.dd"
  openssl x509 -req -days 365 -in ./ssl/server.csr -signkey ./ssl/server.key -out ./ssl/server.crt

# --------- you'll need to copy the keys to the appropriate folder ------------#
fi

export MODE=$mode
export DOMAIN=$domain 
export WEBROOT=$docroot
export PROJECT_NAME=$project
cd "$(pwd)/$MODE" && docker-compose up --build -d
