#!/bin/bash
#set -x

if [[ ! $(which gcc) || ! $(which clang) ]]; then
    sudo apt-get install build-essential gcc clang make gdb -y
fi
echo "[ OK ] Build-essential, gcc, clang, make, gdb"
