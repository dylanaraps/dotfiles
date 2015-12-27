#!/bin/mksh
# Script to set a random wallpaper from a directory excluding the current one
# I'd use feh's built in "--randomize" flag if it didn't
# fuck up multi mon wallpapers.
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

# Wallpaper directory
walldir="$HOME/Pictures/wallpaper/wash/*"

changewall () {
    # Current wallpaper
    wall=$(basename $(cat $HOME/.fehbg | awk '/feh/ {printf $3}' | sed -e "s/'//g"))

    # Randomly set the wallpaper excluding the current wallpaper
    find $walldir ! -name "$wall" -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
    shuf -n1 -z | xargs -0 feh --bg-fill

    # Get wallpaper again
    wall=$(basename $(cat $HOME/.fehbg | awk '/feh/ {printf $3}' | sed -e "s/'//g"))

    # Change openbox titlebar color based on wallpaper
    case $wall in
        1.jpg|3.jpg|4.jpg) gencol.sh openbox 1 7 ;;
        2.jpg|6.jpg) gencol.sh openbox 2 7 ;;
        5.jpg|7.jpg) gencol.sh openbox 4 7 ;;
        8.jpg) gencol.sh openbox  8 7 ;;
        1.png) gencol.sh openbox 6 8 ;;
    esac
}

case $1 in
    --loop|-l) while :; do changewall; sleep $2; done ;;
    *) changewall ;;
esac
