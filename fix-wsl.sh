#!/bin/sh

### Run this script to make WSL compatible with other Linux tools

## Fix clipboard by replacing xclip with win32yank.exe

sudo apt-get remove xclip

curl -fL https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip --output temp-yank.zip
unzip temp-yank.zip -d temp-yank
chmod +x temp-yank/win32yank.exe

cp temp-yank/win32yank.exe /usr/local/bin/win32yank.exe

rm -rf temp-yank*

## Add a script to fix WSL network issue
# Note: user must set the .bat to run in admin mode for it to take effect
cp wsl/fix-wsl-network.bat /mnt/c/Users/chusun/Desktop/fix-wsl-network.bat
