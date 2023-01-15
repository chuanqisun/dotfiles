#!/bin/sh

### Run this script to make WSL compatible with other Linux tools


## Add WSL utilities: https://wslutiliti.es/wslu/install.html
sudo apt install gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc

# Debian 10
echo "deb https://pkg.wslutiliti.es/debian buster main" | sudo tee -a /etc/apt/sources.list
# Debian 11
echo "deb https://pkg.wslutiliti.es/debian bullseye main" | sudo tee -a /etc/apt/sources.list

sudo apt update
sudo apt install wslu

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

# Fix alacritty config
mkdir -p /mnt/c/Users/chusun/AppData/Roaming/alacritty
cp alacritty/alacritty.yml /mnt/c/Users/chusun/AppData/Roaming/alacritty/alacritty.yml
