#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# move windows to the corners

CUR=${2:-$(pfw)}
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

BW=$(wattr b $CUR)
W=$(wattr w $CUR)
H=$(wattr h $CUR)

X=0
Y=0

case $1 in
    tr) X=$((SW - W - BW*2)) ;;
    bl) Y=$((SH - H - BW*2)) ;;
    br) X=$((SW - W - BW*2))
        Y=$((SH - H - BW*2)) ;;
    md) X=$((SW/2 - W/2 - BW))
        Y=$((SH/2 - H/2 - BW));;
esac

wtp $X $Y $W $H $CUR
