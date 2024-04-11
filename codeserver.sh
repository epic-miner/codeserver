#!/bin/bash

# install nano text editor
sudo apt install nano

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Install Nano
sudo apt install nano

# Start Cloudflare tunnel
cloudflared tunnel --url localhost:6070 &

# Wait for tunnel to establish (optional, adjust sleep duration as needed)
sleep 5

# Start code-server in the background
code-server --port 6070 &

# Wait for 4 seconds
sleep 4

# Open code-server configuration file for editing with Nano
nano /root/.config/code-server/config.yaml
