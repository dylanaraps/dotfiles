#!/bin/sh

# get current window id, width and height
wid=$(pfw)

# Get current window size
ww=$(wattr w $wid)
wh=$(wattr h $wid)

# Hardcoded w/h due to multimon
SW=1920
SH=1080

# move the current window to the center of the screen
wtp $(((SW - ww)/2)) $(((SH - wh)/2)) $ww $wh $wid

# Move the current window to the botton layer
chwso -l $wid
