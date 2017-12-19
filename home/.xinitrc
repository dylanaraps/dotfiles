#!/usr/bin/env bash
#
# xinitrc
pulseaudio --start &
devmon &
redshift &
xrdb -merge "${HOME}/.Xresources"
urxvtd -q -f -o & 
xrandr --dpi 144
wal -R
xset s 60 60 

exec dbus-launch openbox
