#!/usr/bin/env bash
#
# xinitrc

# PC/Laptop Specific commands.
if [[ "$HOSTNAME" == "bonez" ]]; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    export QT_AUTO_SCREEN_SCALE_FACTOR=1

    export DUNST_FONT='Roboto 25'
    export DUNST_SIZE='600x60-80+80'

    # Create i3 config.
    cat "${HOME}/.config/i3/base" \
        "${HOME}/.config/i3/laptop" > "${HOME}/.config/i3/config"

elif [[ "$HOSTNAME" == "bones" ]]; then
    xrandr \
        --output DVI-0 \
        --primary \
        --mode 1920x1080 \
        --output HDMI-0 \
        --mode 1920x1080 \
        --below DVI-0

     export DUNST_FONT='Artwiz Lemon 7'
     export DUNST_SIZE='300x30-40+40'

    # Create i3 config.
    cat "${HOME}/.config/i3/base" \
        "${HOME}/.config/i3/desktop" > "${HOME}/.config/i3/config"
fi

pulseaudio --start &
dunst -fn "$DUNST_FONT" -geometry "$DUNST_SIZE" &
xset m 1/1
setxkbmap -option caps:escape
xset s off -dpms
compton --config /dev/null &
devmon &
xrdb -merge "$HOME/.Xresources"
urxvtd -q -f &
redshift &
dropbox &
"${HOME}/projects/wal-py/wal" -i "$(< "${HOME}/.cache/wal/wal")"

exec i3
