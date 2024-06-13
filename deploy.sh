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

# Ask user to choose the clone method
read -p "Clone yöntemi olarak SSH mı yoksa HTTP mi kullanmak istersiniz? (default: HTTP): " CLONE_METHOD

# Set default value for clone method
if [ -z "$CLONE_METHOD" ]; then
    CLONE_METHOD="HTTP"
fi

# Set GitHub repository address
if [ "$CLONE_METHOD" == "SSH" ] || [ "$CLONE_METHOD" == "ssh" ]; then
    REPO_URL="git@github.com:mosstar/dev-stack.git"
else
    REPO_URL="https://github.com/mosstar/dev-stack"
fi

# Print repository address
echo "Repository Address: $REPO_URL"

REPO_NAME=$(basename $REPO_URL .git)
FOLDER_NAME="mosstar-dev-stack"

# Clone the repository
git clone $REPO_URL $FOLDER_NAME

# Check if the repository is cloned successfully
if [ -d "$FOLDER_NAME" ]; then
    cd $FOLDER_NAME
    docker-compose up --build -d
else
    echo "Klonlama başarısız oldu. Lütfen repo adresini kontrol edin ve tekrar deneyin."
    exit 1
fi
