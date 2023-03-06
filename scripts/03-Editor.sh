#!/bin/bash
#set -x

if [[ ! $(which nvim) ]]; then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update -y
    sudo apt-get install neovim -y

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor

    echo '-- autocmd VimLeave * silent !echo -ne "\e[0 q"' >> ~/.config/nvim/init.lua
    echo "vim.o.clipboard = \"unnamedplus\"" >> ~/.config/nvim/init.lua
fi
echo "[ OK ] Neovim"
