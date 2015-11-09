#!/bin/sh

# Get window id
WID=$(xprop -root '_NET_ACTIVE_WINDOW' | grep --only-matching '0x.*')

# Get window width and height
WW=$(xwininfo -id "$WID" | awk '/Width:/ {print $2}')
WH=$(xwininfo -id "$WID" | awk '/Height:/ {print $2}')

# Screen size is manually set so that the script only centers on my primary monitor
SW=1920
SH=1080

# move the current window to the center of the screen
wmctrl -r :ACTIVE: -e 2,$(((SW - WW)/2)),$(((SH - WH)/2)),"$WW","$WH"

