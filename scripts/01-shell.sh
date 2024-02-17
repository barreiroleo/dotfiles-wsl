#!/bin/bash
#set -x

if [[ ! $(which xdg-open) ]]; then
    sudo pacman -Sy xdg-utils
fi
if [[ ! $(which wslview) ]]; then
    curl -O https://pkg.wslutiliti.es/public.key
    sudo pacman-key --add public.key
    sudo pacman-key --init
    sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
    echo -e "\n[wslutilities]\nServer = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy wslu
fi
echo "[ OK ] WSL view browser"

if [[ ! "$LANG" == "es_AR.UTF8" ]]; then
    echo "Actual locale: $LANG"
    sudo locale-gen "es_AR.UTF-8" "en_US.UTF-8"
    echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
fi
echo "[ OK ] Locale configured es_AR.UTF-8"

if [[ ! $(which zsh) ]]; then
    echo "ZSH"
    sudo pacman -Sy zsh
fi
echo "[ OK ] ZSH"

if [[ ! -d ~/.oh-my-zsh/ ]]; then
    echo "ZSH Oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi
echo "[ OK ] ZSH Oh my zsh"

DIR=~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [[ ! -d "$DIR" ]]; then
    echo "ZSH Syntax highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
echo "[ OK ] ZSH Syntax highlighting"

DIR=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
if [[ ! -d "$DIR" ]]; then
    echo "ZSH Autosuggestion"
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
echo "[ OK ] ZSH Autosuggestion"

if [[ ! $SHELL == /usr/bin/zsh && ! $SHELL == /bin/zsh ]]; then
    echo "ZSH by default"
    chsh -s /bin/zsh
fi
echo "[ OK ] ZSH by default"
