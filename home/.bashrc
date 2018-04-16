# ~/.bashrc

# Prompt
export PROMPT_COMMAND='printf "\\e[38;5;8m%$((COLUMNS - 5))s%(%l:%M)T\\e[0m\\r"'
export PS1='\[\e[8m\]✝\[\e[0m\] '

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH="${HOME}/.gem/ruby/2.5.0/bin:${PATH}"
export PATH="$PATH:$HOME/go/bin"
export PATH+=:~/.local/bin
export PATH+=:~/bin
export EDITOR="nvim"
export EXA_COLORS="*.*=37"

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

# Functions.
. ~/bin/lcd

# Aliases.
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias neofetch="clear; neofetch"
alias refugees="pacman -Qm"
alias fixwifi="sudo modprobe -r iwlmvm; sudo modprobe iwlmvm"
alias yeah="yes"
alias gj="git add .; git commit -m .; git push"
alias ls="exa -x --group-directories-first -a"
alias cd="lcd"

# pywal.
(cat ~/.cache/wal/sequences &)

# Start x on login.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1
