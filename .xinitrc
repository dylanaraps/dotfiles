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
xset +fp /usr/share/fonts/envypnforpowerline
xset +fp /usr/share/fonts/envypn
xset +fp /usr/share/fonts/sijipatched
xset fp rehash

# Sets up multi monito
xrandr --output DFP11 --auto --output DFP10 --auto --right-of DFP11 &

# Starts mpd
mpd &

# Starts Compton
compton -b --config ~/.compton &

# Starts i3 window manager
exec i3
