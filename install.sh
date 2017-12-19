#!/usr/bin/env bash
#
# Install dotfiles.

q() {
    read -r -n 1 -p "$1 [y/n] " response
    printf "\n" 
    [[ "${response,,}" == "y" ]] && local result=0  
}

q "Install dotfiles for home?" && stow home
q "Install dotfiles for system (requires sudo)?" && sudo stow system -t /
