#!/bin/bash

wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -0 cloudflared
 
chmod +x cloudflared
 
sudo mv cloudflared /usr/local/bin/

curl -fsSL https://code-server.dev/install.sh | sh

sudo apt install nano

cloudflared tunnel --url localhost:6070 &

sleep 5

code-server --port 6070 &

sleep 4

nano /root/.config/code-server/config.yaml
