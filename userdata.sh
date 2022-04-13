#!/bin/bash
echo "Installing Docker"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io awscli wget nano mc
sudo usermod -a -G docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
cd /home/ubuntu/
wget https://assets.ubuntu.com/v1/e2047558-pictogram-knowledge-orange-white-background.svg
mv e2047558-pictogram-knowledge-orange-white-background.svg mascot.svg
