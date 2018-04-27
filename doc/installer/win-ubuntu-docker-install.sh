#!/bin/bash
####
# Installer script to install and configure docker
# on Windows 10 Pro Ubuntu Shell
#
set -x

trap 'on_error $LINENO' ERR;
_PROGNAME=$(basename $0)
_PROGPATH="$( cd "$(dirname "$0")" ; pwd -P )"   # The absolute path to

function on_error () {
    echo "Error: ${_PROGNAME} on line $1" 1>&2
    exit 1
}


if [ `whoami` = "root" ]
then
    echo "This script must not run as root! (run without sudo)"
    exit 1
fi



sudo apt-get -y update

# Install some libraries
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's official PGP key
sudo bash -c "curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -"

# Add Docker's stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install docker
sudo apt-get -y update
sudo apt-get -y install docker-ce

### Install special version:
## apt-get -y install docker-ce=<VERSION>

# Setup the docker-cli connection to use native windows docker server
echo "export DOCKER_HOST=tcp://127.0.0.1:2375" >> ~/.bashrc

# Setup kickstart path mapping
echo "KICKSTART_WIN_PATH=C:/" >> ~/.kickstartconfig

# Testrun
docker run hello-world

echo "Docker installation successful!"
