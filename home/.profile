export ENV=~/.ashrc
export PS1='➜ '
export LESSHISTFILE=-
export PATH=$PATH:~/bin:~/.local/bin

echo "start X?"
read -r &&
    [ -z "$DISPLAY" ] && [ ! -e "/tmp/.X11-unix/X${DISPLAY#:}" ] &&
        exec xinit ~/.xinitrc -- /usr/bin/X :0 vt1 -keeptty
