#A docker setup script in bash shell

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
sudo apt install -y  docker-ce

echo "Creating Docker group"
sudo groupadd docker

echo "Adding user to Docker group"
sudo usermod -aG docker mateusz

echo "Starting Docker deamon"
sudo systemctl start docker

echo "Checking Docker version"
sudo docker --version

echo "Installation Docker successfully."

 
