#!/bin/bash
pkill wallpaper.sh &

while :; do
	feh --randomize --bg-fill ~/Pictures/papes/*
	sleep 30m
done
