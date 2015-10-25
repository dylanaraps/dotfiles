#!/bin/sh
query=$(wmctrl -d | grep "*" | cut -d ' ' -f 1)

if [[ $query == 0 ]]; then
	rtile.rb
else
	rtile.rb --all
fi
