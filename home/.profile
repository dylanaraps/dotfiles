export ENV=~/conf/ash/rc
export PATH=/usr/lib/ccache/bin:~/bin:~/.local/bin:$PATH:

[ "$DISPLAY" ] || {
    export DISPLAY=:0
    read -r && x
}
