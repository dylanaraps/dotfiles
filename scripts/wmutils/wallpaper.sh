#!/bin/sh

blur() {
    feh --bg-fill "$HOME/Pictures/wallpaper/$1"
}

wew | while IFS=: read ev wid; do
    case $ev in
        # window creation
        16) wattr o "$wid" || test "$(lsw)" = "$wid" && blur 8-blur.jpg ;;

        # window deletion
        18) test -z "$(lsw -a)" && blur 8.jpg ;;
    esac
done
