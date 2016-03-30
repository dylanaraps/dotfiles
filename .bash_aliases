# Dylan's shell aliases and functions


# Aliases {{{


# Remove orphaned package dependencies
alias cleandeps='sudo pacman -Rns $(pacman -Qtdq)'

# Download youtube url to an .mp3
# and save it to my music folder.
alias mp3dl="cd $HOME/Music && youtube-dl --extract-audio -f bestaudio --audio-format mp3 --no-playlist"

# Creates a playlist from an ls of my Music Folder
alias lsnc="ls -A --color=none"
alias plu="lsnc $HOME/Music > $HOME/.mpd/playlists/music.m3u"

# pwd
alias pwd.sh="cd $HOME/pwd.sh && ./pwd.sh"

# Makes ls list all files and always use color
alias ls="ls -A --color=always --group-directories-first"

# Always open urxvt clients
alias urxvt="urxvtc"

# Launch sxiv without the bottom bar
alias sxiv="sxiv -b"

# Gen neovim scheme
# This line doesn't work inside of gencol.sh for some reason
alias nvimgen="erb -T - ~/dotfiles/colorschemes/ryuuko/ryuuko.erb > ~/dotfiles/colorschemes/ryuuko/colors/ryuuko.vim"

# Record screen
alias record="ffmpeg -f x11grab -s 1920x1080 -framerate 60 -an -i :0.0 -c:v libvpx -b:v 5M -crf 10 -quality realtime -y -loglevel quiet"

alias fetch2="fetch \
--block_range 1 8 \
--line_wrap off \
--bold off \
--uptime_shorthand on \
--gtk_shorthand on \
--gpu_shorthand on \
--colors 4 1 8 8 8 7 \
--gtk3 off \
"

alias vbox="sudo modprobe vboxdrv vboxnetflt vboxnetadp vboxguest vboxsf vboxvideo"

alias fixtime="sudo ntpd -qg"
alias mlg="livestreamer http://tv.majorleaguegaming.com/channel/csgo 720p --player mpv"

# }}}



