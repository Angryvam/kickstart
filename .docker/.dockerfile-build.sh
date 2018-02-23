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

apt-get install -y debconf-utils

## find out about preseed.txt by install debconf-utils and run debconf-get-selections
echo "tzdata  tzdata/Zones/Europe     select  Brussels" > preseed.txt
echo "tzdata  tzdata/Areas            select  Europe"   >> preseed.txt
echo "tzdata  tzdata/Zones/Etc        select  UTC"      >> preseed.txt
debconf-set-selections preseed.txt



apt-get install -q -y vim nano bash-completion curl git sudo less telnet

apt-get install -q -y composer

####################################################################
# Remove unused things
####################################################################

if [ $DEV_BUILD!=1 ]
then
    echo "Cleaning image in production mode..."
    # apt-get clean && rm -rf /var/lib/apt/lists/*
fi;

