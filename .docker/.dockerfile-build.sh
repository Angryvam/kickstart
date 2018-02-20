#!/bin/bash

## set -e: Stop on error
set -e

## Set the shell



apt-get update
DEBIAN_FRONTEND=noninteractive


CONF_VERSION_NODEJS="latest"
CONF_VERSION_ANGULAR="latest"

################################################################
## Install-Anweisungen ab hier einfügen
################################################################



################################################################
# Standard-Install
################################################################

apt-get install --no-install-recommends -q -y vim bash-completion php7.0 \
    php7.0-xml php7.0-json php7.0-mbstring composer php7.0-zip curl \
    git sudo php-mongodb npm less telnet

echo "Upgrading to nodejs:$CONF_VERSION_NODEJS..."
npm install -g n
n $CONF_VERSION_NODEJS


echo "Installing @angular/cli:$CONF_VERSION_ANGULAR...";
npm install -g @angular/cli nodemon


####################################################################
# Remove unused things
####################################################################

if [ $DEV_BUILD!=1 ]
then
    echo "Cleaning image in production mode..."
    # apt-get clean && rm -rf /var/lib/apt/lists/*
fi;

