#!/bin/bash

echo "---- Let's build your Lamp stack ----"

mode='fastcgi'
docroot='/Users/hamza/Documents/elsan'
domain='localhost'
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
[ -z "$1" ] && mode='fastcgi'
[ -z "$3" ] && domain="localhost"
[ -z "$2" ] && echo "Docroot is mandatory since it does not have a default value" && exit 0

export DOMAIN=$domain
export WEBROOT=$docroot
export MODE=$mode

cd "$(pwd)/$MODE"
# cd /Users/hamza/Documents/personal-docker/docker-drupal-apache/fastcgi
echo $mode