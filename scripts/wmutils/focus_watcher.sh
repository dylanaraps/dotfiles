#!/bin/mksh
# focus a window when it is created
#
# Created by z3bra, Modified by Dylan Araps
# Original: https://git.z3bra.org
# Modified: https://github.com/dylanaraps/dotfiles

spawn_at_cursor () {
    # Create array of window info
    winfo=($(wattr wh $1) $(wmp))

    # Window height
    w=${winfo[0]}
    h=${winfo[1]}

    # Place to spawn the window
    x=$((${winfo[2]} - w/2))
    y=$((${winfo[3]} - h/2))

    test $x -lt 0 && x=0
    test $y -lt 0 && y=0

    # Disallow windows from spawning on my second
    # monitor
    if [ $x -gt 1920 ]; then
        x=$((1920 - w - 80))
    fi

    wtp $x $y $w $h $1
}

# watch X events
wew | while IFS=: read ev wid; do
    case $ev in
        # spawn windows at cursor if not overriden
        16) wattr o $wid || spawn_at_cursor $wid; titlebar.sh -s $wid ;;

        # focus windows if not overriden
        19) wattr o $wid || focus.sh $wid ;;

        # focus next window when deleting focused window and close titlebar
        18) wattr $(pfw) || titlebar.sh -k $wid; focus.sh prev ;;

        # focus windows where the cursor enters
        7) wattr o $wid || focus.sh $wid ;;
    esac
done
