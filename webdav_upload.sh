#!/bin/bash

if [ "$#" != "4" ]; then
    echo Use the following syntax:
    echo "webdav_upload.sh username password local_filepath remote_URL"
    echo
    echo For example:
    echo "webdav_upload.sh billybob R3dn3ck ~/cheetos http://youmightbearedneckif.com/food/"
    exit 1
fi
WDUSER=$1:$2
WDFILE=$3
WDURL=$4

 
echo "<h1>Uploading ${WDFILE} to ${WDURL}</h1>"
for THISFILE in $(find ${WDFILE} )
do
    THISURL="${WDURL}${THISFILE#"${WDFILE}"}"
 
    echo "${THISFILE} -> ${THISURL}"
 
    if [ -d ${THISFILE} ]
    then
        echo "<h2>Create ${THISURL}</h2>"
        curl -sS --request MKCOL  --user "${WDUSER}" "${THISURL}"
    else
        echo "${THISFILE} -> ${THISURL}"
        curl -sS --upload-file "${THISFILE}" --user "${WDUSER}" "${THISURL}"
    fi
 
done