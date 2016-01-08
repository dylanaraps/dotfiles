# Dylan's Xinitrc

# Source .Xresources
xrdb -merge ~/.Xresources

# Disable caps lock
setxkbmap -option caps:none

# Set up multi mon
xrandr --output DVI-0 --mode 1920x1080 --rate 60 --primary --left-of DVI-1 --output DVI-1 --mode 1280x1024 --rate 75 --output HDMI-0 --mode 1920x1080 --rate 60 --below DVI-0 &

# Set wallpaper
feh  --bg-fill ~/Pictures/wallpapers/wash/11.jpg &
# wall --loop 900 &

# urxvt daemon
urxvtd -q -f -o &

# bar
clock &

# Pulseaudio
pulseaudio --start &

#  Start openbox
exec openbox-session
