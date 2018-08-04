#!/bin/bash

set -e
export PAN_CREDENTIALS_DBFILE=/opt/pancloud/credentials.json

if [[ -z "${APIEXPLORER_DEBUG}" ]]; then
    exec python3.6 /opt/apiexplorer/run.py -p $*
else
    exec python3.6 /opt/apiexplorer/run.py -d -P 5000 -S $*
fi

