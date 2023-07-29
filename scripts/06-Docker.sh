#!/bin/bash
# set -x

if [[ ! $(which docker) ]]; then
    sudo apt update
    sudo apt install ca-certificates curl gnupg

    echo "[Docker] GPG key"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "[Docker] Set up repository"
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

	echo "[Docker] Engine"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	echo "[Docker] Test"
	sudo docker run hello-world
fi
echo "[ OK ] Docker Engine"

if [[ ! $(docker compose version) ]]; then
    sudo apt install docker-compose-plugin
	echo "[Docker] Docker compose"
fi
echo "[ OK ] Docker compose"

if [[ ! $(which lazydocker) ]]; then
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi
echo "[ OK ] Lazydocker"
