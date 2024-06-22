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

# Check if localtunnel is installed
if ! command_exists lt; then
    echo "Installing localtunnel..."
    npm install -g localtunnel
else
    echo "localtunnel is already installed."
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

# Start localtunnel on port 6070 in the background and save the tunnel URL
echo "Starting localtunnel..."
lt --port 6070 & TUNNEL_URL=$(wget -q -O - https://loca.lt/mytunnelpassword)

# Wait for localtunnel to start
sleep 5

# Start code-server on port 6070 with no authentication
echo "Starting code-server..."
code-server --port 6070 --auth none &

# Wait for code-server to start
sleep 4

# Display code-server configuration
echo "Displaying code-server configuration..."
#cat ~/.config/code-server/config.yaml

# Display the tunnel URL
echo "Your code-server is available at: $TUNNEL_URL"
