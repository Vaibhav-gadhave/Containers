#!/bin/bash

# Check if a username is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
PASSWORD=ABCde1234567

# Create the user with a home directory and set a password
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Check if the user was created successfully
if [ $? -ne 0 ]; then
    echo "Failed to create user $USERNAME. User might already exist."
    exit 1
fi

# Get the home directory of the user
USER_HOME=$(eval echo ~$USERNAME)

# Create the "chromium" directory inside the user's home
mkdir -p "$USER_HOME/chromium"

# Get the UID and GID of the user
USER_UID=$(id -u "$USERNAME")
USER_GID=$(id -g "$USERNAME")

# Set ports dynamically based on UID
PORT1=$USER_UID
PORT2=$((USER_UID + 1))  # Assigning the next port

# Create the docker-compose.yml file with dynamic UID, GID, and ports
cat <<EOF > "$USER_HOME/chromium/docker-compose.yml"
---
services:
  chromium:
    image: lscr.io/linuxserver/chromium:latest
    container_name: chromium-$USERNAME
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=$USER_UID
      - PGID=$USER_GID
      - TZ=Etc/UTC
      - CHROME_CLI=https://www.google.com/ #optional
    volumes:
      - ./config:/config
    ports:
      - $PORT1:3000
#      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped
EOF

# Set correct ownership and permissions
chown -R "$USERNAME:$USERNAME" "$USER_HOME/chromium"
chmod 755 "$USER_HOME/chromium/docker-compose.yml"

# Run Docker Compose as root (since the user has no permissions)
docker compose -f "$USER_HOME/chromium/docker-compose.yml" up -d

echo "User $USERNAME created successfully!"
echo "Password: $PASSWORD"
echo "Configuration directory: $USER_HOME/chromium"
echo "Docker Compose file created at: $USER_HOME/chromium/docker-compose.yml"
echo "Permissions set to 755"
echo "Docker Compose started in the background by root."
echo "Assigned Ports: 192.168.160.91:$PORT1"
