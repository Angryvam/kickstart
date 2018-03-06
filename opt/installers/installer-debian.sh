#!/bin/bash

#
# Kickstart Install file for Debian/Ubuntu Containers
#
# See: https://github.com/c7lab/kickstart/opt/installers
#

apt-get install -y php-cli curl zip composer

echo "Cloning kickstart scripts..."
mkdir /kickstart
git clone --single-branch --depth 1 "https://github.com/c7lab/kickstart.git" /kickstart

echo "Running kickstart install scripts (container/build.sh)..."
. /kickstart/container/build.sh

echo "Done."
