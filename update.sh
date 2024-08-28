#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 [--with-build] [--recreate-env] [--no-git-pull]"
    echo "  -h, --help      Display this help message"
    echo "  --with-build    Restart docker compose with build"
    echo "  --recreate-env  Recreate .env file from .env.sample"
    echo "  --no-git-pull   Skip pulling the repository"
    exit 0
}

# Parse command line options
SKIP_BUILD=true
SKIP_PULL=false
RECREATE_ENV_FILE=false

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -h|--help) usage ;;
        --with-build) SKIP_BUILD=false; shift ;;
        --recreate-env) RECREATE_ENV_FILE=true; shift ;;
        --no-git-pull) SKIP_PULL=true; shift ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

# find the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR" || exit  # change to the script directory

# update the repository
if [ "$SKIP_PULL" = false ]; then

    # check .git directory exists
    if [ ! -d .git ]; then
        echo "Git repository not found. Please clone the repository and try again."
        exit 1
    fi

    git checkout master
    git pull origin master
fi

# recreate the .env file if requested
if [ "$RECREATE_ENV_FILE" = true ]; then
    cp .env.sample .env
fi

# restart the docker containers with or without build
if [ "$SKIP_BUILD" = true ]; then
    echo "Starting Docker Compose without build..."
    docker compose up -d
else
    echo "Starting Docker Compose with build..."
    docker compose up --build -d
fi
