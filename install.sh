#!/bin/bash

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please install Docker and try again."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose not found. Please install Docker Compose and try again."
    exit 1
fi

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v dnsmasq &> /dev/null; then
    echo "dnsmasq not found. Installing dnsmasq..."
    brew install dnsmasq
fi

# Configure dnsmasq
CONFIG_LINE="address=/.local/127.0.0.1"
CONFIG_FILE="/opt/homebrew/etc/dnsmasq.conf"

if ! grep -qxF "$CONFIG_LINE" "$CONFIG_FILE"; then
    echo "Adding configuration to dnsmasq..."
    echo "$CONFIG_LINE" | sudo tee -a "$CONFIG_FILE"
fi

sudo brew services restart dnsmasq

# Configure DNS resolver
RESOLVER_DIR="/etc/resolver"
RESOLVER_FILE="$RESOLVER_DIR/local"
RESOLVER_CONTENT="nameserver 127.0.0.1"

sudo mkdir -p "$RESOLVER_DIR"

if ! grep -qxF "$RESOLVER_CONTENT" "$RESOLVER_FILE"; then
    echo "Configuring DNS resolver for .local domains..."
    echo "$RESOLVER_CONTENT" | sudo tee "$RESOLVER_FILE"
fi

# Ask user to choose the clone method
read -p "Would you like to use SSH or HTTP as the clone method? (default: HTTP): " CLONE_METHOD

# Set default value for clone method
if [ -z "$CLONE_METHOD" ]; then
    CLONE_METHOD="HTTP"
fi

# Set GitHub repository address
if [ "$CLONE_METHOD" == "SSH" ] || [ "$CLONE_METHOD" == "ssh" ]; then
    REPO_URL="git@github.com:mosstar/mosstar-dev-stack.git"
else
    REPO_URL="https://github.com/mosstar/mosstar-dev-stack"
fi

# Print repository address
echo "Repository Address: $REPO_URL"

FOLDER_NAME="mosstar-dev-stack"

# Clone the repository
git clone $REPO_URL $FOLDER_NAME

# Check if the repository is cloned successfully
if [ -d "$FOLDER_NAME" ]; then
    cd $FOLDER_NAME
    docker-compose up --build -d
else
    echo "The git clone command didn't work properly. Please check the repository address and try again."
    exit 1
fi
