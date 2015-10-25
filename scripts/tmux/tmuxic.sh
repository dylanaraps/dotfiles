#!/bin/sh
tmux new-session -d 'music'
tmux split-window -v 'cava'
tmux split-window -v 'ncmpcpp'
tmux -2 attach-session -d
