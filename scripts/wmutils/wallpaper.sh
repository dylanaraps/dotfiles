#!/bin/sh

blur() {
    feh --bg-fill "$HOME/Pictures/wallpaper/$1"
}

wew | while IFS=: read ev wid; do
    case $ev in
        # window creation
        16) wattr o "$wid" || test "$(lsw)" = "$wid" && blur 2-blur.jpg ;;

        # window deletion
        18) test -z "$(lsw)" && blur 2.jpg ;;
    esac
done
