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

# Install and set up ngrok if needed
if ! command_exists ngrok; then
    echo "Downloading and installing ngrok..."
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xvf ngrok-v3-stable-linux-amd64.tgz
    sudo mv ngrok /usr/local/bin/
fi

# Prompt user for tunnel option
echo "Choose a tunnel option:"
echo "1. Localtunnel"
echo "2. Ngrok"
read -p "Enter option (1 or 2): " TUNNEL_OPTION

case $TUNNEL_OPTION in
    1)
        # Start localtunnel on port 6070 in the background and save the tunnel URL
        echo "Starting localtunnel..."
        lt --port 6070 & LT_PID=$!
        sleep 5
        LT_URL=$(curl -s https://loca.lt/mytunnelpassword)
        echo "Localtunnel started."
        ;;
    2)
        # Authenticate ngrok
        echo "Authenticating ngrok..."
        ngrok authtoken 2dVYRMCgTJgYBiE2NVivf2hJ0Ec_3dbwCA2pvqMkmQ5kZSs71
        
        # Start ngrok on port 6070
        echo "Starting ngrok..."
        ngrok http 6070 & NGROK_PID=$!
        sleep 5
        echo "Ngrok started."
        ;;
    *)
        echo "Invalid option selected. Exiting."
        exit 1
        ;;
esac

# Start code-server on port 6070 with no authentication
echo "Starting code-server..."
code-server --port 6070 --auth none &
CODE_SERVER_PID=$!
sleep 4

# Display tunnel URLs based on the selected option
if [ "$TUNNEL_OPTION" -eq 1 ]; then
    echo "Your localtunnel URL is: $LT_URL"
elif [ "$TUNNEL_OPTION" -eq 2 ]; then
    echo "Your ngrok URL is:"
    curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url'
fi

# Optionally, display code-server configuration
# echo "Displaying code-server configuration..."
# cat ~/.config/code-server/config.yaml
