#!/bin/bash

# find the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR" || exit  # change to the script directory

# check .git directory exists
if [ ! -d .git ]; then
    echo "Git repository not found. Please clone the repository and try again."
    exit 1
fi

# update the repository
git checkout master
git pull origin master

# restart the docker containers with or without build
if [[ "$1" == "--with-build" ]]; then
    echo "Starting Docker Compose with build..."
    docker-compose up --build -d
else
    echo "Starting Docker Compose without build..."
    docker-compose up -d
fi
