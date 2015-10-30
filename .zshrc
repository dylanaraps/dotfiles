# Dylan's zhrc
export DE=bspwm
export TERM=rxvt-unicode-256color

# Sets editor to neovim
export EDITOR='nvim'

# Sets ccache location to ssd
export CCACHE_DIR=~/.ccache

# Disable Ranger default config
export RANGER_LOAD_DEFAULT_RC=FALSE

# font options
export INFINALITY_FT_FILTER_PARAMS="16 20 28 20 16"

# Aliases
source ~/.zsh_aliases

# Global Variables {{{

export black="2d2b33"
export darkgray="75747a"
export red="c86c75"
export green="9BB38F"
export yellow="e5c196"
export blue="8294b4"
export orange="e8907e"
export cyan="a9cdd9"
export white="f2f3f2"

export barheight=30

export FZF_DEFAULT_COMMAND='ag -l -g "" --hidden'

export FZF_DEFAULT_OPTS='
  --extended
  --color bg:0,bg+:0
  --multi
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}

# Paths {{{
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# }}}

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

PROMPT="%{$fg_bold[white]%} %n %{$fg_no_bold[white]%}%~ %{$fg_no_bold[yellow]%}>"

RPROMPT="%{$fg_bold[cyan]%}%t %{$reset_color%}"

# History File
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Url magic
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Assume a command is cd if it's a directory
setopt autocd
setopt sharehistory

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/builds/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
