#!/bin/sh

## Echo commands
set -x

## Install common used tools
sudo apt install zsh

## Install neovim

# app image dependency FUSE
sudo apt install libfuse2

curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim

## neovim plugin infra  
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Install tmux
sudo apt install tmux
