#!/bin/bash

# Update the package list and install vim, net-tools, and ping (iputils-ping)
apt update && apt install -y vim net-tools iputils-ping

# Check if vim, net-tools, and ping are installed successfully
if command -v vim >/dev/null 2>&1 && command -v netstat >/dev/null 2>&1 && command -v ping >/dev/null 2>&1; then
  echo "vim, net-tools, and ping installed successfully"
else
  echo "Installation failed"
  exit 1
fi

# Execute the main container command
exec "$@"
