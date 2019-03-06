#!/bin/sh

#
# .xinitrc

synclient AreaLeftEdge=200 AreaRightEdge=1471 AreaTopEdge=200 \
          TapButton1=1 TapButton2=3 TapButton3=2

xinput disable "Lenovo EasyCamera: Lenovo EasyC"
xinput disable "ELAN21EF:00 04F3:2200"

export PATH=${PATH}:~/.local/bin:~/bin

xset s 60 60
xset m 1/1
xset r rate 200 50

setxkbmap -option caps:escape
xmodmap -e 'keycode 70 = 0x0000'

xrdb ~/.Xresources
buddy ~/Pictures/Wallpapers
xrandr --dpi 192

exec openbox
