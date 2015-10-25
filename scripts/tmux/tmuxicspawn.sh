#!/bin/bash
urxvt -hold -g 70x60 -e zsh -c ~/dotfiles/scripts/tmux/tmuxic.sh
trap 'echo -ne "\e]0;music\007"' DEBUG
