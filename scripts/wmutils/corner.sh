#!/bin/mksh
# Move windows to the corners
# Modified to work with openbox
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Set padding around corners
padding=80

# Window info
window=($(wattr wh $wid))

# Get window size
w=${window[0]}
h=${window[1]}

# Titlebar height
titlebar=30

# Default x/y values
x=$padding
y=$padding

case $1 in
    # Keeping this here for readability
    tl) x=$padding ;;

    tr) x=$((1920 - padding - w)) ;;

    bl) y=$((1080 - padding - h - titlebar)) ;;

    br) x=$((1920 - padding - w))
        y=$((1080 - padding - h - titlebar)) ;;

    ml) y=$((1080/2 - h/2 - titlebar/2)) ;;

    mr) x=$((1920 - padding - w))
        y=$((1080/2 - h/2 - titlebar/2)) ;;

    mt) x=$((1920/2 - w/2)) ;;

    mb) x=$((1920/2 - w/2))
        y=$((1080 - padding - h - titlebar)) ;;

    mm) x=$((1920/2 - w/2))
        y=$((1080/2 - h/2 - titlebar/2)) ;;
esac

# Move the window
wtp $x $y $w $h $wid
