#!/bin/bash

# Installation in flavored container


apt-get install -y php-cli curl zip composer



if [[ ! -e /kickstart ]]
then
    echo "/kickstart not existing... starting installation"
    mkdir /kickstart
    git clone --single-branch --depth 1 "https://github.com/c7lab/kickstart.git" /kickstart
fi;


echo "Running kickstart install scripts (container/build.sh)..."
/kickstart/container/build.sh

echo "Done."
