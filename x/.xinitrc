compton &
devmon &
wal -i "$HOME/Pictures/Wallpapers"
xrdb "$HOME/.Xresources"
urxvtd -q -f &
exec i3
