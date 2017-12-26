#!/bin/sh
#
# .xinitrc
redshift -l "37.8136:144.9631" &
urxvtd -q -f -o &

xset s 60 60
xset m 1/1
xset r rate 200 30
setxkbmap -option caps:escape

xrdb ~/.Xresources
bar &
wal -R -o wal-set
xrandr --dpi 144

exec dbus-launch openbox
