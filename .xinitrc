# Set the background color
xsetroot -solid '#282828' # Gruvbox bg0

# Set nvm for gui applications
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# Start window manager
exec xmonad
