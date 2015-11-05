#!/bin/sh

# get current window id, width and height
WID=$(xprop -root '_NET_ACTIVE_WINDOW' | grep --only-matching '0x.*')
WW=$(xwininfo -id $WID | awk '/Width:/ {print $2}')
WH=$(xwininfo -id $WID | awk '/Height:/ {print $2}')
SW=1920
SH=1080

# move the current window to the center of the screen
# wtp $(((SW - WW)/2)) $(((SH - WH)/2)) $WW $WH $WID
wmctrl -r :ACTIVE: -e 2,$(((SW - WW)/2)),$(((SH - WH)/2)),$WW,$WH

