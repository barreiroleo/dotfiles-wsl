#!/bin/bash

USER="leonardo"

# Create local user
useradd -m -G wheel ${USER} &&
passwd ${USER} &&
echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers

# Install basics
pacman -Syu sudo git
