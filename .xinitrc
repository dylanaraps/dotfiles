# Dylan's Xinitrc

# Source .Xresources
xrdb -merge ~/.Xresources

# Disable caps lock
setxkbmap -option caps:none

# Disable mousewheel as mine is fucked
xinput set-button-map 10 1 2 3 0 0

# Set up multi mon
xrandr --output DVI-0 --mode 1920x1080 --rate 60 --primary --output HDMI-0 --mode 3840x2160 --rate 30 --below DVI-0 &
# xrandr --output DVI-0 --mode 1920x1080 --rate 60 --primary

# Set wallpaper
feh  --bg-fill ~/Pictures/wallpapers/wash/22.jpg &
# wall --loop 900 &

# urxvt daemon
urxvtd -q -f -o &

# bar
clock &

# mpd
mpd &

# Pulseaudio
pulseaudio --start &

# Redshift
redshift -m randr &

# Devmon
udiskie &

# Compton
compton --backend xrender --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible --no-fading-openclose -o 0 -b

#  Start openbox
exec openbox-session
# exec /home/dyl/projects/jbwm/jbwm
# exec icewm-session

