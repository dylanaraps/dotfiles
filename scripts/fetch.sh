#!/usr/bin/env bash
# Fetch info about your system
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles


# Info Prefixes {{{
# The titles that come before the info (Ram:, Cpu:, Uptime)
# TODO: Add a way to specify these at launch.


title_os="OS"
title_kernel="Kernel"
title_uptime="Uptime"
title_packages="Packages"
title_shell="Shell"
title_windowmanager="Window Manager"
title_cpu="Cpu"
title_memory="Memory"
title_song="Song"


# }}}


# Get Info {{{
# Commands to use when gathering info


# Title (Configurable with "-t" and "--title" at launch)
# To use the usual "user@hostname" change the line below to:
# title="$(whoami)@$(hostname)"
title="dylan's pc"

# Operating System (Configurable with "-O" and "--distro" at launch)
# You can manually set this if the command below doesn't work for you.
os=$(cat /etc/*ease | awk '/^NAME=/' | sed -n 's/^NAME=//p' | tr -d '"')

# Linux kernel name/version (Configurable with "-K" and "--kernel" at launch)
kernel=$(uname -r)

# System Uptime (Configurable with "-U" and "--uptime" at launch)
uptime=$(uptime -p | sed -e 's/minutes/mins/')

# Total number of packages (Configurable with "-P" and "--packages" at launch)
# Change this to match your distro's package manager
case $os in
    "Arch Linux") packages=$(pacman -Q | wc -l) ;;
    "Fedora") packages=$(yum list installed | wc -l) ;;
    "Debian") packages=$(dpkg --list | wc -l)
esac

# Shell (Configurable with "-s" and "--shell" at launch)
shell="$SHELL"

# Window manager (Configurable with "-W" and "--windowmanager" at launch) (depends on wmctrl)
# If you'd like to set the window manager manually you can set
# the var to a string like the line below.
# windowmanager="openbox"
windowmanager=$(wmctrl -m | awk '/Name:/ {printf $2}')

# Processor (Configurable with "-C", "-S" and "--cpu", "--speed" at launch)
cpu="$(cat /proc/cpuinfo | awk '/model name/ {printf $4 " "$5 "\n" }' | sed -e '$!d' -e 's/(tm)//')"
speed="$(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"

# Memory (Configurable with "-M" and "--memory" at launch)
# Print the total amount of ram and amount of ram in use
memory=$(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')

# Currently playing song/artist (Configurable with "-m" and "--song" at launch)
song=$(mpc current | cut -c 1-30)

# Print terminal colors in a line (Configureable with "--printcols start end" at launch)
# Start/End are vars for the range of colors to print
# The default values below print 8 colors in total.
start=0
end=7

printcols () {
    for color in $(seq $start $end); do
        echo -n "\033[48;5;$color"m"       "
    done

    echo -n "\033[0m"
}


# }}}


# Custom Image {{{


# If 1, fetch will use a cropped version of your wallpaper as the image
usewall=1

# The default image to use if usewall=0
img="$HOME/Pictures/avatars/gon.png"

# Image width/height/offset
width=128
height=128
yoffset=0
xoffset=0

# Padding to align text to the right
pad="                             "


# }}}


# Text Formatting {{{


# Set to "" to disable bold text
bold="\033[1m"

# Clears formatting
clear="\033[0m"

# Default color
# colors can also be defined with a launch option: "-c"
color="\033[38;5;1m"

# }}}


# Args {{{


args=($@)

# Loop index
index=0

for argument in ${args[@]}; do
    index=$((index + 1))

    case $argument in
        -c|--color) color="\033[38;5;$2""m" ;;
        -pc|--printcols) start=$2; end=$3 ;;
        -w|--width) width="$2" ;;
        -h|--height) height="$2" ;;
        -t|--title) title="$2" ;;
        -p|--padding) pad="$2" ;;
        -x|--xoffset) xoffset="$2" ;;
        -y|--yoffset) yoffset="$2" ;;
        -W|--windowmanager) windowmanager="$2" ;;
        -O|--distro) os="$2" ;;
        -K|--kernel) kernel="$2" ;;
        -U|--uptime) uptime="$2" ;;
        -P|--packages) packages="$2" ;;
        -s|--shell) shell="$2" ;;
        -C|--cpu) cpu="$2" ;;
        -S|--cpu-speed) speed="$2" ;;
        -M|--memory) memory="$2" ;;
        -m|--song) song="$2" ;;
        --noimg) useimg=0; usewall=0 ;;
        --nowall) usewall=0 ;;
    esac

    shift
done


# }}}


# Other {{{


# If the script was called with --noimg, disable image and paddin
if [ $useimg -eq 0 ]; then
    img=""
    pad=""
fi


# }}}


# Wallpaper {{{


if [ $usewall -eq 1 ]; then
    # Get image to display from current wallpaper (only works with feh)
    wallpaper=$(cat $HOME/.fehbg | awk '/feh/ {printf $3}' | sed -e "s/'//g")
    wallname=$(basename $wallpaper)

    # Directory to store cropped wallpapers.
    walltempdir="$HOME/.wallpaper"


    if [ ! -f "$walltempdir/$wallname" ]; then
        # Check if the directory exists
        if [ ! -d "$walltempdir" ]; then
            mkdir "$walltempdir" || exit
        fi

        # Get wallpaper height so that we can do a better crop
        size=($(identify -format "%h" $wallpaper))

        # Crop the wallpaper and save it to  the wallpaperdir
        # By default we crop a square in the center of the image which is "wallpaper height x wallpaper height".
        # We then resize it to the image size specified above. (default 128x128 px, uses var $height)
        # This way we get a full image crop with the speed benefit of a tiny image.
        convert -crop "$size"x"$size"+0+0 -gravity center "$wallpaper" -resize "$height"x"$height" "$walltempdir/$wallname"
    fi

    # The final image
    img="$walltempdir/$wallname"
fi


# }}}


# Print Info {{{

# Clear terminal before running
clear

# Underline title with length of title
underline=$(printf %"${#title}"s |tr " " "-")

# Hide the terminal cursor while we print the info
# This fixes image display errors
echo -n -e "\033[?25l"
echo -e "${pad}${bold}${title}${clear}"
echo -e "${pad}${underline}"
echo -e "${pad}${bold}${color}${title_os}${clear}: $os"
echo -e "${pad}${bold}${color}${title_kernel}${clear}: $kernel"
echo -e "${pad}${bold}${color}${title_uptime}${clear}: $uptime"
echo -e "${pad}${bold}${color}${title_packages}${clear}: $packages"
echo -e "${pad}${bold}${color}${title_shell}${clear}: $shell"
echo -e "${pad}${bold}${color}${title_windowmanager}${clear}: $windowmanager"
echo -e "${pad}${bold}${color}${title_cpu}${clear}: $cpu @ $speed"
echo -e "${pad}${bold}${color}${title_memory}${clear}: $memory"
echo -e "${pad}${bold}${color}${title_song}${clear}: $song"
echo
echo
echo -e "$(printcols)"
echo
echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
# We're done! Show the cursor again
echo -n -e "\033[?25h"


# }}}
