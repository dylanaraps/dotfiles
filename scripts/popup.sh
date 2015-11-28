#!/bin/sh
# Notifications using lemonbar

# Variables

barname="popups"
sleep=2

width=150
height=30
xoffset=1800
yoffset=35

bg="#$white"
fg="#$black"

font="drift"

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

# Kill previous notifications
ps -ef | awk -v name="$barname" '$0 ~ name {print $2}' | xargs kill 2>/dev/null

# Start notification
(echo "%{c} $echo %{c}"; sleep $sleep) | lemonbar -n "$barname" -d -g "$width"x"$height+$xoffset+$yoffset" -f "$font" -B "$bg" -F "$fg"

