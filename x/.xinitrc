compton &
devmon &
wal -i "$HOME/Pictures/Wallpapers"
wal-set
xrdb "$HOME/.Xresources"
urxvtd -q -f &
exec i3
