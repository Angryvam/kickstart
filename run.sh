#!/bin/bash


## Load .env Properties
. ./.env


echo ""
echo "------------------------------------------------------------------------------------"
echo " + Loading from .env..."
echo " + Starte Projekt: $PROJECT_NAME"
echo " -> Registry Path: $REGISTRY_URL"
echo "------------------------------------------------------------------------------------"
echo ""







## Methoden für gitlab-ci:

if [[ $1 == "deploy" ]]
then
    CI_BUILD_ID="$CI_BUILD_ID"
    BUILD_TAG=""
    if [ "$2" != ""  ]
    then
        CI_BUILD_ID="$CI_BUILD_ID-$2"
        BUILD_TAG=":$2"
    fi
    echo "Deploying $CI_BUILD_ID..."


    echo "[Execute] .docker/.deploy-prepare.sh"
    . .docker/.deploy-prepare.sh
    CMD="docker build -t $CI_REGISTRY_IMAGE$BUILD_TAG -f .docker/Dockerfile ."
    echo "[Building] Starting '$CMD'";
    eval $CMD


    echo "$CI_JOB_TOKEN" | docker login -u gitlab-ci-token --password-stdin  $CI_REGISTRY

    docker push $CI_REGISTRY_IMAGE$BUILD_TAG

    echo "Push successfull... Calling .docker/.deploy.sh"
    . .docker/.deploy.sh

    echo "DONE!"

    exit
fi

if [[ $1 == "move" ]]
then
    echo "$CI_JOB_TOKEN" | docker login -u gitlab-ci-token --password-stdin  $CI_REGISTRY

    CMD="docker pull $CI_REGISTRY_IMAGE:latest"
    echo "[MOVE] Starting '$CMD'";
    eval $CMD

    CMD="docker tag $CI_REGISTRY_IMAGE:latest  $CI_REGISTRY_IMAGE:stable"
    echo "[MOVE] Starting '$CMD'";
    eval $CMD

    docker push $CI_REGISTRY_IMAGE:stable

    echo "Push successfull... Calling .docker/.deploy.sh"
    . .docker/.deploy.sh

    echo "DONE!"

    exit
fi


if [ "$VARIANT" == "" ]
then
    COMPOSER_FILE="./.docker/docker-compose.yml"
else
    COMPOSER_FILE="./.docker/docker-compose-$VARIANT.yml"
fi


echo "Using composer file '$COMPOSER_FILE'..."

if [[ ! -e $COMPOSER_FILE ]]
then
    echo "Composer file $COMPOSER_FILE not existing."
    exit 1
fi

if [[ $1 == "shell" ]]
then
    docker-compose -f $COMPOSER_FILE exec $MAIN_SERVICE /bin/bash
    exit
fi

## Lokales Entwickeln / gitlab-ci testing:

set +e
docker rm  $PROJECT_NAME
set -e


if [[ $1 == "setup-dev" ]]
then
    echo "Setting up... (Parameters: $@)";
    . ./.docker/.setup-dev.sh
    exit 0
fi



if [[ $1 == "helper-up" ]]
then
    echo "Starting helper services '$HELPER_SERVICES'";
    CMD="docker-compose -f $COMPOSER_FILE up $HELPER_SERVICES"
    echo "Running '$CMD'..."
    eval $CMD
    exit 0
fi

if [[ $1 == "down" ]]
then
    echo "Stopping all services";
    CMD="docker-compose -f $COMPOSER_FILE down --remove-orphans"
    echo "Running '$CMD'..."
    eval $CMD
    exit 0
fi

## BUILD CONTAINER!


COMPOSE_ARGS="";
if [[ $# > 1 ]]
then
    COMPOSE_ARGS='DEV_BUILD=1'
fi


echo "Starting image in interactive mode... (Parameters (#$#): $@)";
docker-compose -f $COMPOSER_FILE $COMPOSE_ARGS build

if [[ $1 == "unit-test" ]]
then
    echo "Starting image in unit-testing mode... (Parameters: $@)";
    CMD="docker-compose -f $COMPOSER_FILE run -T --service-ports $MAIN_SERVICE $1"
    echo "Running '$CMD'..."
    eval $CMD
    exit 0
fi


if (( $# < 1 ))
then
    CMD="docker-compose -f $COMPOSER_FILE up"
    echo "[NO PARAMETERS] Running '$CMD'..."
    eval $CMD
else
    echo "Starting manual service: $MAIN_SERVICE from Composer-File $COMPOSER_FILE (defined in .env)..."
    CMD="docker-compose -f $COMPOSER_FILE run -v $PWD/src:/kicksrc --service-ports $MAIN_SERVICE $1 $2 $3 $4 $5"
    echo "[WITH PARAMETERS] Running '$CMD'..."
    eval $CMD
fi


echo "Image closed...";