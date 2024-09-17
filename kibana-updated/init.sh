#!/bin/bash

# Update the package list and install vim and net-tools
apt update && apt install -y vim net-tools

# Check if vim and net-tools are installed successfully
if command -v vim >/dev/null 2>&1 && command -v netstat >/dev/null 2>&1; then
  echo "vim and net-tools installed successfully"
else
  echo "Installation failed"
  exit 1
fi

# Execute the main container command
exec "$@"
