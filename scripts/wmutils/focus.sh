#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# window focus wrapper that sets borders and can focus next/previous window

# border width
bw=6

# active border color
active=$white

# inactive border color
inactive=$gray

# get current window id
cur=$(pfw)

usage() {
    echo "usage: $(basename $0) <next|prev|wid>"
    exit 1
}

setborder() {
    # check if window exists
    wattr $2 || return

    # do not modify border of fullscreen windows
    test "$(wattr wh $2)" = "1920 1080" && return
    test "$(wattr wh $2)" = "1280 1024" && return

    case $1 in
        active)   chwb -s $bw -c $active $2 ;;
        inactive) chwb -s $bw -c $inactive $2 ;;
    esac
}

case $1 in
    next) wid=$(lsw | grep -v $cur | sed '1 p;d') ;;
    prev) wid=$(lsw | grep -v $cur | sed '$ p;d') ;;
    0x*) wattr $1 && wid=$1 ;;
    *) usage ;;
esac

# exit if we can't find another window to focus
test -z "$wid" && echo "$(basename $0): can't find a window to focus" >&2 && exit 1

setborder inactive $cur # set inactive border on current window
setborder active $wid   # activate the new window
wtf $wid                # set focus on it
