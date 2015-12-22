#!/bin/mksh
# Resize windows to fractions of screen size
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Screen size and padding
sw=1920
sh=1080
paddingx=80
paddingy=80

case $1 in
    h) wrs -$((sw / $2 - padding)) 0 $wid ;;
    j) wrs 0 +$((sh / $2 - padding)) $wid ;;
    k) wrs 0 -$((sh / $2 - padding)) $wid ;;
    l) wrs +$((sw / $2 - padding)) 0 $wid ;;
esac
