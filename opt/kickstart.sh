#!/bin/bash
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# DO NOT EDIT THIS FILE! CHANGES WILL BE OVERWRITTEN ON UPDATE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Send feature requests for https://github.com/dermatthes/pipf-php
#
# PIPF Kickstarter
#
# Copy this file into your project folder
#
# See https://github.com/continue/kickstart for more information



# Error Handling.
trap 'on_error $LINENO' ERR;
PROGNAME=$(basename $0)
PROGPATH="$( cd "$(dirname "$0")" ; pwd -P )"   # The absolute path to kickstart.sh

function on_error () {
    echo "Error: ${PROGNAME} on line $1" 1>&2
    exit 1
}



CONTAINER_NAME=${PWD##*/}

export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

command -v curl >/dev/null 2>&1 || { echo -e "$COLOR_LIGHT_RED I require curl but it's not installed (run: 'apt-get install curl').  Aborting.$COLOR_NC" >&2; exit 1; }
command -v docker >/dev/null 2>&1 || { echo -e "$COLOR_LIGHT_RED I require docker but it's not installed (see http://docker.io).  Aborting.$COLOR_NC" >&2; exit 1; }

KICKSTART_DOC_URL="https://github.com/c7lab/kickstart/"
KICKSTART_UPGRADE_URL="https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart.sh"
KICKSTART_RELEASE_NOTES_URL="https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart-release-notes.txt"
KICKSTART_VERSION_URL="https://raw.githubusercontent.com/c7lab/kickstart/master/opt/kickstart-release.txt"

KICKSTART_CURRENT_VERSION="1.1.0"




_usage() {
    echo -e $COLOR_NC "Usage: $0 [<command>]

    COMMANDS:

        $0 [dev|<command>]
            Run kick <command> and start bash inside container (development mode)

        $0 run <command>
            Execute kick <command> and return (unit-testing)


    EXAMPLES

        $0              Just start a shell inside the container (default development usage)
        $0 run test     Execute commands defined in section 'test' of .kick.yml

    ARGUMENTS
        -t <tagName> --tag=<tagname>   Run container with this tag (development)
        -u --unflavored                Run the container whithout running any scripts (develpment)
        --upgrade                      Search / Install new kickstart version

    "
    exit 1
}


_print_header() {
    echo -e $COLOR_WHITE "

 C7Lab's
   ▄█   ▄█▄  ▄█   ▄████████    ▄█   ▄█▄    ▄████████     ███        ▄████████    ▄████████     ███
  ███ ▄███▀ ███  ███    ███   ███ ▄███▀   ███    ███ ▀█████████▄   ███    ███   ███    ███ ▀█████████▄
  ███▐██▀   ███▌ ███    █▀    ███▐██▀     ███    █▀     ▀███▀▀██   ███    ███   ███    ███    ▀███▀▀██
 ▄█████▀    ███▌ ███         ▄█████▀      ███            ███   ▀   ███    ███  ▄███▄▄▄▄██▀     ███   ▀
▀▀█████▄    ███▌ ███        ▀▀█████▄    ▀███████████     ███     ▀███████████ ▀▀███▀▀▀▀▀       ███
  ███▐██▄   ███  ███    █▄    ███▐██▄            ███     ███       ███    ███ ▀███████████     ███
  ███ ▀███▄ ███  ███    ███   ███ ▀███▄    ▄█    ███     ███       ███    ███   ███    ███     ███
  ███   ▀█▀ █▀   ████████▀    ███   ▀█▀  ▄████████▀     ▄████▀     ███    █▀    ███    ███    ▄████▀
  ▀                           ▀                                                 ███    ███
                                                                                      happy containers
  " $COLOR_YELLOW "
+-------------------------------------------------------------------------------------------------------+
| C7Lab Kickstart - DEVELOPER MODE                                                                      |
| Version: $KICKSTART_CURRENT_VERSION
| Flavour: $USE_PIPF_VERSION (defined in 'from:'-section of .kick.yml)"



    KICKSTART_NEWEST_VERSION=`curl -s "$KICKSTART_VERSION_URL"`
    if [ "$KICKSTART_NEWEST_VERSION" != "$KICKSTART_CURRENT_VERSION" ]
    then
        echo "|                                                           "
        echo "| UPDATE AVAILABLE: Head Version: $KICKSTART_NEWEST_VERSION"
        echo "| To Upgrade Version: Run ./kickstart.sh --upgrade                              "
        echo "|                                                                                 "
    fi;

    echo "| More information: https://github.com/continue/kickstart                         "
    echo "| Or ./kickstart.sh help                                                                                |"
    echo "+-------------------------------------------------------------------------------------------------------+"

}


run_shell() {
   echo -e $COLOR_CYAN;
   echo "[kickstart.sh] Container '$CONTAINER_NAME' already running"
   echo "===> [kickstart.sh] Opening new shell: "
   echo -e $COLOR_NC

   docker exec -it --user user -e "DEV_TTYID=[SUB]" $CONTAINER_NAME /bin/bash

   echo -e $COLOR_CYAN;
   echo "<=== [kickstart.sh] Leaving container."
   echo -e $COLOR_NC
   exit
}


ask_user() {
    echo "";
    read -r -p "$1 (y|N)" choice
    case "$choice" in
      n|N)
        echo "Abort!";
        ;;
      y|Y)
        return 0;
        ;;

      *)
        echo 'Response not valid';;
    esac
    exit 1;
}


