#!/bin/bash

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "Docker bulunamadı. Lütfen Docker'ı yükleyin ve tekrar deneyin."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose bulunamadı. Lütfen Docker Compose'u yükleyin ve tekrar deneyin."
    exit 1
fi

# GitHub repository URL
REPO_URL="https://github.com/mosstar/dev-stack.git"
REPO_NAME=$(basename $REPO_URL .git)

# Clone the repository
git clone $REPO_URL

# Check if the repository is cloned successfully
if [ -d "$REPO_NAME" ]; then
    cd $REPO_NAME
    docker-compose up -d
else
    echo "Klonlama başarısız oldu. Lütfen repo adresini kontrol edin ve tekrar deneyin."
    exit 1
fi
