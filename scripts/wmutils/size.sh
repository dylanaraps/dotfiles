#!/bin/mksh
# Resize windows to fractions of screen size
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Screen size and padding depending
# on which monitor the window is on
if [ $(wattr x $wid) -gt 1920 ]; then
    sw=1280
    sh=1024
    paddingx=0
    paddingy=0
else
    sw=1920
    sh=1080
    paddingx=80
    paddingy=80
fi

case $1 in
    h) wrs -$((sw / $2 - padding)) 0 $wid ;;
    j) wrs 0 +$((sh / $2 - padding)) $wid ;;
    k) wrs 0 -$((sh / $2 - padding)) $wid ;;
    l) wrs +$((sw / $2 - padding)) 0 $wid ;;
esac
