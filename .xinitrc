# Dylan's Xinitrc
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Sets the caps key to escape
setxkbmap -option caps:escape

# Changes the keyboard  repeat rate
xset r rate 400 25

# Disables Mouse Accel
xset m 0/0 0

# Font paths
xset +fp /usr/share/fonts/envypnforpowerline
xset +fp /usr/share/fonts/envypn
xset +fp /usr/share/fonts/sijipatched
xset +fp ~/.fonts/sijipatched
xset fp rehash

# Start Pulseaudio
pulseaudio --start &

# Multi monitor
if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	xrandr --output DFP10 --auto --primary --left-of DFP11 --output DFP11 --auto &
fi

# Launches mpd
mpd &

# auto usb mount
devmon &

# Compton
compton -b --config ~/.compton

# starts bspwm
sxhkd -f 100 &
exec bspwm
