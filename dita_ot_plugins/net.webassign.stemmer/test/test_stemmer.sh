#!/bin/sh -x

# Use passed value or default for location of DITA-OT

case "$#${DITA_DIR:-NOTSET}" in
    0NOTSET)    echo "0NOTSET"
                DITA_OT_DIR="/Users/staylor/Documents/Repos/build-techcomm/deps/DITA-OT1.8/" ;;
    1*)         echo "1"
                DITA_OT_DIR="$1" ;;
    0*)         echo "0"
                DITA_OT_DIR="${DITA_DIR}" ;;
esac

WORKING_DIR=$PWD

# Init Open Toolkit
# cd "${DITA_OT_DIR}"
# . ./startcmd.sh

cd "${WORKING_DIR}"
export ANT_HOME="$DITA_DIR"/tools/ant
$ANT_HOME/bin/ant -buildfile buildfile.xml

cd "${WORKING_DIR}"
