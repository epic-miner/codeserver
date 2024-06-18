# Development Environment Setup Script

This repository contains a bash script to set up a development environment with Node.js, npm, localtunnel, and code-server on a Linux system. The script also includes an optional installation of the nano text editor.

## Features

- **Checks for Existing Installations**: The script checks if Node.js, npm, localtunnel, code-server, and nano are already installed and skips installation if they are present.
- **Automated Setup**: It installs required software, sets up a local tunnel, and starts code-server with no authentication.
- **Configurable and Extensible**: The script can be easily modified to add or remove components as needed.

## Prerequisites

- A Linux-based operating system
- `sudo` privileges to install software packages

## Usage

1. Clone this repository:
    ```sh
    git clone https://github.com/yourusername/your-repo-name.git
    cd your-repo-name
    ```

2. Make the script executable:
    ```sh
    chmod +x setup.sh
    ```

3. Run the script:
    ```sh
    ./setup.sh
    ```

The script will:
- Update the package list.
- Install Node.js and npm if they are not already installed.
- Install localtunnel globally using npm if it is not already installed.
- Install code-server if it is not already installed.
- Optionally install nano if it is not already installed.
- Start a local tunnel on port 6070 and save the tunnel URL.
- Start code-server on port 6070 with no authentication.
- Display the code-server configuration and the tunnel URL.

## Script Details

```bash
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
cat ~/.config/code-server/config.yaml

# Display the tunnel URL
echo "Your code-server is available at: $TUNNEL_URL"