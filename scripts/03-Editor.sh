#!/bin/bash
#set -x

if [[ ! $(which nvim) ]]; then
    yay -S neovim-nightly-bin
    # sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    # sudo update-alternatives --config vi
    # sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    # sudo update-alternatives --config vim
    # sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    # sudo update-alternatives --config editor
    # echo '-- autocmd VimLeave * silent !echo -ne "\e[0 q"' >> ~/.config/nvim/init.lua
    # echo "vim.o.clipboard = \"unnamedplus\"" >> ~/.config/nvim/init.lua
fi
echo "[ OK ] Neovim"
