#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# move windows to the corners

wid=$(pfw)

# Hardcoded w/h due to multimon
sw=1900
sh=1073

# Get border/window size
bw=$(wattr b $wid)
w=$(wattr w $wid)
h=$(wattr h $wid)

# Set gap around corner
gap=80

# Set gap for x/y
x=$gap
y=$gap

case $1 in
    tr) x=$((sw - w - bw*2 - $gap)) ;;
    bl) y=$((sh - h - bw*2 - $gap)) ;;
    br) x=$((1900 - w - bw*2 - $gap))
        y=$((1073 - h - bw*2 - $gap)) ;;
    md) x=$((sw/2 - w/2 - bw))
        y=$((sh/2 - h/2 - bw)) ;;
esac

wtp $x $y $w $h $wid
