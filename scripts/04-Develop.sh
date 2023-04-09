#!/bin/bash
#set -x

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo apt-get install build-essential gcc clang make gdb -y
fi
echo "[ OK ] Build-essential, gcc, clang, make, gdb, cmake"

if [[ ! $(which npm) ]]; then
    sudo apt-get --no-install-recommends install npm -y
fi
echo "[ OK ] npm (needed for mason)"

if [[ ! $(dpkg -l | grep python3-venv) ]]; then
    sudo apt-get --no-install-recommends install python3-venv -y
fi
echo "[ OK ] python3 venv (needed for mason tools, null-ls)"

if [[ ! $(which lua) || ! $(which luarocks) ]]; then
    sudo apt-get --no-install-recommends install lua5.1 luarocks -y
fi
echo "[ OK ] lua & luarocks (needed for mason tools, null-ls)"
