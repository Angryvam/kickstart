#!/bin/bash

## set -e: Stop on error
set -e

###################################################
# Services hochfahren
###################################################

ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone


if [ "$PULL_URL" != "" ]
then
    echo "[CLONE] Cloneing from $PULL_URL..."
    chown user:user /opt
    cd /opt
    sudo -u user git clone --single-branch --depth 1 "$PULL_URL" /opt 2>&1

    cd /root

    #if [ -e /opt/composer.json ]
    #then
    #    echo "Found composer.json..."
    #     sudo -u user composer -d /opt update
    #fi

fi;


echo '<?php ' > /etc/config.php
if [ "$PULL_URL" == "" ]
then
    echo 'define("DEBUG", true);' >> /etc/config.php
else
    echo 'define("DEBUG", false);' >> /etc/config.php
fi;
echo "define('ROOT_URL', '$ROOT_URL');" >> /etc/config.php

