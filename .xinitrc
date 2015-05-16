# Dylan's Xinitrc

# Sets the caps key to escape
setxkbmap -option caps:escape

# Does something (Not sure what this does)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Changes the keyboard  repeat rate
xset r rate 400 25

# Sets up multi monitor
xrandr --output DFP11 --auto --output DFP10 --auto --right-of DFP11 &

# Launches mpd
mpd &

# Starts Compton
compton -b --config ~/.compton &

# Starts i3 window manager
exec i3
