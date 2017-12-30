# ~/.bashrc
export PS1='\[\e[32m\]\u \[\e[90m\]\w \[\e[31m\]>\[\e[0m\] '
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export APULSE_PLAYBACK_DEVICE=plugdmix
export HISTCONTROL=ignoredups
export HISTSIZE=1000000

PATH+=:~/.local/bin
PATH+=:~/bin

. ~/.cache/wal/colors.sh

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias wifi-menu="sudo wifi-menu -o"
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias neofetch="clear; neofetch"
alias refugees="pacman -Qm"

cat ~/.cache/wal/sequences

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
