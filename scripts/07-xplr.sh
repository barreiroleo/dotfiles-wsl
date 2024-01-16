#!/bin/bash
# set -x

if [[ ! $(which xplr) ]]; then
    platform="linux"  # or "macos" / "linux-musl"
    wget https://github.com/sayanarijit/xplr/releases/latest/download/xplr-$platform.tar.gz
    echo "[ xplr ] Binary downloaded"
    tar xzvf xplr-$platform.tar.gz
    echo "[ xplr ] tar.gx extracted"
    sudo mv xplr /usr/local/bin/
    echo "[ xplr ] Moved to path"

    mkdir -p ~/.config/xplr
    version="$(xplr --version | awk '{print $2}')"
    echo "version = '${version:?}'" > ~/.config/xplr/init.lua
    echo "[ xplr ] Config created"
fi
echo "[ OK ] xplr"


