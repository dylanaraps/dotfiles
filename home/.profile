export ENV=~/.ashrc
export PS1='-> '
export LESSHISTFILE=-
export PATH=$PATH:~/bin:~/.local/bin
export QT_AUTO_SCREEN_SCALE_FACTOR=2

[ "$DISPLAY" ] || setfont ~/ter-u32n.psf.gz

read -rp "start X?" && [ -z "$DISPLAY" ] && {
    export DISPLAY=:0
    x
}
