# ~/.bashrc
# printf '\e]710;%s\007' "9x15bold,xft:Kochi Gothic"

# Prompt
PS1='\[\e[1m\]✝\[\e[0m\] '

# Envars
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH+=:~/.gem/ruby/2.5.0/bin:~/go/bin:~/.local/bin:~/bin
export EDITOR="nvim"
export EXA_COLORS="*.*=37"

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
(cat ~/.cache/wal/sequences &)

# Aliases.
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias neofetch="clear; neofetch"
alias refugees="pacman -Qm"
alias fixwifi="sudo modprobe -r iwlmvm; sudo modprobe iwlmvm"
alias yeah="yes"
alias gj="git add .; git commit -m 'docs: update'; git push"
alias ls="exa -x --group-directories-first -a"
alias cd="lcd"

# Start x on login.
[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1

# Tmux
[[ -z "$TMUX"  ]] && exec tmux

