# ~/.bashrc
export PS1='\[\e[32m\]\u \[\e[90m\]\w \[\e[31m\]>\[\e[0m\] '
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH+=:~/.local/bin
export PATH+=:~/bin

# Shell settings.
shopt -s checkwinsize
complete -d cd

# Better TAB completion.
bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set page-completions off'
bind 'set menu-complete-display-prefix on'
bind 'set completion-query-items 0'

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Aliases.
alias wifi-menu="sudo wifi-menu -o"
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias neofetch="clear; neofetch"
alias refugees="pacman -Qm"

# pywal.
. ~/.cache/wal/colors.sh
cat ~/.cache/wal/sequences

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
