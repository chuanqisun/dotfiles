#!/bin/sh

## Echo commands
set -x

## Install common used tools
sudo apt install zsh

## Install fzf
sudo apt-get install fzf

## Install rg
sudo apt-get install ripgrep

## Install neovim
# appimage dependency FUSE
sudo apt install libfuse2

curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim

## neovim plugin infra  
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

## Install tmux
sudo apt install tmux
