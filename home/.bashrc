#
# ~/.bashrc
#

# HIDPI
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Firefox with apulse
export APULSE_PLAYBACK_DEVICE=plugdmix 

PATH+=:~/.local/bin
PATH+=:~/bin

source ~/.cache/wal/colors.sh

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty > ~/.xorg.log 2>&1

