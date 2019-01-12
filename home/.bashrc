# Prompt
PS1='➜ '

# Envars
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000
export PATH+=:~/.local/bin:~/bin
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="chromium"
export NNN_USE_EDITOR=1

export FFF_COL4=6
export FFF_COL3=2
export FFF_COL2=4
export FFF_COL1=1

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
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias yeah="yes"
alias gj="git add .; git commit -m 'docs: update'; git push"
alias less="less -r"
alias steam="GDK_SCALE=2 com.valvesoftware.Steam"

(cat ~/.cache/wal/sequences &)

f() { fff "$@"; cd "$(< ~/.fff_d)"; pwd; }

[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
