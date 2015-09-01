# Dylan's zhrc

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export TERM=rxvt-unicode-256color

# Zsh settings
ZSH_THEME="fishy"
DEFAULT_USER="dylan"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git)

# User configuration
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Sets editor to neovim
export EDITOR='nvim'

# Global Variables {{{

# Crayon  {{{

# Crayon

export black="101112"
export gray01="282C33"
export gray02="383E47"
export gray03="586270"
export gray04="798494"
export gray05="A7AFBA"
export gray06="CCCCCC"
export white="DCE3EA"

export red="B27B78"
export orange="C48D62"
export yellow="D8C27A"
export green="99AE63"
export cyan="8DC9C3"
export blue="7495B6"
export magenta="B59CD8"
export pink="CC99B3"

# }}}

# Lemonbar {{{
export barfont="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
export baricons="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

export barheight=20

# }}}

# bspwm {{{

export ws1=''
export ws2=''
export ws3=''
export ws4=''

# }}}

# }}}

# Aliases {{{

# Color Test
alias pal='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Starts nethogs and uses my lan card
alias nh="sudo nethogs enp5s0"

# dls video from youtube to my Music folder
alias mp3dl="cd ~/Music && youtube-dl --extract-audio --audio-format mp3"

# Creates a playlist from an ls of my Music Folder
alias lsnc="ls -A --color=none"
alias plu="cd ~/Music && lsnc > ~/.mpd/playlists/music.m3u"

# Makes ls list all files and always use color
alias ls="ls -A --color=always"

# Peerflix
alias pf="peerflix --path '~/Videos/Downloads' --mpv"

# Compton
alias cmp="compton -b --config ~/.compton"

# Aliases to start/kill bar
alias killbar="pkill ~/.config/lemonbar/clock.sh & pkill ~/.config/lemonbar/workspace.sh & pkill ~/.config/lemonbar/music.sh & pkill lemonbar & pkill orangebar"
alias startbar="~/dotfiles/.config/lemonbar/clock.sh & sleep .5s && ~/dotfiles/.config/lemonbar/workspace.sh & ~/dotfiles/.config/lemonbar/music.sh"

# Webdev
alias mksite="~/.dotfiles/scripts/webdev/webdev.sh"

# Start ssh-agent with startx
alias startx='ssh-agent startx'

alias feh='feh --auto-zoom --scale-down -g 640 -B black'

alias battle.net='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Battle.net/Battle.net.exe &'

# }}}

export FZF_DEFAULT_COMMAND='ag -l -g "" --hidden'

export FZF_DEFAULT_OPTS='
  --extended
  --color bg:0,bg+:0
  --multi
'

# Misc
# Enables the help command
autoload -U compinit
compinit

autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help

setopt nohashdirs

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.gem/ruby/2.2.0/bin" ] ; then
  PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
fi
