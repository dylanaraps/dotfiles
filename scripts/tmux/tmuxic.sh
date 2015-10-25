#!/bin/sh
trap 'echo -ne "\e]0;music\007"' DEBUG
tmux new-session -d 'music'
tmux new-window 'cava'
tmux split-window -v 'ncmpcpp'
tmux -2 attach-session -d
