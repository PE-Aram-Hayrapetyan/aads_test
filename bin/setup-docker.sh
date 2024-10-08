#!/usr/bin/env sh

if ! command -v docker &> /dev/null
then
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "Docker is already installed"
fi
if ! docker run hello-world &> /dev/null
then
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
fi
docker run hello-world || exit 64

sudo apt-get update
sudo apt-get install curl wget nano build-essential libssl-dev libreadline-dev zlib1g-dev autoconf bison libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libpq-dev postgresql-client-16 -y
