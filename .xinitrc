# Dylan's Xinitrc
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Sets the caps key to escape
setxkbmap -option caps:escape

# Changes the keyboard  repeat rate
xset r rate 400 25

# Disables Mouse Accel
xset m 0/0 0

# Font paths
xset +fp /usr/share/fonts/envypn
xset +fp /usr/share/fonts/Montana/
xset +fp /usr/share/fonts/misc/
xset +fp /usr/share/fonts/artwiz-fonts/
xset +fp ~/.fonts
xset fp rehash

# starts bspwm
sxhkd -f 100 &
exec bspwm
