#!/bin/bash
CONTAINER_INITIALIZED=".container_initialized"
if [[ ! -e $CONTAINER_INITIALIZED ]]
then
    echo "Starting first time initialization..."
    echo $GITHUB_URL
    echo $GITHUB_TOKEN  
    ./config.sh --unattended --url $GITHUB_URL --token $GITHUB_TOKEN
    touch $CONTAINER_INITIALIZED
    echo "Completed first time initialization!"
fi
./run.sh