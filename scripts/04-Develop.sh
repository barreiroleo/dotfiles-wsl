#!/bin/bash
#set -x
source utils.sh

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo apt-get install build-essential gcc clang make gdb jq -y
fi
echo "[ OK ] Build-essential, gcc, clang, make, gdb, cmake, jq"
if [[ ! $(which java) ]]; then
    sudo apt-get --no-install-recommends install default-jdk -y
fi
echo "[ OK ] Java $(java --version | head -n 1)"

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

if [[ ! -f ~/.local/bin/plantuml.jar ]]; then
    PLANTUML_VERSION=$(curl -s "https://api.github.com/repos/plantuml/plantuml/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo plantuml.jar "https://github.com/plantuml/plantuml/releases/latest/download/plantuml-${PLANTUML_VERSION}.jar"
    mv plantuml.jar ~/.local/bin/
fi
echo "[ OK ] Plantuml downloaded at ~/.local/bin/plantuml.jar"
