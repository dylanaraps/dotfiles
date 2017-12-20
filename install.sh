#!/usr/bin/env bash
#
# Install dotfiles using stow dynamically.
#
# Created by Dylan Araps.

for dir in */; do
    child=("$dir"*); root=
    [[ "${child[0]}" =~ $dir(bin|etc|var|usr|opt) ]] && root="root required"
    read -r -n 1 -p "install ${dir/\/*}${root:+ ($root)}? [y/n] " ans; echo
    [[ "${ans,,}" != "y" ]] && continue
    [[ "$root" ]] && { sudo stow "$dir" -t /;:; } || stow "$dir"
done
