# Dylan's zhrc

# Set term
export TERM=rxvt-unicode-256color

# Sets editor to neovim
# export EDITOR='nvim'

# font options
export INFINALITY_FT_FILTER_PARAMS="16 20 28 20 16"

# Aliases
source ~/.zsh_aliases

# ryuuko colorscheme
# for easy use in scripts
export black="2d2b33"
export lightblack="363740"
export darkgray="75747a"
export red="BF687F"
export green="9BB38F"
export yellow="e5c196"
export blue="8294b4"
export orange="E68A8B"
export cyan="95B9BF"
export white="f2f3f2"

# lemonbar height
export barheight=30

# fzf settings
export FZF_DEFAULT_COMMAND='ag -l -g "" --hidden'

export FZF_DEFAULT_OPTS='
  --extended
  --color bg:0,bg+:0
  --multi
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Enable completion and prompt
autoload -U compinit promptinit
compinit
promptinit

# Better tab completion
zstyle ':completion:*' menu select

# Complete Aliases
setopt completealiases

# Enable colors in prompt
autoload -U colors && colors

# Set prompt
PROMPT="%{$fg_bold[white]%} %n %{$fg_no_bold[white]%}%~ %{$fg_no_bold[yellow]%}>"

# Set right prompt
RPROMPT="%{$fg_bold[red]%}%t %{$reset_color%}"

# History File
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Key binds
bindkey '^H' beginning-of-line
bindkey '^L' end-of-line

# share history
setopt sharehistory

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


