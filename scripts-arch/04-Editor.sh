#!/bin/bash
#set -x
sudo pacman -Syu --noconfirm

if [[ ! $(which nvim) ]];then
    echo "Neovim"
    yay -S neovim-nightly-bin --noconfirm
    sudo pacman -S xclip wl-clipboard --noconfirm
    npm install -g tree-sitter tree-sitter-cli
    echo "[ WARN ] Update editor in ~/.profile"
fi
echo "[ OK ] Neovim"
