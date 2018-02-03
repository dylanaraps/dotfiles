#!/bin/sh
#
# .xinitrc

# My locale randomly gets set to C
# and I don't know why..
export LC_ALL=en_US.UTF-8

redshift -l "37.8136:144.9631" &
urxvtd -q -f -o &

xset s 60 60
xset m 1/1
xset r rate 200 30
setxkbmap -option caps:escape
xmodmap -e 'keycode 70 = 0x0000'
# xmodmap -e 'keycode 64 = 0x0000'

xrdb ~/.Xresources
wal -R -o wal-set
compton &
polybar bar &
xrandr --dpi 192

exec dbus-launch openbox
