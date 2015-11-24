#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# move windows to the corners

WID=$(pfw)

# Hardcoded w/h due to multimon
SW=1920
SH=1080

BW=$(wattr b $WID)
W=$(wattr w $WID)
H=$(wattr h $WID)

GAP=100

X=$GAP
Y=$GAP

case $1 in
    tr) X=$((SW - W - BW*2 - $GAP)) ;;
    bl) Y=$((SH - H - BW*2 - $GAP)) ;;
    br) X=$((SW - W - BW*2 - $GAP))
        Y=$((SH - H - BW*2 - $GAP)) ;;
    md) X=$((SW/2 - W/2 - BW))
        Y=$((SH/2 - H/2 - BW));;
esac

wtp $X $Y $W $H $WID
