#!/bin/bash

set -e
set -o pipefail
trap 'on_error $LINENO' ERR;
PROGNAME=$(basename $0)

function on_error () {
    echo "Error: ${PROGNAME} on line $1" 1>&2
    exit 1
}


COLOR_NC='\e[0m' # No Color
COLOR_WHITE='\e[1;37m'
COLOR_BLACK='\e[0;30m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_GRAY='\e[0;30m'
COLOR_LIGHT_GRAY='\e[0;37m'

echo -e $COLOR_YELLOW
echo "[entry.sh] +----------------------------------------------------+"
echo "[entry.sh] | KICKSTART-CONTAINER STARTUP!                       |"
echo "[entry.sh] +----------------------------------------------------+"
echo "[entry.sh] | Running .docker/entry.sh inside container"
echo "[entry.sh] | Parameters.: $@"
echo "[entry.sh] | Dev UID....: $DEV_UID"
echo "[entry.sh] | ProjectName: $DEV_CONTAINER_NAME"
echo "[entry.sh] +----------------------------------------------------+"

echo "[entry.sh] Running /kickstart/container/flavor-start.sh"
echo -e $COLOR_NC

. /root/flavor/flavor-start.sh



echo -e $COLOR_LIGHT_CYAN"[entry.sh][DEVELOPMENT MODE] Changing userid of 'user' to $DEV_UID"

usermod -u $DEV_UID user
chown -R user /home/user
export HOME=/home/user
echo "user   ALL = (ALL) NOPASSWD:   ALL" >> /etc/sudoers

echo "[entry.sh] + kick init"
sudo -E -s -u user kick init

RUN_SHELL=1
if [ "$1" == "run" ]
then
    RUN_SHELL=0
    shift 1;
fi;

if [ "$1" != '' ]
then
    echo "[entry.sh] + kick $@"
    sudo -E -s -u user kick $@
fi;

echo -e $COLOR_YELLOW
if [ -f /opt/README.msg ]
then
    echo "-------------------------- Message from README.msg -----------------------------"
    cat /opt/README.msg
fi;

echo ""
echo -e $COLOR_GREEN"Container ready..."
echo -e $COLOR_NC



if [ "$RUN_SHELL" == "1" ]
then
    sudo -E -s -u user /bin/bash
fi;
echo "[entry.sh] exit; You are now leaving the container. Goodbye."
exit




