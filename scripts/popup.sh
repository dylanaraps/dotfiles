#!/bin/sh
# Notifications using lemonbar

# USAGE:
# $1 gets displayed
# $2 sleep duration
# $3 notification width
# $4 xoffset

# Kill previous notifications
ps -ef | awk '/popups/ {print $2}' | xargs kill

# Start notification
(echo "%{c} $1 %{c}"; sleep $2) | lemonbar -n "popups" -d -g "$3x30+$4+35" -f "drift" -B "#$white" -F "#$black"


