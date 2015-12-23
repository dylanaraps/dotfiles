# Dylan's Xinitrc

# Source .Xresources
xrdb -merge ~/.Xresources

# Disable caps lock
setxkbmap -option caps:none

# Set up multi mon
xrandr --output DVI-0 --mode 1920x1080 --rate 60 --primary --left-of DVI-1 --output DVI-1 --mode 1280x1024 --rate 75 --output HDMI-0 --mode 1920x1080 --rate 60 --below DVI-0 &

mpd &

# Start urxvt daemon
urxvtd -q -f -o &

# Set wallpaper
# wall.sh --loop 900 &
feh --bg-fill ~/Pictures/wallpaper/wash/3.jpg &

#  Start openbox
exec openbox-session
