#!/bin/mksh
# Script to easily map commands to keys in openbox
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

volup () {
    # amixer set Master 5+
    pulseaudio-ctl up
    popup -e "$(amixer get Master | egrep -o '[0-9]+\%')" -w 150 -x 1670 &
}

voldown () {
    # amixer set Master 5-
    pulseaudio-ctl down
    popup -e "$(amixer get Master | egrep -o '[0-9]+\%')" -w 150 -x 1670 &
}

prevsong () {
    cmus-remote --prev
    popup -e "$(cmus-current)" -w $(txtw "$(cmus-current)") -x $((1820 - $(txtw "$(cmus-current)"))) &
}

nextsong () {
    cmus-remote --next
    popup -e "$(cmus-current)" -w $(txtw "$(cmus-current)") -x $((1820 - $(txtw "$(cmus-current)"))) &
}

togglesong () {
    cmus-remote --pause

    if [ "$(cmus-remote -Q | head -n1)" == "status playing" ]; then
        popup -e "$(cmus-current)" -w $(txtw "$(cmus-current)") -x $((1820 - $(txtw "$(cmus-current)"))) &
    else
        popup -e "Paused" -w 150 -x 1670 &
    fi
}

dmenu () {
    dmenu_recent_aliases -s 0 -nb "#$white" -nf "#$black" -sb "#$white" -sf "#$gray" -i -h 30 -w 120 -q -x 30 -y 30 -fn "-benis-lemon-medium-r-normal--10-110-75-75-m-50-ISO8859-1" -p ">" -l 1
}

screenshot () {
    popup -e "Saved Screenshot" -s 4 -w 150 -x 1670 & sleep 1; \

    # What to name the image and where to save it
    img="scrot-$(date "+%d%b")-$RANDOM.png"
    dir="$HOME/Pictures/scrots"

    # Take the scrot
    scrot -q 100 "$img" -e "mv $img $dir"

    # Crop out the surrounding monitors
    convert -crop 1920x1080+0+0 "$dir/$img" "$dir/$img"
}

minify () {
    wrs -a 355 270 $(pfw)
}

case $1 in
    volup) volup ;;
    voldown) voldown ;;
    prevsong) prevsong ;;
    nextsong) nextsong ;;
    togglesong) togglesong ;;
    dmenu) dmenu ;;
    screenshot) screenshot ;;
    minify) minify ;;
esac

