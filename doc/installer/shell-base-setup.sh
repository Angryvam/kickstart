#!/bin/bash
####
# Setup environment (SSH-key, git)
#


trap 'on_error $LINENO' ERR;
_PROGNAME=$(basename $0)
_PROGPATH="$( cd "$(dirname "$0")" ; pwd -P )"   # The absolute path to

function on_error () {
    echo "Error: ${_PROGNAME} on line $1" 1>&2
    exit 1
}


if [ $(`whoami`)=="root" ]
then
    echo "This script must not run as root! (run without sudo)"
    exit 1
fi




echo "Installer not working at the moment. Execute the commands by hand:"
exit 1

sudo apt-get install git

## Secure keygen according to https://security.stackexchange.com/questions/143442/what-are-ssh-keygen-best-practices
ssh-keygen -t ed25519 -a 100

# Configure git
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global push.default simple


echo "Add this to your github/gitlab accounts SSH-Keys:"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "Installation successful!"
