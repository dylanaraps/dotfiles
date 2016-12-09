compton &
devmon &
dunst &
wal -i "$HOME/Pictures/Wallpapers"
wal-set
xrdb "$HOME/.Xresources"
urxvtd -q -f &
exec i3
