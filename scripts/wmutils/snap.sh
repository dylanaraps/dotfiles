#!/bin/mksh
# Snap windows to the left/right
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Set padding around corners
padding=80

# Border width
bw=$(wattr b $wid)

# Screen size
sw=1920
sh=1080

# Window size
w=$(wattr w $wid)
h=$((sh - padding*2))

# Window padding
x=$padding
y=$padding

# Hardcoded multimonitor
if [ $(wattr y $wid) -gt 1080 ]; then
    case $1 in
        le) y=$((sh + padding)) ;;

        ri) x=$((sw - w - padding - bw*2))
            y=$((sh + padding)) ;;
    esac
else
    case $1 in
        # Kept here for readability
        le) x=$padding
            y=$padding ;;

        ri) x=$((sw - w - padding - bw*2)) ;;
    esac
fi

# Move the window
wtp $x $y $w $h $wid
