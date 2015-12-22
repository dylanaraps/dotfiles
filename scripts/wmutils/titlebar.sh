#!/bin/mksh
# Adds titlebars to windows using lemonbar
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Height of titlebar
height=30

# Spawn the bar
spawnbar () {
    # Source colors
    source ~/dotfiles/scripts/colors/output/colors.sh

    # Colors
    bg=$red
    fg=$white

    # Font
    font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-ISO8859-1"

    # Check to see if titlebar exists and the window isn't a popup or a dock
    if [ ! -f "/tmp/titlebar-$1" ] && [ ! -z $(lsw | grep "$1") ]; then
        # Create array of window info
        winfo=($(wattr xywh $1))
        width=${winfo[2]}
        xoffset=${winfo[0]}
        yoffset=$((${winfo[1]} - height))

        # Fix lemonbar not launching if y=0
        if [ $yoffset -lt $height ]; then
            wmv 0 +$height $1
            yoffset=$((yoffset + height))
        fi

        # launch lemonbar
        # TODO: Fix center/right aligned text because the bar is only sent info once
        #       and on resize the text width isn't updated. This might not be possible
        #       as I'm resizing lemonbar using wtp and lemonbar doesn't update it's size.
        echo "%{l}   %{A:titlebar.sh -k $1 & killwa $1:}x%{A}%{l}" |
        lemonbar -p -n "tbar-$1" -d -g "$width"x"$height"+"$xoffset"+"$yoffset" -B "#$bg" -F "#$fg" -f "$font" | mksh &

        # Save window id and titlebar id to a file
        # This is how the bar/titlebar are "grouped"
        sleep .05
        titlewid=($(wattr xyhi $(lsw -o) | grep "$xoffset $yoffset $height"))
        echo "$1 ${titlewid[3]}" > /tmp/titlebar-$1
    fi
}

# Move / Resize the bar
updatebar () {
    # Create array of window info
    position=($(wattr xyw $1))

    # Name of bar
    titlewid=$(cat /tmp/titlebar-$1)

    wtp ${position[0]} $((${position[1]} - height)) ${position[2]} $height ${titlewid##* }
}

# Kill titlebar of focused window
killbar () {
    ps -ef | awk -v name="tbar-$1" '$0 ~ name {print $2}' | xargs kill 2>/dev/null
    rm "/tmp/titlebar-$1"
}

# Restart all titlebars
restartbar () {
    for window in $(lsw); do
        killbar $window
        spawnbar $window
    done
}

# Usage: titlebar.sh -r -suk windowid
while getopts "s:u:k:r" opt; do
    case $opt in
        s) spawnbar $OPTARG ;;
        u) updatebar $OPTARG ;;
        k) killbar $OPTARG ;;
        r) restartbar ;;
    esac
done
