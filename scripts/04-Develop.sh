#!/bin/bash
#set -x
# source utils.sh

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo pacman -S base-devel gcc clang make cmake gdb jq bc
fi
echo "[ OK ] Build-essential, gcc, clang, make, cmake, gdb, jq, bc"

if [[ ! $(which dotnet) ]]; then
    sudo pacman -S dotnet-sdk
fi
echo "[ OK ] .NET Core 7"

function has_java(){
    version_target=$1
    java_version=$(java -version 2>&1)
    regex='version "([0-9]+\.[0-9]+\.[0-9]+).*"'
    if [[ $java_version =~ $regex ]]; then
        java_version=${BASH_REMATCH[1]} # Exact version
        java_version=$(echo $java_version | awk -F'.' '{print $1}') # Major version
    else
        echo "Failed to extract Java version"
        java_version=0
    fi
    if [[ $(echo "$java_version >= $version_target" | bc) -eq 1 ]]; then
        echo "Java version is $version_target or higher"
        return 0
    else
        echo "Java version is lower than $version_target"
        return 1
    fi
}
if ! has_java 17; then
    # java-runtime-common provides archlinux-java
    sudo pacman -S jdk-openjdk openjdk-doc java-runtime-common
fi
echo "[ OK ] Java $(java --version | head -n 1)"

if [[ ! $(which npm) ]]; then
    sudo pacman -S npm
fi
echo "[ OK ] npm (needed for mason)"

if [[ ! $(which python) ]]; then
    sudo pacman -S python
fi
echo "[ OK ] python venv (needed for mason tools, null-ls)"

if [[ ! $(which lua) || ! $(which luarocks) ]]; then
    sudo pacman -S lua5.1 luarocks
fi
echo "[ OK ] lua & luarocks (needed for mason tools, null-ls)"

if [[ ! $(which cppcheck) || ! $(which clang-check) ]]; then
    sudo pacman -S cppcheck clang
fi
echo "[ OK ] cppcheck & clang-tools"

if [[ ! -f ~/.local/bin/plantuml.jar ]]; then
    PLANTUML_VERSION=$(curl -s "https://api.github.com/repos/plantuml/plantuml/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo plantuml.jar "https://github.com/plantuml/plantuml/releases/latest/download/plantuml-${PLANTUML_VERSION}.jar"
    mkdir -p ~/.local/bin/
    mv plantuml.jar ~/.local/bin/
fi
echo "[ OK ] Plantuml downloaded at ~/.local/bin/plantuml.jar"
