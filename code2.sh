#!/bin/bash

# Install localtunnel
npm install -g localtunnel

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Install nano (optional)
apt update
apt install nano -y

# Start local Tunnel
lt --port 6070 &

# Wait for local Tunnel to start
sleep 5

# Start code-server
code-server --port 6070 & wget -q -O - https://loca.lt/mytunnelpassword

# Wait for code-server to start
sleep 4

# Display code-server configuration
cat ~/.config/code-server/config.yaml

# Infinite loop to keep notebook active
while true
do
    echo "Notebook is active"
    # Perform a resource-intensive operation to keep the notebook active
    yes > /dev/null
done
