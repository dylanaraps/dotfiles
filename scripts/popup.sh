#!/bin/mksh
# Notifications using lemonbar
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

# Variables

barname="popups"
sleep=2

width=300
height=75
xoffset=2700
yoffset=100

bg="#$white"
fg="#$gray"

font="roboto-16"

# Options

while getopts "w:h:x:y:bg:fg:n:s:f:e:" opt; do
    case $opt in
        w) width="$OPTARG" ;;
        h) height="$OPTARG" ;;
        x) xoffset="$OPTARG" ;;
        y) yoffset="$OPTARG" ;;
        bg) bg="$OPTARG" ;;
        fg) fg="$OPTARG" ;;
        n) barname="$OPTARG" ;;
        s) sleep="$OPTARG" ;;
        f) font="$OPTARG" ;;
        e) echo="$OPTARG" ;;
    esac
done

# Start bar

# Kill previous notifications
ps -ef | awk -v name="$barname" '$0 ~ name {print $2}' | xargs kill 2>/dev/null

# Echo notifivation
(echo "%{c} $echo %{c}"; sleep $sleep) |

# Pipe to bar
lemonbar -n "$barname" -g "$width"x"$height"+"$xoffset"+"$yoffset" -f "$font" -B "$bg" -F "$fg"
