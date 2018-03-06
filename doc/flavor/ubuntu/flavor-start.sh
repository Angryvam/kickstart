#!/bin/bash

## This script is executed when the container starts up

echo "[flavor-start.sh] Setting timezone to $TIMEZONE..."
ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone
