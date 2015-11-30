#!/bin/sh

# get current window id, width and height
wid=$(pfw)

# Get current window size
ww=$(wattr w $wid)
wh=$(wattr h $wid)

# Multimon
sw=1920
sh=1080

if [[ $(wattr y $wid) -gt 1080 ]]; then
    wtp $(((sw - ww) / 2)) $(((sh - wh ) / 2 + 1080)) $ww $wh $wid
elif [[ $(wattr x $wid) -gt 1920 ]]; then
    sw=1280
    sh=1024
    wtp $(((sw - ww) / 2 + 1920)) $(((sh - wh) / 2)) $ww $wh $wid
else
    wtp $(((sw - ww)/2)) $(((sh - wh)/2)) $ww $wh $wid
fi

# move the current window to the center of the screen

# Move the current window to the botton layer
chwso -l $wid
