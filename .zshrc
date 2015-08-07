# Dylan's zhrc

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Sets xfce4-terminal colors to 256
if [[ "$COLORTERM" == "xfce4-terminal" ]]; then
	export TERM=xterm-256color
else
	export TERM=xterm
fi

# Base16 Shell
BASE16_SHELL="/usr/share/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

# Aliases {{{

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
alias startbar="~/.dotfiles/.config/lemonbar/clock.sh & sleep .5s && ~/.dotfiles/.config/lemonbar/workspace.sh & ~/.dotfiles/.config/lemonbar/music.sh"

# }}}

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

