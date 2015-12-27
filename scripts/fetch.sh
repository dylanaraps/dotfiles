#!/bin/mksh
# Fetch info about your system
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Formatting

# Set to nothing to disable bold text
bold=$(tput bold)

# Clears attributes
clear=$(tput sgr0)

# Default color
# colors are now defined with a launch option "-c"
color=$(tput setaf 1)

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

# Other

# Title
# title can also be changed with -t
# To use the usual "user@hostname" change the line below to:
# title="$(whoami)@$(hostname)"
title="dylan's pc"

# Custom text to print at the bottom, configurable at launch with "-e"
customtext=$(colors2.sh noblack 8)

# Clear output, set this to 0 to make calling this script from a
# while loop bareable.
clear=1

# Set up args
while getopts ":c:e:w:h:t:p:x:y:" opt; do
    case $opt in
        c) color=$(tput setaf $OPTARG) ;;
        C) clear=0 ;;
        e) customtext="$OPTARG" ;;
        w) width="$OPTARG" ;;
        h) height="$OPTARG" ;;
        t) title="$OPTARG" ;;
        p) pad="$OPTARG" ;;
        x) xoffset="$OPTARG" ;;
        y) yoffset="$OPTARG" ;;
    esac
done

# Get image from wallpaper
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

# Underline title with length of title
underline=$(printf %"${#title}"s |tr " " "-")

# Start printing info

# Clear terminal before running
if [ $clear -eq 1 ]; then
    clear
fi

echo "${pad}${bold}$title${clear}"
echo "${pad}$underline"
echo "${pad}${bold}${color}OS${clear}: $(cat /etc/*ease | awk '/^NAME=/' | cut -d '"' -f2)"
echo "${pad}${bold}${color}Kernel${clear}: $(uname -r)"
echo "${pad}${bold}${color}Uptime${clear}: $(uptime -p | sed -e 's/minutes/mins/')"
echo "${pad}${bold}${color}Packages${clear}: $(pacman -Q | wc -l)"
echo "${pad}${bold}${color}Shell${clear}: $SHELL"
echo "${pad}${bold}${color}Window Manager${clear}: openbox"
echo "${pad}${bold}${color}Cpu${clear}: AMD FX-6300 @ $(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"
echo "${pad}${bold}${color}Ram${clear}: $(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')"
echo "${pad}${bold}${color}Song${clear}: $(mpc current | cut -c 1-30)"
echo
echo "$customtext"
echo

echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
