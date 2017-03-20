#!/usr/bin/env bash
#
# xinitrc

# PC/Laptop Specific commands.
if [[ "$HOSTNAME" == "bonez" ]]; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    export QT_AUTO_SCREEN_SCALE_FACTOR=1

    dunst \
        -fn "Roboto 20" \
        -geometry "600x60-80+80" &

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
    dunst &

    # Create i3 config.
    cat "${HOME}/.config/i3/base" \
        "${HOME}/.config/i3/desktop" > "${HOME}/.config/i3/config"
fi

xset m 1/1
compton &
devmon &
xrdb -merge "$HOME/.Xresources"
urxvtd -q -f &
redshift &
dropbox &

exec i3
