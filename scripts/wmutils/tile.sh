#!/bin/sh
# z3bra - 2014 (c) wtfpl
# Heavily modified by Dylan
# Tile windows with gaps/padding/ignored-windows/multi-monitor

# Options

# Space to leave on top for a panel
panel=0

# Gaps around windows
gap=50

# Padding around the tiling area
paddingy=50
paddingx=250

# Start collecting information

# Currently focused window
pfw=$(pfw)

# Border width
bw=$(wattr b "$pfw")

# Number of windows with "tile_ignore" in name
ignore=$(wname $(lsw) | grep "tile_ignore" | wc -l)

# Default x/y offsets
x=$((gap + paddingx))
y=$((gap + panel + paddingy))

# Multi Monitor
# Checks the x/y coords of the currently focused window to see which monitor it's on.
# Monitors must be manually defined as wmutils doesn't have multimon tools yet.
if [[ $(wattr x $pfw) -gt 1920 ]]; then
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
elif [[ $(wattr y $pfw) -gt 1080 ]]; then
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

# Size of the master window.
master=$((width / 2 - $((gap / 2)) - paddingx))

# Get the number of windows to put in the stacking area
max=$(echo "$listwin" | grep -v $pfw | wc -l)

# calculate usable screen size (without borders and gaps)
sw=$((width - gap - 2*bw - paddingx))
sh=$((height - gap - 2*bw - panel - paddingy))

# put current window in master area

# If windowname includes "tile_ignore", exit
if [[ $(wname $pfw) == *"tile_ignore"* ]]; then
    exit

# If there's only one unignored window open tile it to the full width of the screen
elif [[ $(($(echo "$listwin" | wc -l) - $ignore)) == 1 ]]; then
    sw=$((sw - gap - paddingx))
    sh=$((sh - gap - paddingy))

    wtp $x $y $sw $sh $pfw
else
    wtp $x $y $((master - gap - 2*bw)) $((sh - gap - paddingy)) $pfw
fi

# Put the tiled windows at the bottom of the stack
chwso -l $pfw

# And now, stack up all remaining windows on the right

if [[ $mon == 2 ]]; then
    x=$((master + gap + paddingx + 1920))
else
    x=$((master + gap + paddingx))
fi

w=$((sw - master - gap - paddingx))
h=$((sh / $((max - ignore)) - gap - $((paddingy / max)) - $((max - 1))*bw))

for wid in $(echo "$listwin" | grep -v $pfw); do
    # If focused window's name doesn't include "tile_ignore", tile it!
    if [[ $(wname $wid) != *"tile_ignore"* ]]; then
        wtp $x $y $w $h $wid

        y=$((y + h + gap + max*bw))

        # Put the tiled windows at the bottom of the stack
        chwso -l $wid
    fi
done
