#!/bin/mksh
# Fetch info about your system
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles


# General Settings


# Title (Can also be changed with -t at launch)
# To use the usual "user@hostname" change the line below to:
# title="$(whoami)@$(hostname)"
title="dylan's pc"

# Window manager (Also configurable with -m at launch)
# If you'd like to set the window manager manually you can set
# the var to a string like the line below.
# windowmanager="openbox"
windowmanager=$(wmctrl -m | awk '/Name:/ {printf $2}')

# Custom text to print at the bottom, configurable at launch with "-e"
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


# Other


# Underline title with length of title
underline=$(printf %"${#title}"s |tr " " "-")

# Set args
while getopts ":c:e:w:h:m:t:p:x:y:" opt; do
    case $opt in
        c) color="\033[38;5;$OPTARG""m" ;;
        e) customtext="$OPTARG" ;;
        w) width="$OPTARG" ;;
        h) height="$OPTARG" ;;
        m) windowmanager="$OPTARG" ;;
        t) title="$OPTARG" ;;
        p) pad="$OPTARG" ;;
        x) xoffset="$OPTARG" ;;
        y) yoffset="$OPTARG" ;;
    esac
done

# Clear terminal before running
clear

# Get image to display from current wallpaper
# Requires feh
if [ $usewall -eq 1 ]; then
    wallpaper=$(cat $HOME/.fehbg | awk '/feh/ {printf $3}' | sed -e "s/'//g")

    # Directory to store cropped wallpapers.
    walltempdir="$HOME/.wallpaper"

    # Check if the directory exists
    if [ ! -d "$walltempdir" ]; then
        mkdir "$walltempdir" || echo "Failed to create wallpaper dir"; exit
    fi

    # Crop the wallpaper and save it to  the wallpaperdir
    # By default it crops a 1080x1080 square in the center of the image.
    [ -f "$walltempdir/$(basename $wallpaper)" ] || convert -crop 1080x1080+480+0 "$wallpaper" "$walltempdir/$(basename $wallpaper)"

    # The final image
    img="$walltempdir/$(basename $wallpaper)"
fi

# Start printing info

echo "${pad}${bold}$title${clear}"
echo "${pad}$underline"
echo "${pad}${bold}${color}OS${clear}: $(cat /etc/*ease | awk '/^NAME=/' | cut -d '"' -f2)"
echo "${pad}${bold}${color}Kernel${clear}: $(uname -r)"
echo "${pad}${bold}${color}Uptime${clear}: $(uptime -p | sed -e 's/minutes/mins/')"
echo "${pad}${bold}${color}Packages${clear}: $(pacman -Q | wc -l)"
echo "${pad}${bold}${color}Shell${clear}: $SHELL"
echo "${pad}${bold}${color}Window Manager${clear}: $windowmanager"
echo "${pad}${bold}${color}Cpu${clear}: AMD FX-6300 @ $(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"
echo "${pad}${bold}${color}Ram${clear}: $(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')"
echo "${pad}${bold}${color}Song${clear}: $(mpc current | cut -c 1-30)"
echo
echo "$customtext"
echo
echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
