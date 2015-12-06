#!/bin/sh
# toggle the fullscreen state of multiple windows
#
# Created by z3bra, Modified by Dylan Araps
# Original: https://git.z3bra.org
# Modified: https://github.com/dylanaraps/dotfiles

wid=$(pfw)

# this file is used to store the previous geometry of a window
fsfile="/tmp/.fwin-$wid"

# it's pretty simple, but anyway...
usage() {
    echo "usage: $(basename $0) <wid>"
    exit 1
}

# exit if no argument given
test -z "$wid" && usage

# this will unset the fullscreen state of any fullscreen window if there is one.
test -f $fsfile && wtp $(cat $fsfile)

# if file exist and contain our window id, it means that out window is in
# fullscreen mode
if test -f $fsfile && grep -q $wid $fsfile; then
    # if the window we removed was our window, delete the file, so we can
    # fullscreen it again later
    rm -f $fsfile

else
    # if not, then put the current window in fullscreen mode, after saving its
    # geometry and id to $fsfile we also remove any border from this window.
    wattr xywhi $wid > $fsfile

    if [[ $(wattr y $wid) -gt 1080 ]]; then
        wtp 0 1080 1920 1080 $wid
    elif [[ $(wattr x $wid) -gt 1920 ]]; then
        wtp 1920 0 1280 1024 $wid
    else
        wtp 0 0 1920 1080 $wid
    fi

    chwb -s 0 $wid
fi

# now focus the window, and put it in front, no matter which state we're in, and
# put the cursor on its bottom-right corner (for consistency)
focus.sh $wid
