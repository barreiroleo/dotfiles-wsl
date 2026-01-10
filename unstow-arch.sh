#!/bin/bash
#set -x

if [[ ! $(which stow) ]]; then
    sudo pacman -S stow
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
apply opencode "[ OK ] opencode"
apply i3 "[ OK ] i3"
apply niri "[ OK ] niri"
apply hypr "[ OK ] hypr"
apply sway "[ OK ] sway"
git stash apply
git stash clear
