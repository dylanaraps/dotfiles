# Prompt
PS1='➜ '

# Envars
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export NPM_PACKAGES=~/.npm-packages
export PATH=~/wmutils:"${PATH}":~/.gem/ruby/2.5.0/bin:~/go/bin:~/.local/bin:~/bin:~/.npm-packages/bin:~/.cargo/bin/
export EDITOR="nvim"
export NNN_USE_EDITOR=1

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

# Functions.
. ~/bin/lcd
. ~/.cache/wal/colors.sh
. /usr/share/bash-completion/bash_completion
(cat ~/.cache/wal/sequences &)

# Aliases.
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias refugees="pacman -Qm"
alias fixwifi="sudo modprobe -r iwlmvm; sudo modprobe iwlmvm"
alias yeah="yes"
alias gj="git add .; git commit -m 'docs: update'; git push"
alias gv="git add .; git commit -m 'version: bump'; git push"
alias cd="lcd"
alias ls="ls --group-directories-first --color=always -A"
alias less="less -r"
alias irssi="irssi -c Freenode --nick johnblack"
alias n="nnn -i -c 1"
alias steam="GDK_SCALE=2 com.valvesoftware.Steam"

[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
