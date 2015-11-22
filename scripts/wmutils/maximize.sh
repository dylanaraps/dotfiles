#!/bin/bash
# Dylan's maximize script
# Make the currently focused window take up the whole screen with gaps

w=1920
h=1080
gapx=$1
gapy=$2
border=$(wattr b $(pfw))
panel=0

w=$(($w - $(($gapx * 2)) - $(($border * 2))))
h=$(($h - $(($gapy * 2)) - $(($border * 2)) - $panel))

wtp $gapx $gapy $w $h $(pfw)
