#!/bin/bash
#set -x

sudo apt update -y

if [[ ! -d ~/.local/share/fonts/jetbrains ]]; then
    echo "JetBrains"
    mkdir -p /tmp/fonts/jetbrains/ ~/.local/share/fonts/jetbrains/ ~/.local/share/fonts/iosevka/
    wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O /tmp/fonts/JetBrainsMono.zip
    wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip -O /tmp/fonts/Iosevka.zip
    unzip -q /tmp/fonts/JetBrainsMono.zip -d /tmp/fonts/jetbrains/
    unzip -q /tmp/fonts/Iosevka.zip -d /tmp/fonts/iosevka/
    mv /tmp/fonts/jetbrains/*.ttf ~/.local/share/fonts/jetbrains/
    mv /tmp/fonts/iosevka/*.ttf ~/.local/share/fonts/iosevka/
    fc-cache -fv
fi
echo "[ OK ] Fonts"


if [[ ! $(which ghostty) ]]; then
    echo "Ghostty"
    sudo snap install ghostty --classic
fi
echo "[ OK ] Ghostty"

if [[ ! $(which nvim) ]]; then
    echo "Nvim"
    sudo snap install nvim --edge --classic
    sudo apt install wl-clipboard xclip -y
fi
echo "[ OK ] Nvim"


if [[ ! $(which lazygit) ]]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
fi
