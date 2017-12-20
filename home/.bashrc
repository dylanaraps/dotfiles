# ~/.bashrc
export PS1="\[\e[32m\]\u \[\e[90m\]\w \[\e[31m\]>\[\e[0m\] "
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export APULSE_PLAYBACK_DEVICE=plugdmix

PATH+=:~/.local/bin
PATH+=:~/bin

. ~/.cache/wal/colors.sh

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
