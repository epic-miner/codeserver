#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update package list
sudo apt update

# Check if Node.js is installed
if ! command_exists node; then
    echo "Installing Node.js and npm..."
    sudo apt install -y nodejs npm
else
    echo "Node.js and npm are already installed."
fi

# Check if code-server is installed
if ! command_exists code-server; then
    echo "Installing code-server..."
    curl -fsSL https://code-server.dev/install.sh | sh
else
    echo "code-server is already installed."
fi

# Check if nano is installed (optional)
if ! command_exists nano; then
    echo "Installing nano..."
    sudo apt install -y nano
else
    echo "nano is already installed."
fi

# Install and set up ngrok
if ! command_exists ngrok; then
    echo "Downloading and installing ngrok..."
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xvf ngrok-v3-stable-linux-amd64.tgz
    sudo mv ngrok /usr/local/bin/
fi

# Authenticate ngrok
echo "Authenticating ngrok..."
ngrok authtoken 2dVYRMCgTJgYBiE2NVivf2hJ0Ec_3dbwCA2pvqMkmQ5kZSs71

# Start ngrok on port 6070
echo "Starting ngrok..."
ngrok http 6070 & NGROK_PID=$!

# Wait for ngrok to start
sleep 5

# Start code-server on port 6070 with no authentication
echo "Starting code-server..."
code-server --port 6070 --auth none &
CODE_SERVER_PID=$!
sleep 4

# Display the ngrok URL
echo "Your ngrok URL is:"
curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url'

# Optionally, display code-server configuration
# echo "Displaying code-server configuration..."
# cat ~/.config/code-server/config.yaml
