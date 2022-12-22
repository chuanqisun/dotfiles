#!/bin/bash

# neovim
mkdir -p "$HOME/.config/nvim"
ln -sf "$(pwd)/nvim/init.vim" "$HOME/.config/nvim/init.vim"
