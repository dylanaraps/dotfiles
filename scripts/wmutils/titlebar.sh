#!/bin/mksh
# Adds titlebars to windows using lemonbar
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Focused window
wid=$(pfw)

# Height of titlebar
height=30

# Ignored windows
# Windows are ignored by name, not class
ignore=(Iceweasel lemonbar popups tbar)

# Spawn the bar
spawn () {
    # Check to see if our window is ignored
    for window in ${ignore[@]}; do
        (echo "$(wname $1)" | grep -Eq  "^.*${window}.*$") && exit
    done

    # Check to see if titlebar exists and the window isn't a popup or a dock
    if [ ! -f "/tmp/titlebar-$1" ] && [ ! -z $(lsw | grep "$1") ]; then
        winfo=($(wattr xywh $1))
        width=${winfo[2]}
        xoffset=${winfo[0]}
        yoffset=$((${winfo[1]} - height))

        # If the window already has a bar kill it
        # This avoids accidental duplicates.
        ps -ef | awk -v name="tbar-$1" '$0 ~ name {print $2}' | xargs kill 2>/dev/null

        # launch lemonbar
        echo "%{l}   %{A:titlebar.sh -k $1 & killwa $1:}x%{A}%{l}" |
        lemonbar -p -n "tbar-$1" -d -g "$width"x"$height"+"$xoffset"+"$yoffset" -B "#$white" -F "#$black" -f "lemon" | mksh &

        # Save wid and titlebar wid to file
        sleep .05
        titlewid=($(wattr xyhi $(lsw -o) | grep "$xoffset $yoffset $height"))
        echo "$1 ${titlewid[3]}" > /tmp/titlebar-$1
    fi
}

# Move / Resize the bar
update () {
    # Name of bar
    winfo=($(wattr xyw $1))
    titlewid=($(cat /tmp/titlebar-$1))

    wtp ${winfo[0]} $((${winfo[1]} - height)) ${winfo[2]} $height ${titlewid[1]}
}

# Kill titlebar of focused window
killbar () {
    ps -ef | awk -v name="tbar-$1" '$0 ~ name {print $2}' | xargs kill 2>/dev/null
    rm "/tmp/titlebar-$1"
}

# Kill all titlebars
killallbar () {
    for window in $(lsw); do
        ps -ef | awk -v name="tbar-$wid" '$0 ~ name {print $2}' | xargs kill 2>/dev/null
        rm "/tmp/titlebar-$wid"
    done
}

while getopts "s:u:k:K" opt; do
    case $opt in
        s) spawn $OPTARG ;;
        u) update $OPTARG ;;
        k) killbar $OPTARG ;;
        K) killallbar ;;
    esac
done
