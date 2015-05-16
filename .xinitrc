# Sets the caps key to escape
setxkbmap -option caps:escape


# Does something
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Changes the repeat rate
xset r rate 400 25

# Disable Screensaver
xset -dpms s off

xset +fp /usr/share/fonts
xset fp rehash

xrandr --output DFP11 --auto --output DFP10 --auto --right-of DFP11 &
mpd &

compton -b --config ~/.compton &

# Starts i3 window manager
exec i3
# sxhkd &
# exec bspwm
