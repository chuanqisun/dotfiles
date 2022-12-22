#!/bin/bash
export XDG_CONFIG_HOME="$HOME/.config"

# neovim
mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$(pwd)/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/init.vim"

# tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$(pwd)/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

# zsh
ln -sf "$(pwd)/zsh/.zshrc" "$XDG_CONFIG_HOME/.zshrc"
