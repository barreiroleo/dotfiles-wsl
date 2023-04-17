#!/bin/bash
#set -x
# source utils.sh

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo apt-get install build-essential gcc clang make gdb jq -y
fi
echo "[ OK ] Build-essential, gcc, clang, make, gdb, cmake, jq"

if [[ ! $(which dotnet) ]]; then
    # Official script: https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#register-the-microsoft-package-repository
    # Get Ubuntu version
    declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)
    # Download Microsoft signing key and repository
    wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt update
    sudo apt install dotnet-sdk-7.0 -y
fi
echo "[ OK ] .NET Core 7"

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
