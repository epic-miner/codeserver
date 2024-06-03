#!/bin/bash
sudo apt update
sudo apt install nodejs npm -y
# Download and install localtunnel
npm install -g localtunnel

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Install nano (optional)
sudo apt update
sudo apt install nano

# Start local Tunnel
lt --port 6070 & wget_output=$(wget -q -O - https://loca.lt/mytunnelpassword)

# Extract password and public URL
tunnel_password=$(echo "$wget_output" | grep -oP '(?<=Tunnel established at ).*(?= (https))')
public_url=$(echo "$wget_output" | grep -oP 'https://.*')

# Display tunnel password and public URL
echo "LocalTunnel Password: $tunnel_password"
echo "Public URL: $public_url"

# Start code-server
code-server --port 6070 --auth none

# Wait for code-server to start
sleep 4

# Display code-server configuration
cat ~/.config/code-server/config.yaml
