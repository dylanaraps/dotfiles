#!/bin/mksh
# Script to set a random wallpaper from a directory excluding the current one
# I'd use feh's built in "--randomize" flag if it didn't
# fuck up multi mon wallpapers.
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Wallpaper directory
walldir="$HOME/Pictures/wallpapers/wash/*"

changewall () {
    # Current wallpaper
    wall=$(awk '/feh/ {printf $3}' "$HOME/.fehbg")
    wall=${wall#\'*}
    wall=${wall%*\'}
    wall=${wall##*/}

    # Randomly set the wallpaper excluding the current wallpaper
    find $walldir ! -name "$wall" -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
    shuf -n1 -z | xargs -0 feh --bg-fill
}

case $1 in
    --loop|-l) while :; do changewall; sleep $2; done ;;
    *) changewall ;;
esac
