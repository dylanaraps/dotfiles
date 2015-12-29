#!/usr/bin/env bash
# Fetch info about your system
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles


# General Info
# Commands to use when gathering info


# Title (Configurable with "-t" at launch)
# To use the usual "user@hostname" change the line below to:
# title="$(whoami)@$(hostname)"
title="dylan's pc"

# Operating System (Configurable with "-O" at launch)
# You can manually set this if the command below doesn't work for you.
os=$(cat /etc/*ease | awk '/^NAME=/' | sed -n 's/^NAME=//p' | tr -d '"')

# Linux kernel name/version (Configurable with "-K" at launch)
kernel=$(uname -r)

# System Uptime (Configurable with "-U" at launch)
uptime=$(uptime -p | sed -e 's/minutes/mins/')

# Total number of packages (Configurable with "-P" at launch)
# Change this to match your distro's package manager
packages=$(pacman -Q | wc -l)

# Shell (Configurable with "-s" at launch)
shell="$SHELL"

# Window manager (Configurable with "-W" at launch) (depends on wmctrl)
# If you'd like to set the window manager manually you can set
# the var to a string like the line below.
# windowmanager="openbox"
windowmanager=$(wmctrl -m | awk '/Name:/ {printf $2}')

# Processor (Configurable with "-C" and "-S" at launch)
cpu="$(cat /proc/cpuinfo | awk '/model name/ {printf $4 " "$5 "\n" }' | sed -e '$!d' -e 's/(tm)//')"
speed="$(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"

# Memory (Configurable with "-M" at launch)
# Print the total amount of ram and amount of ram in use
memory=$(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')

# Currently playing song/artist (Configurable with "-m" at launch)
song=$(mpc current | cut -c 1-30)

# Custom text (Configurable with "-e" at launch)
# By default it uses my colors2.sh script, you can find it here:
# https://github.com/dylanaraps/dotfiles/blob/master/scripts/other/colors2.sh
customtext=$(colors2.sh noblack 8)


# Custom Image


# If usewall=1 then fetch will use a cropped version of your wallpaper as the img
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


# Text Formatting


# Set to "" to disable bold text
bold="\033[1m"

# Clears formatting
clear="\033[0m"

# Default color
# colors can also be defined with a launch option: "-c"
color="\033[38;5;1m"


# Args


args=($@)

# Loop index
index=0

for argument in ${args[@]}; do
    index=$((index + 1))

    case $argument in
        -c|--color) color="\033[38;5;$2""m" ;;
        -w|--width) width="$2" ;;
        -h|--height) height="$2" ;;
        -t|--title) title="$2" ;;
        --padding) pad="$2" ;;
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
    esac

    shift
done


# Wallpaper


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


# Print Info

# Clear terminal before running
clear

# Underline title with length of title
underline=$(printf %"${#title}"s |tr " " "-")

# Hide the terminal cursor while we print the info
# This fixes image display errors
echo -n -e "\033[?25l"
echo -e "${pad}${bold}$title${clear}"
echo -e "${pad}$underline"
echo -e "${pad}${bold}${color}OS${clear}: $os"
echo -e "${pad}${bold}${color}Kernel${clear}: $kernel"
echo -e "${pad}${bold}${color}Uptime${clear}: $uptime"
echo -e "${pad}${bold}${color}Packages${clear}: $packages"
echo -e "${pad}${bold}${color}Shell${clear}: $shell"
echo -e "${pad}${bold}${color}Window Manager${clear}: $windowmanager"
echo -e "${pad}${bold}${color}Cpu${clear}: $cpu @ $speed"
echo -e "${pad}${bold}${color}Ram${clear}: $memory"
echo -e "${pad}${bold}${color}Song${clear}: $song"
echo -e
echo -e "$customtext"
echo -e
echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
# We're done! Show the cursor again
echo -n -e "\033[?25h"
