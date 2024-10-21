#!/bin/bash
#set -x
sudo pacman -Syu --noconfirm

if [[ ! $(which clang) ]];then
    sudo pacman -S base-devel clang libc++ cmake gdb cppcheck jq bc --noconfirm
fi
echo "[ OK ] Base-devel (build-essential), clang, libc++, cmake, gdb, cppcheck jq, bc"

if [[ ! $(which dotnet) ]];then
    sudo pacman -S dotnet-runtime dotnet-sdk --noconfirm
fi
echo "[ OK ] .NET Core"

if [[ ! $(which java) ]];then
    sudo pacman -S jdk-openjdk --noconfirm
fi
echo "[ OK ] Java Development Kit"

if [[ ! $(which node) ]];then
    sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh)"
    source ~/.zshrc
    nvm install node
    nvm use node
fi
echo "[ OK ] NVM & NodeJS"

if [[ ! $(which lua) ]];then
    sudo pacman -S lua51 luarocks luajit --noconfirm
fi
echo "[ OK ] lua & luarocks"

if [[ ! $(which go) ]];then
    sudo pacman -S go --noconfirm
fi
echo "[ OK ] Golang"

if [[ ! $(which cargo) ]];then
    sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)"
fi
echo "[ OK ] Rust"

if [[ ! -f ~/.local/bin/plantuml.jar ]]; then
    sudo pacman -S graphviz --noconfirm
    PLANTUML_VERSION=$(curl -s "https://api.github.com/repos/plantuml/plantuml/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo plantuml.jar "https://github.com/plantuml/plantuml/releases/latest/download/plantuml-${PLANTUML_VERSION}.jar"
    mkdir -p ~/.local/bin/
    mv plantuml.jar ~/.local/bin/
fi
echo "[ OK ] Plantuml downloaded at ~/.local/bin/plantuml.jar"
