export ENV=~/.ashrc
export PATH=/usr/lib/ccache/bin:~/bin:~/.local/bin:$PATH:

[ "$DISPLAY" ] || {
    export DISPLAY=:0
    x
}
