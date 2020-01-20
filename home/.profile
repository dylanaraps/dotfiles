export ENV=~/.ashrc

[ "$DISPLAY" ] || setfont ~/ter-u32n.psf.gz

read -rp "start X?" && [ -z "$DISPLAY" ] && {
    export DISPLAY=:0
    x
}
