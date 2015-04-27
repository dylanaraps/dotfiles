# Sets the caps key to escape
setxkbmap -option caps:escape

# Starts i3 window manager
exec i3

# Does something
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Changes the repeat rate
xset r rate 300 25
