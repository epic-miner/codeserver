
Copy code
#!/bin/bash
#sudo apt update
#sudo apt install nodejs npm -y
# Download and install localtunnel
npm install -g localtunnel

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Install nano (optional)
sudo apt update
sudo apt install nano

# Start local Tunnel
lt --port 6070 & wget -q -O - https://loca.lt/mytunnelpassword

# Wait for local Tunnel to start
sleep 5

# Start code-server
code-server --port 6070 --auth none

# Wait for code-server to start
sleep 4

# Display code-server configuration
cat ~/.config/code-server/config.yaml
