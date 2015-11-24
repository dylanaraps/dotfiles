#!/bin/sh
urxvt -name music -g 56x29+1422+607 -e zsh -c 'tmux attach-session'
mpc update
mpc update



