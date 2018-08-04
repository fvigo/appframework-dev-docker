#!/bin/bash

set -e

# Start API Explorer
echo "Starting API Explorer in the background"
/usr/local/bin/start-apiexplorer.sh  &

# Start Notebook
echo "Starting notebook in the foreground"
/usr/local/bin/start-notebook.sh $* 
