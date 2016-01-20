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
titlebar=26

# Default x/y values
x=$padding
y=$padding

# Screen size
sw=1920
sh=1080

case $1 in
    # Keeping this here for readability
    tl) x=$padding ;;

    tr) x=$((sw - padding - w)) ;;

    bl) y=$((sh - padding - h - titlebar)) ;;

    br) x=$((sw - padding - w))
        y=$((sh - padding - h - titlebar)) ;;

    ml) y=$((sh/2 - h/2 - titlebar/2)) ;;

    mr) x=$((sw - padding - w))
        y=$((sh/2 - h/2 - titlebar/2)) ;;

    mt) x=$((sw/2 - w/2)) ;;

    mb) x=$((sw/2 - w/2))
        y=$((sh - padding - h - titlebar)) ;;

    mm) x=$((sw/2 - w/2))
        y=$((sh/2 - h/2 - titlebar/2)) ;;

    mml) y=$((sh/2 - h - titlebar)) ;;

    mmr) x=$((sw - padding - w))
         y=$((sh/2 - h - titlebar)) ;;

    mmm) x=$((sw/2 -w/2))
         y=$((sh/2 - h - titlebar)) ;;

    mmml) # This works somehow and I cbf fixing it.
          y=$((sh/2 - + - h/4 - titlebar)) ;;

    mmmr) x=$((sw - padding - w))
          # This works somehow and I cbf fixing it.
          y=$((sh/2 - + - h/4 - titlebar)) ;;

    mmmm) x=$((sw/2 -w/2))
          y=$((sh/2 - + - h/4 - titlebar)) ;;
esac

# Move the window
wtp $x $y $w $h $wid
