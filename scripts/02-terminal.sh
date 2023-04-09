#!/bin/bash
#set -x

sudo apt update -y

if [[ ! $(which starship) ]]; then
    echo "starship"
    curl -sS https://starship.rs/install.sh | sh
fi
echo "[ OK ] starship"

if [[ ! $(which tmux) ]]; then
    echo "tmux"
    sudo apt install tmux -y
fi
echo "[ OK ] tmux"

if [[ ! $(which lsd) ]]; then
    echo "lsd"
    wget -O lsd_amd64.deb https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
    sudo dpkg -i lsd_amd64.deb
fi
echo "[ OK ] lsd"

if [[ ! $(which batcat) ]]; then
    echo "batcat"
    sudo apt install bat -y
    echo "In ubuntu bat is batcat due to a name clash with another package: alias to bat"
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi
echo "[ OK ] batcat"

if [[ ! $(which fzf) ]]; then
    echo "fzf"
    sudo apt install fzf -y
fi
echo "[ OK ] fzf"

if [[ ! $(which rg) ]]; then
    echo "rg"
    sudo apt install ripgrep -y
fi
echo "[ OK ] ripgrep"
