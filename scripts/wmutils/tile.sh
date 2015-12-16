#!/bin/mksh
# Tile windows with gaps/padding/ignored-windows/multi-monitor
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Options

# Space to leave on top for a panel
panel=0

# Gaps around windows
gap=50

# Padding around the tiling area
paddingy=50
paddingx=250

# Currently focused window
wid=$(pfw)

# Border width
bw=$(wattr b $wid)

# Ignore file
ignorefile="/tmp/.ignore-$wid"

# Exclude windows from tiling
ignore () {
    # if file exists
    if test -f "$ignorefile"; then
        rm -f "$ignorefile"
    else
        touch "$ignorefile"
    fi
}

# Start Tiling

tile () {
    # Default x/y offsets
    x=$((gap + paddingx))
    y=$((gap + panel + paddingy))


    # Multi Monitor

    # Checks the x/y coords of the currently focused window to see which monitor it's on.
    # Monitors must be manually defined as wmutils doesn't have multimon tools yet.
    if [ "$(wattr x $wid)" -gt 1920 ]; then
        mon=2
        width=1280
        height=1024
        gap=50
        paddingy=0
        paddingx=0

        x=$((gap + paddingx + 1920))
        y=$((gap + panel + paddingy))

        # List windows only on the second monitor
        listwin=$(wattr xi $(lsw) | awk '$1 > 1920' | awk '{print $2}')
    elif [ "$(wattr y $wid)" -gt 1080 ]; then
        mon=3
        width=1920
        height=1080

        y=$((gap + panel + paddingy + 1080))

        # List windows only on the third monitor
        listwin=$(wattr yi $(lsw) | awk '$1 > 1080' | awk '{print $2}')
    else
        mon=1
        width=1920
        height=1080

        # List windows only on the first monitor
        listwin=$(wattr yxi $(lsw) | awk '$1 < 1080' | awk '$2 < 1920' | awk '{print $3}')
    fi

    # Ignored windows
    ignore=$(ls -A --color=no /tmp | grep "\.ignore\-$listwin" | wc -l)

    # Size of the master window.
    master=$((width / 2 - $((gap / 2)) - paddingx))

    # Get the number of windows to put in the stacking area
    max=$(echo "$listwin" | grep -v $wid | wc -l)

    # calculate usable screen size (without borders and gaps)
    sw=$((width - gap - 2*bw - paddingx))
    sh=$((height - gap - 2*bw - panel - paddingy))


    # Tile the first window

    # If ignorefile for window exists, exit
    if [ -f $ignorefile ]; then
        exit

    # If there's only one unignored window open tile it to the full width of the screen
    elif [ $(($(echo "$listwin" | wc -l) - $ignore)) -eq 1 ]; then
        sw=$((sw - gap - paddingx))
        sh=$((sh - gap - paddingy))

        wtp $x $y $sw $sh $wid
    else
        wtp $x $y $((master - gap - 2*bw)) $((sh - gap - paddingy)) $wid
    fi

    # Put the tiled windows at the bottom of the stack
    chwso -l $wid


    # Tile the rest of the windows

    if [ $mon -eq 2 ]; then
        x=$((master + gap + paddingx + 1920))
    else
        x=$((master + gap + paddingx))
    fi

    w=$((sw - master - gap - paddingx))
    h=$((sh / $((max - ignore)) - gap - paddingy/$((max - ignore))))
    echo $h

    for wid in $(echo "$listwin" | grep -v $wid); do
        ignorefile="/tmp/.ignore-$wid"
        # If focused window's name doesn't include "tile_ignore", tile it!
        if [ ! -f "$ignorefile" ]; then
            wtp $x $y $w $h $wid

            y=$((y + h + gap))

            # Put the tiled windows at the bottom of the stack
            chwso -l $wid
        fi
    done
}

# Set up args
while getopts "ti" opt 2>/dev/null; do
    case $opt in
        t) tile ;;
        i) ignore ;;
    esac
done
