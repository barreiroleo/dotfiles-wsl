#!/bin/bash
#set -x

if [[ ! $(which stow) ]]; then
    sudo apt update -y
    sudo apt-get --no-install-recommends install stow
fi
echo "[ OK ] Stow"

function apply(){
    pack=$1
    msg=$2
    stow --adopt -v $pack
    git restore .
    stow --restow -v $pack
    echo $msg
    echo
}

git stash
apply shell "[ OK ] zsh, bash, profile"
apply nvim "[ OK ] nvim"
apply tmux "[ OK ] tmux"
apply wezterm "[ OK ] wezterm"
apply ghostty "[ OK ] ghostty"
git stash apply
git stash clear
