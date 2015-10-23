#!/bin/bash
while :; do
	find ~/Pictures/papes4 -type f \( -name '*.*' \) -print0 |
    shuf -n1 -z | xargs -0 feh --bg-fill
    sleep 15m
done
