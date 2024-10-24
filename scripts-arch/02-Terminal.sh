#!/bin/bash
#set -x
sudo pacman -Syu --noconfirm

if [[ ! $(which starship) ]];then
    echo "starship"
    curl -sS https://starship.rs/install.sh | sh
fi
echo "[ OK ] starship"

if [[ ! $(which tmux) ]]; then
    echo "tmux"
    sudo pacman -S tmux --noconfirm
fi
echo "[ OK ] tmux"

if [[ ! $(which lsd) ]]; then
    echo "lsd"
    sudo pacman -S lsd --noconfirm
fi
echo "[ OK ] lsd"

if [[ ! $(which bat) ]]; then
    echo "batcat"
    sudo pacman -S bat --noconfirm
fi
echo "[ OK ] batcat"

if [[ ! $(which fzf) ]]; then
    echo "fzf"
    sudo pacman -S fzf --noconfirm
fi
echo "[ OK ] fzf"

if [[ ! $(which rg) ]]; then
    echo "rg"
    sudo pacman -S ripgrep-all --noconfirm
fi
echo "[ OK ] ripgrep"
