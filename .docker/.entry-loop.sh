#!/bin/bash

## set -e: Stop on error
set -e


###############################################################
# Docker Entry loop:
# Container bleibt online, solange diese Datei ausgeführt wird
###############################################################


service apache2 start

while [ true ]
do
    sleep 100
done