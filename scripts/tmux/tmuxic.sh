#!/bin/sh
trap 'echo -ne "\e]0;music\007"' DEBUG
tmux new-session -d 'music'
tmux new-window '~/dotfiles/scripts/cover.sh'
tmux split-window -v 'ncmpcpp'
tmux select-pane -U
tmux split-window -h 'cava'
tmux select-pane -D
tmux -2 attach-session -d
