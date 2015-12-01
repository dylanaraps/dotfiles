#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# move windows to the corners

# Focused window
wid=$(pfw)

# Set gap around corners
gap=80

# Border width
bw=$(wattr b $wid)

# Window size
w=$(wattr w $wid)
h=$(wattr h $wid)

# Default x/y values
x=$gap
y=$gap

# Hardvoded multimonitor
if [[ $(wattr y $wid) -gt 1080 ]]; then
    case $1 in
        tl) y=$((1080 + gap)) ;;

        tr) x=$((1920 - gap - w - bw*2))
            y=$((1080 + gap)) ;;

        bl) y=$((1080*2 - gap - h - bw*2)) ;;

        br) x=$((1920 - gap - w - bw*2))
            y=$((2160 - gap - h - bw*2)) ;;

        ml) y=$((1080 + 1080/2 - h/2 - bw)) ;;

        mr) x=$((1920 - gap - w - bw*2))
            y=$((1080 + 1080/2 - h/2 - bw)) ;;
    esac
elif [[ $(wattr x $wid) -gt 1920 ]]; then
    case $1 in
        tl) x=$((1920 + gap)) ;;

        tr) x=$((1920 + 1280 - gap - w - bw*2)) ;;

        bl) x=$((1920 + gap))
            y=$((1024 - gap - h - bw*2)) ;;

        br) x=$((1920 + 1280 - gap - w - bw*2))
            y=$((1024 - gap - h - bw*2)) ;;

        ml) x=$((1920 + gap))
            y=$((1024/2 - h/2 - bw)) ;;

        mr) x=$((1920 + 1280 - gap - w - bw*2))
            y=$((1024/2 - h/2 - bw)) ;;
    esac
else
    case $1 in
        # Keeping this here for readability
        tl) x=$gap
            y=$gap ;;

        tr) x=$((1920 - gap - w - bw*2)) ;;

        bl) y=$((1080 - gap - h - bw*2)) ;;

        br) x=$((1920 - gap - w - bw*2))
            y=$((1080 - gap - h - bw*2)) ;;

        ml) y=$((1080/2 - h/2 - bw)) ;;

        mr) x=$((1920 - gap - w - bw*2))
            y=$((1080/2 - h/2 - bw)) ;;
    esac
fi

# Move the window
wtp $x $y $w $h $wid
