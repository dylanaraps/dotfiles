#!/bin/mksh
# Move window to next monitor
# Hacky and hardcoded
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Window info
winfo=($(wattr xywh $wid))

# Window size
w=${winfo[2]}
h=${winfo[3]}

# x/y offsets
x=${winfo[0]}
y=${winfo[1]}

# padding is used so that windows don't get
# stuck between monitors
padding=80

# Save the window's size
tmpfile="/tmp/nextmon-oldsize-$wid"

# Restore window size if tmpfile exists
size=$(cat $tmpfile || echo $(wattr wh $wid))

# Cycle the window between monitors
if [ $x -gt 1920 ]; then
    wtp $padding $((padding + 1080)) $size $wid
elif [ $y -gt 1080 ]; then
    wtp $padding $padding $size $wid
else
    # One of my monitors has a much lower resoultion (1280 x 1024)
    # The lines below save the old window size and resize the window to fit
    # the smaller monitor.

    # Save the old size incase we need to alter it
    echo "$w $h" > $tmpfile

    # If window won't fit on the smaller monitor, resize it.
    # I need to squash both ifs into a single one if possible
    if [ $w -ge 1280 ]; then
        w=$((1280 - padding*2))
    fi

    if [ $h -ge 1024 ]; then
        h=$((1024 - padding*2))
    fi

    wtp $((padding + 1920)) $padding $w $h $wid
fi

# Center the window on the new monitor
corner.sh mm

# Give the window focus
focus.sh $wid
