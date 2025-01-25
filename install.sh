#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 [--no-install] [--no-configure] [--no-clone]"
    echo "  -h, --help       Display this help message"
    echo "  --no-clone       Skip cloning the repository"
    echo "  --no-configure   Skip configuring dnsmasq and resolver"
    echo "  --no-install     Skip installing Homebrew and dnsmasq"
    exit 0
}

# Parse command line options
SKIP_INSTALL=false
SKIP_CONFIGURE=false
SKIP_CLONE=false

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -h|--help) usage ;;
        --no-install) SKIP_INSTALL=true; shift ;;
        --no-configure) SKIP_CONFIGURE=true; shift ;;
        --no-clone) SKIP_CLONE=true; shift ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please install Docker and try again."
    exit 1
fi

if ! command -v brew &> /dev/null; then
    if [ "$SKIP_INSTALL" = false ]; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew not found. Please install Homebrew and try again."
        exit 1
    fi
fi

if ! command -v dnsmasq &> /dev/null; then
    if [ "$SKIP_INSTALL" = false ]; then
        echo "dnsmasq not found. Installing dnsmasq..."
        brew install dnsmasq
    else
        echo "dnsmasq not found. Please install dnsmasq and try again."
        exit 1
    fi
fi

configure_dns() {
    # Configure dnsmasq
    CONFIG_LINE="address=/.local/127.0.0.1"
    CONFIG_FILE="$(brew --prefix)/etc/dnsmasq.conf"

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
}

# Check if --no-configure option is set
if [ "$SKIP_CONFIGURE" = false ]; then
    configure_dns
fi

# Check if --no-clone option is set
if [ "$SKIP_CLONE" = true ]; then
    echo "Skipping repository cloning."
    exit 0
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
echo "Cloning the repository from $REPO_URL..."

# Clone the repository
FOLDER_NAME="mosstar-dev-stack"
git clone $REPO_URL $FOLDER_NAME

# Check if the repository is cloned successfully
if [ -d "$FOLDER_NAME" ]; then
    cd $FOLDER_NAME || exit
    # Copy the sample .env file
    cp .env.sample .env
    # Start Docker Compose
    docker compose up --build -d
else
    echo "The git clone command didn't work properly. Please check the repository address and try again."
    exit 1
fi
