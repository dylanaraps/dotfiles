#!/bin/bash
# Dylan's maximize script
# Make the currently focused window take up the whole screen with gaps

# hardcoded screen res due to multimon
w=1920
h=1080

# gaps
gapx=$1
gapy=$2

# border
border=$(wattr b $(pfw))

# panel padding
panel=0

w=$(($w - $(($gapx * 2)) - $(($border * 2))))
h=$(($h - $(($gapy * 2)) - $(($border * 2)) - $panel))

wtp $gapx $gapy $w $h $(pfw)
