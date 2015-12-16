#!/bin/mksh
# Resize windows to predefined sizes
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Screen size
sw=1920
sh=1080

# Padding
padding=80

xy=$(wattr xy $wid)

# If window is on my second monitoet number!
if [ $(wattr x $wid) -gt 1920 ]; then
    sw=1280
    sh=1024
fi

case $1 in
    half) w=$((sw / 2 - padding - padding/2)) ;;
    third) w=$((sw / 3)) ;;
    quarter) w=$((sw / 4)) ;;
esac

h=$((sh - padding*2))

# Move the window
wtp $xy $w $h $wid
