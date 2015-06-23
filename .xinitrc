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
xset +fp ~/.fonts/sijipatched
xset fp rehash

# if pulse
pulseaudio --start &

# Sets different shadow excludes based on monitor height
if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	xrandr --output DFP10 --auto --primary --left-of DFP11 --output DFP11 --auto &
	compton -b --config ~/.compton --shadow-exclude-reg x875+0-0 &

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	compton -b --config ~/.compton --shadow-exclude-reg x743+0-0 &

else
	compton -b --config ~/.compton
fi

# Launches mpd
mpd &

# Starts i3 window manager
# exec i3

# starts bspwm
sxhkd -f 100 &
exec bspwm