run_container() {
    echo -e $COLOR_GREEN"Loading container '$USE_PIPF_VERSION'..."
    docker pull "$USE_PIPF_VERSION"

    docker rm $CONTAINER_NAME
    echo -e $COLOR_WHITE "==> [$0] STARTING CONTAINER (docker run): Running container in dev-mode..." $COLOR_NC
    docker run -it                                      \
        -v "$PROGPATH/:/opt/"                           \
        -e "DEV_CONTAINER_NAME=$CONTAINER_NAME"         \
        -e "DEV_TTYID=[MAIN]"                           \
        -e "DEV_UID=$UID"                               \
        -e "DEV_MODE=1"                                 \
        -p 80:4200                                      \
        -p 9000:9000                                    \
        --name $CONTAINER_NAME                          \
        $USE_PIPF_VERSION $ARGUMENT

    status=$?
    if [[ $status -ne 0 ]]
    then
        echo -e $COLOR_RED
        echo "[kickstart.sh][FAIL]: Container startup failed."
        echo "[kickstart.sh][FAIL]: Make sure you have Port 80 free and docker installed correctly."
        echo -e $COLOR_NC
        exit $status
    fi;
    echo -e $COLOR_WHITE "<== [kickstart.sh] CONTAINER SHUTDOWN"
    echo -e $COLOR_RED "    Kickstart Exit - Goodbye" $COLOR_NC
    exit 0;
}


if [ ! -f "$PROGPATH/.kick.yml" ]
then
    echo -e $COLOR_RED "[ERR] Missing $PROGPATH/.kick.yml file." $COLOR_NC
    ask_user "Do you want to create a new .kick.yml-file?"
    echo "version: 1" > $PROGPATH/.kick.yml
    echo 'from: "continue/kickstart:latest"' >> $PROGPATH/.kick.yml
    echo "File created. See $KICKSTART_DOC_URL for more information";
    echo ""
    sleep 2
fi



# Parse .kick.yml for line from: "docker/container:version"
USE_PIPF_VERSION=`cat $PROGPATH/.kick.yml | sed -n 's/from\: "\(.\+\)\"/\1/p'`

if [ "$USE_PIPF_VERSION" == "" ]
then
    echo -e $COLOR_RED "[ERR] .kick.yml file does not include 'from:' - directive." $COLOR_NC
    exit 2
fi;


# Parse the command parameters
ARGUMENT="";
while [ "$#" -gt 0 ]; do
  case "$1" in
    -t) USE_PIPF_VERSION="-t $2"; shift 2;;
    --tag=*) USE_PIPF_VERSION="-t ${1#*=}"; shift 1;;

    --upgrade)
        echo "Checking for updates from $KICKSTART_UPGRADE_URL..."
        curl "$KICKSTART_RELEASE_NOTES_URL"

        ask_user "Do you want to upgrade?"

        echo "Writing to $0..."
        curl "$KICKSTART_UPGRADE_URL" -o "$0"
        echo "Done"
        echo "Calling on update trigger: $0 --on-after-update"
        $0 --on-after-upgrade
        echo -e "$COLOR_GREEN[kickstart.sh] Upgrade successful.$COLOR_NC"
        exit 0;;

    --on-after-upgrade)
        exit 0;;

    -h|--help)
        _usage
        exit 0;;

    --tag) echo "$1 requires an argument" >&2; exit 1;;

    -*) echo "unknown option: $1" >&2; exit 1;;

    *)  break;

  esac
done

ARGUMENT=$@;
_print_header
if [ `docker ps | grep "$CONTAINER_NAME" | wc -l` -gt 0 ]
then
    run_shell
fi;
run_container