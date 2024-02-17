#!/bin/bash
# set -x

if [[ ! $(which docker) ]]; then
    sudo pacman -S docker docker-compose
    echo "[Docker] Test"
    sudo docker run hello-world
fi
echo "[ OK ] Docker Engine"

if [[ ! $(which lazydocker) ]]; then
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi
echo "[ OK ] Lazydocker"
