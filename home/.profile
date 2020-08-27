export ENV=$HOME/conf/ash/rc
export PATH=/usr/lib/ccache/bin:$HOME/bin:$HOME/.local/bin:$PATH:

[ "$DISPLAY" ] || {
    export DISPLAY=:0
    read -r && x
}
