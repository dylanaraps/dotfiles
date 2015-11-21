#!/bin/sh
tmux new-session -d 'music'
tmux new-window '~/dotfiles/scripts/cover.sh'
tmux split-window -v 'ncmpcpp'
tmux select-pane -U
tmux split-window -h 'cava'
tmux select-pane -D
tmux set status off
tmux -2 attach-session -d
