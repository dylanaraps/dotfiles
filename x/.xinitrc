xrandr --output DVI-I-0 --primary --mode 1920x1080 --output HDMI-A-0 --mode 1920x1080 --below DVI-I-0
xset m 1/1
compton &
devmon &
dunst &
xrdb "$HOME/.Xresources"
urxvtd -q -f &
redshift &
mopidy &
dropbox &
exec i3
