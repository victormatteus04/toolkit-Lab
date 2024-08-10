#!/bin/bash

# Update package list and install necessary dependencies
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y

# Create directory for keyrings
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker GPG key and save it
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository to Apt sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again to include Docker packages
sudo apt-get update

# Install Docker and related tools
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

# Set permissions on Docker socket
sudo chmod 777 /var/run/docker.sock

# Create systemd service file for Docker socket permissions
sudo bash -c 'cat <<EOF > /etc/systemd/system/docker-sock-permission.service
[Unit]
Description=Set full permissions to Docker socket

[Service]
Type=oneshot
ExecStart=/bin/chmod 777 /var/run/docker.sock

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd and enable the new service
sudo systemctl daemon-reload
sudo systemctl enable docker-sock-permission.service

# Add current user to the Docker group
sudo usermod -aG docker $USER

# Reboot the system to apply changes
# sudo reboot
