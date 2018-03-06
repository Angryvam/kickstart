#!/bin/bash

set -e
set -o pipefail
trap 'on_error $LINENO' ERR;
PROGNAME=$(basename $0)


function on_error () {
    echo "Error: ${PROGNAME} on line $1" 1>&2
    exit 1
}

TAG="kickstart-test-ubuntu"


docker build -t $TAG --no-cache $PWD

docker kill -t $TAG
docker rm -t $TAG

