#!/bin/bash
export XDG_CONFIG_HOME="$HOME/.config"

# neovim
mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$(pwd)/nvim/init.lua" "$XDG_CONFIG_HOME/nvim/init.lua"

# tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$(pwd)/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$(pwd)/tmux/tmux.conf" "$HOME/.tmux.conf" # for tmux vesion < 3.1

# zsh
ln -sf "$(pwd)/zsh/.zshrc" "$HOME/.zshrc"
