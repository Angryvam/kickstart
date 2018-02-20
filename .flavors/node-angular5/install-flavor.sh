#!/bin/bash

set -e

CONF_VERSION_NODEJS="latest"
CONF_VERSION_ANGULAR="latest"

apt-get install -y npm

echo "Upgrading to nodejs:$CONF_VERSION_NODEJS..."
npm install -g n
n $CONF_VERSION_NODEJS

echo "Installing @angular/cli:$CONF_VERSION_ANGULAR...";
npm install -g @angular/cli nodemon

