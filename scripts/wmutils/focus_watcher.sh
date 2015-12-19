#!/bin/mksh
# focus a window when it is created
#
# Created by z3bra, Modified by Dylan Araps
# Original: https://git.z3bra.org
# Modified: https://github.com/dylanaraps/dotfiles

spawn_at_cursor () {
    wid=$1

    # Create array of window info
    winfo=($(wattr wh $wid) $(wmp))

    # Window height
    w=${winfo[0]}
    h=${winfo[1]}

    # Place to spawn the window
    x=$((${winfo[2]} - w/2))
    y=$((${winfo[3]} - h/2))

    test $x -lt 0 && x=0
    test $y -lt 0 && y=0

    wtp $x $y $w $h $wid
}

# hacky hacky way of ingoring a specific window
ignore_cover () {
    # Get cover window id by width/height
    wid=$(wattr iwh $(lsw) | awk '/144 143/ {print $1;}')

    chwb -s 7 "$wid"
    wmv -a 1738 886 "$wid"
    ignw -s "$wid"
}

# watch X events
wew | while IFS=: read ev wid; do
    case $ev in
        # spawn windows at cursor if not overriden
        16) wattr o $wid || spawn_at_cursor $wid; ignore_cover ;;

        # focus windows if not overriden
        19) wattr o $wid || ~/dotfiles/scripts/wmutils/focus.sh $wid ;;

        # focus next window when deleting focused window
        18) wattr $(pfw) || ~/dotfiles/scripts/wmutils/focus.sh prev ;;

        # focus windows where the cursor enters
        7) wattr o $wid || ~/dotfiles/scripts/wmutils/focus.sh $wid ;;
    esac
done
