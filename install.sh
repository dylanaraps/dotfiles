#!/usr/bin/env bash
#
# Install dotfiles.

q() {
    read -r -n 1 -p "$1 [y/n] " response
    printf "\n"
    [[ "${response,,}" == "y" ]] && local result=0
}

q "Install dotfiles for home?"    && stow home
q "Install dotfiles for openbox?" && stow openbox
q "Install dotfiles for (n)vim?"  && stow vim
q "Install dotfiles for mpv?"     && stow mpv
q "Install dotfiles for system (requires sudo)?" && sudo stow system -t /
