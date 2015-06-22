# Dylan's Xinitrc
xrdb -merge ~/.Xresources

# Sets the caps key to escape
setxkbmap -option caps:escape

# Does something (Not sure what this does)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Changes the keyboard  repeat rate
xset r rate 400 25

# Disables Mouse Accel
xset m 0/0 0

# Sets font directory for enypn
xset +fp /usr/share/fonts/envypn
xset +fp /usr/share/fonts/siji
xset +fp ~/.fonts/sijipatched
xset fp rehash

# Launches mpd
mpd &

# Starts Compton
compton -b --config ~/.compton &

# Devmon
devmon &

# Starts i3 window manager
exec i3
