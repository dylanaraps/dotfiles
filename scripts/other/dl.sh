#!/bin/mksh
# Script to use curl as a wget replacement
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Set download directory
if [ -z "$2" ] && [ $(pwd) == $HOME ]; then
    dir="$HOME/Downloads"
else
    dir="$2"
fi

clear

# Echo what we're downloading and where we're saving it
echo "$(tput setaf 8)Downloading$(tput sgr0) $(basename $1) $(tput setaf 8)to$(tput sgr0) $(cd $dir; pwd)"

# cd to the directory, call curl and cd back to where we were.
cd $dir && curl -# -O "$1"; cd - >/dev/null
