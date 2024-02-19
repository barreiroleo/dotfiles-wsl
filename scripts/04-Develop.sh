#!/bin/bash
#set -x
# source utils.sh

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo add-apt-repository 'deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main'
    sudo update
    sudo apt-get install build-essential gcc clang clang-tools make cmake gdb jq bc -y
    echo "If you have throubles with gpg key for clang check the script file. There's some help"
    # curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/llvm-snapshot.gpg
    # sudo chmod a+r /etc/apt/keyrings/llvm-snapshot.gpg
    # echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/"$(. /etc/os-release && echo "$VERSION_CODENAME")"/ llvm-toolchain-"$(. /etc/os-release && echo "$VERSION_CODENAME")" main" | sudo tee /etc/apt/sources.list.d/llvm-snapshot.list > /dev/null
    # echo "deb-src [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/"$(. /etc/os-release && echo "$VERSION_CODENAME")"/ llvm-toolchain-"$(. /etc/os-release && echo "$VERSION_CODENAME")" main" | sudo tee -a /etc/apt/sources.list.d/llvm-snapshot.list > /dev/null
    # cat /etc/apt/sources.list.d/llvm-snapshot.list
fi
echo "[ OK ] Build-essential, gcc, clang, make, gdb, cmake, jq, bc"

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
    sudo apt-get install openjdk-17-jdk -y
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

if [[ ! $(which cppcheck) || ! $(which clang-check) ]]; then
    sudo apt install cppcheck clang-tools
fi
echo "[ OK ] cppcheck & clang-tools"

if [[ ! -f ~/.local/bin/plantuml.jar ]]; then
    sudo apt-get install --no-install-recommends graphviz -y
    PLANTUML_VERSION=$(curl -s "https://api.github.com/repos/plantuml/plantuml/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo plantuml.jar "https://github.com/plantuml/plantuml/releases/latest/download/plantuml-${PLANTUML_VERSION}.jar"
    mv plantuml.jar ~/.local/bin/
fi
echo "[ OK ] Plantuml downloaded at ~/.local/bin/plantuml.jar"
