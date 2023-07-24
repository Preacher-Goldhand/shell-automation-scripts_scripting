#!/bin/bash
#Docker setup script in bash shell
user="mateusz"

echo "Updating packages..."
sudo apt update

echo "Installing packages of repository by HTTPS..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding GPG key to Docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Adding Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Specifying installation source"
sudo apt-cache policy docker-ce

echo "Installing Docker"
sudo apt install -y docker-ce

# Check if the Docker group exists
if ! grep -q '^docker:' /etc/group; then
  echo "Creating Docker group"
  sudo groupadd docker
else
  echo "Docker group already exists"
fi

# Check if the user exists
if id "$user" &>/dev/null; then
  echo "User $user already exists"
else
  echo "User $user does not exist. Please create the user before proceeding."
  exit 1
fi

echo "Adding user to Docker group"
sudo usermod -aG docker "$user"

echo "Starting Docker daemon"
sudo systemctl start docker
echo "Checking Docker version"
sudo docker --version

echo "Docker installation completed successfully."
