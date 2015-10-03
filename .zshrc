# Dylan's zhrc
export TERM=rxvt-unicode-256color

# Sets editor to neovim
export EDITOR='nvim'

# Sets ccache location to ssd
export CCACHE_DIR=~/.ccache

# Disable Ranger default config
export RANGER_LOAD_DEFAULT_RC=FALSE

# Aliases
source ~/.zsh_aliases

# Global Variables {{{

# Crayon Dark {{{

export black="2d2b33"
export darkgray="75747a"
export red="c86c75"
export green="d1c8b8"
export yellow="e7b9ac"
export blue="757b8e"
export magenta="e47b66"
export cyan="b4bcc9"
export white="feffff"

# }}}

# Lemonbar {{{
export barfont="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
export baricons="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

export barheight=23

# }}}

# bspwm {{{

export ws1=''
export ws2=''
export ws3=''
export ws4=''

# }}}

# }}}

# FZF {{{
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
