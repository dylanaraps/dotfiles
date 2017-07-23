#!/usr/bin/env bash
#
# xinitrc

# PC/Laptop Specific commands.
if [[ "$HOSTNAME" == "bonez" ]]; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    export QT_AUTO_SCREEN_SCALE_FACTOR=1

    export DUNST_FONT='Roboto 10'
    export DUNST_SIZE='600x60-80+80'

    export BAR_FONT="xft:Roboto Mono 40"
    export BAR_HEIGHT="60"

    # Create i3 config.
    cat "${HOME}/.config/i3/base" \
        "${HOME}/.config/i3/laptop" > \
        "${HOME}/.config/i3/config"

elif [[ "$HOSTNAME" == "bones" ]]; then
    xrandr \
        --output DVI-0 \
        --primary \
        --mode 1920x1080 \
        --output HDMI-0 \
        --mode 1920x1080 \
        --below DVI-0

    export DUNST_FONT='Artwiz Lemon 7'
    export DUNST_SIZE='300x30-40+70'

    # Create i3 config.
    cat "${HOME}/.config/i3/base" \
        "${HOME}/.config/i3/desktop" > \
        "${HOME}/.config/i3/config"
fi

xset m 1/1
xset s off -dpms
setxkbmap -option caps:escape

pulseaudio --start &
dunst -fn "$DUNST_FONT" -geometry "$DUNST_SIZE" &
compton --config /dev/null &
devmon &
urxvtd -q -f &
redshift &
dropbox &

xrdb -merge "${HOME}/.Xresources"
wal -i "$(< "${HOME}/.cache/wal/wal")" -o wal-set

exec i3
