# Dylan's zhrc
export TERM=rxvt-unicode-256color

# Sets editor to neovim
export EDITOR='nvim'

# Sets ccache location to ssd
export CCACHE_DIR=~/.ccache

# Disable Ranger default config
export RANGER_LOAD_DEFAULT_RC=FALSE

# Global Variables {{{

# Crayon Dark {{{

export black="0E1114"
export gray01="222A33"
export gray02="2B3647"
export gray03="485870"
export gray04="607594"
export gray05="96B0D1"
export gray06="8F98BF"
export white="CFDAE6"
export white2="E6F2FF"

export red="734745"
export orange="997254"
export yellow="A69253"
export green="637339"
export cyan="6A9994"
export blue="406080"
export magenta="5A4080"
export pink="804060"

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

# Aliases {{{

# Remove deps not needed anymore
alias cleandeps='sudo pacman -R $(pacman -Qqdt)'

# Color Test
alias pal='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# dls video from youtube to my Music folder
alias mp3dl="cd ~/Music && youtube-dl --extract-audio --audio-format mp3"

# Creates a playlist from an ls of my Music Folder
alias lsnc="ls -A --color=none"
alias plu="lsnc ~/Music > ~/.mpd/playlists/music.m3u"

# Makes ls list all files and always use color
alias ls="ls -A --color=always"

# Peerflix
alias peerflix="peerflix --path '~/Videos/Downloads' --mpv"

# Compton
alias cmp="compton --config ~/.compton &"

# Aliases to start/kill bar
alias killbar="pkill ~/.config/lemonbar/clock.sh & pkill ~/.config/lemonbar/workspace.sh & pkill ~/.config/lemonbar/music.sh & pkill lemonbar & pkill orangebar"
alias startbar="~/dotfiles/.config/lemonbar/clock.sh & sleep .5s && ~/dotfiles/.config/lemonbar/workspace.sh & ~/dotfiles/.config/lemonbar/music.sh"

# Webdev
alias mksite="~/dotfiles/scripts/webdev/webdev.sh"

# Start ssh-agent with startx
alias startx='ssh-agent startx'

alias feh='feh --auto-zoom --scale-down -g 640 -B black'

alias wine='thread_submit=true wine'

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

if [ -d "$HOME/.gem/ruby/2.2.0/bin" ] ; then
  PATH="$home/.gem/ruby/2.2.0/bin:$PATH"
fi
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

# Assume a command is cd if it's a directory
setopt autocd
setopt sharehistory

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/builds/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
