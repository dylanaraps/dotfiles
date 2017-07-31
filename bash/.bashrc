# Dylan's .bashrc


export PS1
PS1="\w \[$(tput setaf 6)\]ily \[$(tput sgr0)\]"

PATH="${PATH}:${HOME}/bin"
PATH="${HOME}/.gem/ruby/2.4.0/bin:${PATH}"
PATH="${PATH}:${HOME}/.local/bin/"

export XDG_CONFIG_HOME="${HOME}/.config"
export STEAM_FRAME_FORCE_CLOSE=0
export EDITOR="nvim"
export SDL_VIDEO_X11_DGAMOUSE=0
export MOZ_USE_OMTC=1
export HISTCONTROL=ignoredups
export NNN_USE_EDITOR=1
export NNN_DE_FILE_MANAGER=thunar

source "${HOME}/.cache/wal/colors.sh"

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Check window size after every command.
shopt -s checkwinsize


# ALIASES

alias handbrake="ghb"
alias mp3="youtube-dl --extract-audio --audio-format mp3"
alias n=nnn
alias steam="steam-native"
alias sxiv="sxiv -b -s f"
alias album="youtube-dl --extract-audio --audio-format mp3 \
    -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias bum="bum --size 150"


# OTHER

[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && \
    exec startx -- vt1 &> /dev/null

# Import colorscheme from 'wal'
(wal -r"${VTE_VERSION:+"t"}" &)
