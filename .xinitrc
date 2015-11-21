# Dylan's Xinitrc

xrdb -merge ~/.Xresources

xrandr --output DVI-0 --mode 1920x1080 --rate 60 --primary --left-of DVI-1 --output DVI-1 --mode 1280x1024 --rate 75 --output HDMI-0 --mode 1920x1080 --rate 60 --below DVI-0 &

sxhkd -f 100 &

~/dotfiles/scripts/wmutils/focus_watcher.sh &

mpd &

urxvtd &

# Launch openbox
exec sh -c 'while :; do sleep 10; done'
