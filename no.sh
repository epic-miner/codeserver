#!/bin/bash

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

code-server --port 6070 --auth none

# Wait for code-server to start
sleep 4

# Display code-server configuration
cat ~/.config/code-server/config.yaml
git clone https://github.com/epic-miner/option.git
cd option
sh nglt.sh
