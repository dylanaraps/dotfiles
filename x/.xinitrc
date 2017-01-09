xrandr --output DVI-0 --primary --mode 1920x1080 --output HDMI-0 --mode 1920x1080 --below DVI-0
compton &
devmon &
dunst &
xrdb "$HOME/.Xresources"
urxvtd -q -f &
redshift &
exec i3
