# Dylan's Xinitrc

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Sets the caps key to escape
setxkbmap -option caps:escape

# Changes the keyboard  repeat rate
xset r rate 400 25

# Disables Mouse Accel
xset m 0/0 0

# Font paths
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/Montana/
xset +fp /usr/share/fonts/misc/
xset +fp ~/.fonts
xset fp rehash

# Launch openbox
exec openbox-session
