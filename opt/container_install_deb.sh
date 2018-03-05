#!/bin/bash

# Installation in flavored container


apt-get install -y php-cli curl zip composer



if [[ ! -e /kickstart ]]
then
    echo "/kickstart not existing... starting installation"
    mkdir /kickstart

    curl -o /kickstart/kick.zip "https://github.com/c7lab/kickstart/archive/master.zip"
    unzip /kickstart/kick.zip
fi;


echo "Running kickstart install scripts (container/build.sh)..."
/kickstart/container/build.sh

echo "Done."
