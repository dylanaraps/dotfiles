export ENV=~/.ashrc

read -rp "start X?" && [ -z "$DISPLAY" ] && {
    export DISPLAY=:0
    x
}
