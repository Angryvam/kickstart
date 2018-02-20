#!/bin/bash

## set -e: Stop on error
set -e

## Set the shell



apt-get update
DEBIAN_FRONTEND=noninteractive
################################################################
## Install-Anweisungen ab hier einfügen
################################################################



################################################################
# Standard-Install
################################################################

apt-get install --no-install-recommends -q -y vim bash-completion php7.0 \
    php7.0-xml php7.0-json php7.0-mbstring composer php7.0-zip curl \
    git sudo less telnet



####################################################################
# Remove unused things
####################################################################

if [ $DEV_BUILD!=1 ]
then
    echo "Cleaning image in production mode..."
    # apt-get clean && rm -rf /var/lib/apt/lists/*
fi;

