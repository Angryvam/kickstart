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

## Dockerfile won't allow parent directory access - so we just copy the project
if [[ -e .kickstart-temp ]]
then
    rm -Rf .kickstart-temp
fi
mkdir .kickstart-temp
rsync -aP ../../../ .kickstart-temp/

# Build the container
docker build -t $TAG --no-cache $PWD

# Remove temp directory
rm -Rf .kickstart-temp


# Run the container
demo/kickstart.sh -t $TAG run dev

