#!/bin/sh
# Notifications using lemonbar
# $1 gets sent to lemonbar and $2 is the sleep duration

(echo "%{c} $1 %{c}"; sleep $2) | lemonbar -d -g "150x30+1280+1015" -f "drift" -B "#$white" -F "#$black"

