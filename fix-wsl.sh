#!/bin/sh

### Run this script to make WSL compatible with other Linux tools

## Fix clipboard by replacing xclip with win32yank.exe

sudo apt-get remove xclip

curl -fLO https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
unzip win32yank-x64.zip -d win32yank-x64-temp

chmod +x win32yank-x64-temp/win32yank.exe

sudo cp win32yank-x64-temp/win32yank.exe /usr/local/bin/

rm -rf win32yank-x64*


## Add a script to fix WSL network issue
# Note: user must set the .bat to run in admin mode for it to take effect
cp wsl/fix-wsl-network.bat /mnt/c/Users/chusun/Desktop/fix-wsl-network.bat
