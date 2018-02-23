#!/bin/bash

## set -e: Stop on error
set -e

####################################################################
## Execute after .dockerfile-build.sh
####################################################################


echo "Linking kick..."
ln -s /kicksrc/bin/kick /usr/bin/kick
composer install -d /kicksrc


useradd -s /bin/bash --create-home user


# Set Color Prompt
PROMPT='export PROMPT_COMMAND='\''if [ `whoami` != "root" ] ;  then echo -ne "\e[0m\e[95m${DEV_TTYID}\e[0m`whoami`@\e[1;33m${DEV_CONTAINER_NAME}:\e[0m${PWD}$ "; else echo -ne "\e[101m\e[95m${DEV_TTYID}`whoami`@\e[1;33m${DEV_CONTAINER_NAME}:\e[0m${PWD}$ "; fi;'\'' '
echo $PROMPT >> /root/.bashrc
echo 'export PS1=""' >> /root/.bashrc

echo $PROMPT >> /home/user/.bashrc
echo 'export PS1=""' >> /home/user/.bashrc
echo "cd /opt" >> /home/user/.bashrc

chown user:root /opt

