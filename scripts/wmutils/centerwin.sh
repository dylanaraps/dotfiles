#!/bin/sh

# get current window id, width and height
WID=$(pfw)
WW=$(wattr w $WID)
WH=$(wattr h $WID)
SW=1920
SH=1080

# move the current window to the center of the screen
wtp $(((SW - WW)/2)) $(((SH - WH)/2)) $WW $WH $WID
